//
//  XCSourceTextBuffer+Extensions.swift
//  Codic
//
//  Created by Tomoya Hirano on 2016/07/17.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation
import XcodeKit

extension XCSourceTextBuffer {
  var isSingleLineOfSelection: Bool {
    return selections.count == 1
  }
  
  var startLine: Int? {
    guard let selection = selections.firstObject as? XCSourceTextRange else { return nil }
    return selection.start.line
  }
  
  var endLine: Int? {
    guard let selection = selections.lastObject as? XCSourceTextRange else { return nil }
    return selection.end.line
  }
  
  //supported single line
  func getSelectionLineString() -> String? {
    guard let startLine = startLine else { return nil }
    return lines[startLine] as? String
  }
  
  //supported single line
  func getSelectionString() -> String? {
    guard let selectionLineString = getSelectionLineString() else { return nil }
    guard let selection = selections.firstObject as? XCSourceTextRange else { return nil }
    let startColumn = selection.start.column
    let endColumn = selection.end.column
    
    let start = selectionLineString.index(selectionLineString.startIndex, offsetBy: startColumn)
    let end = selectionLineString.index(selectionLineString.startIndex, offsetBy: endColumn)
    let selectionRangeString = selectionLineString[start..<end]
    return selectionRangeString
  }
  
  //supported single line
  func replaceSelectionString(text: String) -> Bool {
    guard let line = getSelectionLineString() else { return false }
    guard let word = getSelectionString() else { return false }
    guard let startLine = startLine else { return false }
    let replacedString = line.replacingOccurrences(of: word,
                                                   with: text)
    lines[startLine] = replacedString
    return true
  }
}
