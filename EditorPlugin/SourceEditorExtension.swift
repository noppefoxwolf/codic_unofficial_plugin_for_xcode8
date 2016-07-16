//
//  SourceEditorExtension.swift
//  EditorPlugin
//
//  Created by Tomoya Hirano on 2016/07/09.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation
import XcodeKit

final class SourceEditorExtension: NSObject, XCSourceEditorExtension {
  func extensionDidFinishLaunching() {
    print("Extension launched...")
  }
}
