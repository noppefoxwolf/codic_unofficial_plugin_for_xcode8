//
//  CodicCandidate.swift
//  Codic
//
//  Created by Tomoya Hirano on 2016/07/16.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation

class CodicCandidate {
  init(json: Dictionary<String, AnyObject>) {
    text = json["text"] as? String ?? ""
  }
  var text = ""
}
