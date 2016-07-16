//
//  SourceEditorCommand.swift
//  EditorPlugin
//
//  Created by Tomoya Hirano on 2016/07/09.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation
import XcodeKit

final class SourceEditorCommand: NSObject, XCSourceEditorCommand {
  func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: (NSError?) -> Void ) -> Void{
    
    guard invocation.buffer.isSingleLineOfSelection else {
      completionHandler(createError(message: "Not support multiple line."))
      return
    }
    guard let selectionRangeString = invocation.buffer.getSelectionString() else {
      completionHandler(createError(message: "Selection not found."))
      return
    }
    CodicAPI.getTranslate(text: selectionRangeString, success: { (response) in
      guard let transratedText = response.items.first?.translatedText else {
        completionHandler(self.createError(message: "Not found translate word."))
        return
      }
      if invocation.buffer.replaceSelectionString(text: transratedText) {
        completionHandler(nil)
      } else {
        completionHandler(self.createError(message: "Failed replace selection."))
      }
    }) { (error) in
      completionHandler(self.createError(message: "API Error."))
    }
  }
  
  private func createError(message: String) -> NSError {
    return NSError(domain: "Codic Plugin",
                              code: -1,
                              userInfo: [NSLocalizedDescriptionKey: message])
  }
}





