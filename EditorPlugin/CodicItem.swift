//
//  CodicItem.swift
//  Codic
//
//  Created by Tomoya Hirano on 2016/07/16.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation

class CodicItem {
  init(json: Dictionary<String, AnyObject>) {
    successful = json["successful"] as? Bool ?? false
    text = json["text"] as? String ?? ""
    translatedText = json["translated_text"] as? String ?? ""
    if let wordsJson = json["words"] as? [Dictionary<String, AnyObject>] {
      words = wordsJson.flatMap{ CodicWord(json: $0) }
    }
  }
  
  var successful: Bool = false
  var text: String = ""
  var translatedText = ""
  var words = [CodicWord]()
}
