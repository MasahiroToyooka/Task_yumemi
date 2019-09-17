//
//  ConvertTextModel.swift
//  Task_yumemi
//
//  Created by 豊岡正紘 on 2019/09/17.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ConverTextModel {
    
    let baseUrl = "https://labs.goo.ne.jp/api/hiragana"

    
    func fetch(text: String, completion: @escaping (TextEntity) -> ()) {
        
        guard let text = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            print("キーワードの変換に失敗しました。")
            return
        }
        
        let parameters:[String: Any] = [
            "sentence": text,
            "app_id": "add5342668f33cdb2deb6e49c9bb75fe8ec6f008369033697320ee2f5fc0f758",
            "output_type": "hiragana"
        ]
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Contenttype": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(baseUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            
            // 通信エラーの確認
            if response.result.isFailure == true {
                print("通信エラー")
                return
            }
            
            // JSON形式の確認
            guard let val = response.result.value as? [String: Any] else {
                print("JSONではない")
                return
            }
            
            let json = JSON(val)
//            let contents = json["data"].arrayValue
//
//            let data = contents.map { data in
//                return TextEntity(item: data)
//            }
            let data = TextEntity(item: json)
            completion(data)
        }
    }
}


// APIのレスポンスに対する構造体
public struct TextEntity {
    
    let converted: String
    let output_type: String
    let request_id: String
    
    init(item: JSON) {
        
        self.converted = item["converted"].stringValue
        self.output_type = item["output_type"].stringValue
        self.request_id = item["request_id"].stringValue
    }
}
