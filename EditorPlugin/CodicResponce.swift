//
//  CodicResponse.swift
//  Codic
//
//  Created by Tomoya Hirano on 2016/07/16.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation

class CodicResponce {
  init(data: Data) {
    do {
      guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Dictionary<String, AnyObject>] else { return }
      items = json.flatMap{ CodicItem(json: $0) }
    } catch {
      print("failure parse")
    }
  }
  private(set) var items = [CodicItem]()
}
