//
//  SourceEditorCommand.swift
//  EditorPlugin
//
//  Created by Tomoya Hirano on 2016/07/09.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
  func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: (NSError?) -> Void ) -> Void{
    
    guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
      completionHandler(NSError(domain: "SampleExtension", code: -1, userInfo: [NSLocalizedDescriptionKey: "None selection"]))
      return
    }
    
    guard selection.start.line == selection.end.line else {
      completionHandler(NSError(domain: "SampleExtension", code: -1, userInfo: [NSLocalizedDescriptionKey: "None selection"]))
      return
    }
    
    
    let lineIndex = selection.start.line
    let selectionlineString = invocation.buffer.lines[lineIndex] as! NSString
    
    let startColumn = selection.start.column
    let endColumn = selection.end.column
    let selectionRange = NSRange(location: startColumn, length: endColumn-startColumn+1)
    let selectionRangeString = selectionlineString.substring(with: selectionRange)
    

    CodicAPI.getTranslate(text: selectionRangeString, success: { (response) in
      guard let transratedText = response.items.first?.translatedText else { return }
      let replacedString = selectionlineString.replacingOccurrences(of: selectionRangeString, with: transratedText)
      invocation.buffer.lines[lineIndex] = replacedString
      completionHandler(nil)
    }) { (error) in
      completionHandler(NSError(domain: "SampleExtension", code: -1, userInfo: [NSLocalizedDescriptionKey: "None selection"]))
    }
  }
}



extension Dictionary where Key: StringLiteralConvertible, Value: StringLiteralConvertible {
  var toQuery: String {
    let parameterArray = self.map { (key, value) -> String in
      guard let key = key as? String else { return "" }
      guard let value = value as? String else { return "" }
      guard let percentEscapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return "" }
      guard let percentEscapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return "" }
      return "\(percentEscapedKey)=\(percentEscapedValue)"
    }
    return parameterArray.joined(separator: "&")
  }
}


extension NSString {
  // Remove the given characters in the range
  func remove(characters: [Character], in range: NSRange) -> NSString {
    var cleanString = self
    for char in characters {
      cleanString = cleanString.replacingOccurrences(of: String(char), with: "", options: NSString.CompareOptions.caseInsensitive, range: range)
    }
    return cleanString
  }
}
