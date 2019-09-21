//
//  RubiModel.swift
//  Task_yumemi
//
//  Created by 豊岡正紘 on 2019/09/19.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation


class RubiModel {
    
    func fetch(text: String, completion: @escaping (Rubi?, Error?) -> ()) {
        
        //URLRequestを設定
        var request = URLRequest(url: URL(string: "https://labs.goo.ne.jp/api/hiragana")!)
        
        // POSTを指定
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let postData = PostData(app_id: "add5342668f33cdb2deb6e49c9bb75fe8ec6f008369033697320ee2f5fc0f758", request_id: "record003", sentence: text, output_type: "hiragana")

        
        guard let uploadData = try? JSONEncoder().encode(postData) else {
            print("json生成に失敗しました")
            return
        }
        //Bodyにセット
        request.httpBody = uploadData
        
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let rubi = try JSONDecoder().decode(Rubi.self, from: data!)
                // success
                completion(rubi, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}


struct PostData: Codable {
    var app_id: String
    var request_id: String
    var sentence: String
    var output_type: String
}
struct Rubi:Codable {
    var converted: String
    var output_type: String
    var request_id: String
}
