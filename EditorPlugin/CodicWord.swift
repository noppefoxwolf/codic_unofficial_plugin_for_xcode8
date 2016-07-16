//
//  CodicWord.swift
//  Codic
//
//  Created by Tomoya Hirano on 2016/07/16.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation

class CodicWord {
  init(json: Dictionary<String, AnyObject>) {
    successful = json["successful"] as? Bool ?? false
    text = json["text"] as? String ?? ""
    translatedText = json["translated_text"] as? String ?? ""
    if let candidatesJson = json["candidates"] as? [Dictionary<String, AnyObject>] {
      candidates = candidatesJson.flatMap { CodicCandidate(json: $0) }
    }
  }
  
  var successful = false
  var text = ""
  var translatedText = ""
  var candidates = [CodicCandidate]()
}
