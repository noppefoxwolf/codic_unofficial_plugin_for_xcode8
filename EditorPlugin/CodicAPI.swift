//
//  CodicAPI.swift
//  Codic
//
//  Created by Tomoya Hirano on 2016/07/16.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation

class CodicAPI {
  static let token = "Bearer obwHMNvfDsoxXpUAKta2T7vXZcStVEpWY"
  class func getTranslate(text: String,
                          success: ((response: CodicResponce)->())?,
                          failure: ((error: NSError?)->())?) {
    
    let apiBase = "https://api.codic.jp"
    let apiRoute = "/v1/engine/translate.json"
    let params = ["text": text, "casing": "camel"]
    let apiQuery = params.toQuery()
    let url = URL(string: apiBase + apiRoute + "?" + apiQuery)!
    var req = URLRequest(url: url)
    req.setValue(token, forHTTPHeaderField: "Authorization")
    URLSession.shared.dataTask(with: req) { (data, responce, error) in
      if let error = error {
        failure?(error: error)
      }
      if let data = data {
        let responce = CodicResponce(data: data)
        success?(response: responce)
      } else {
        failure?(error: nil)
      }
    }.resume()
  }
}
