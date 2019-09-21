//
//  ViewController.swift
//  Task_yumemi
//
//  Created by 豊岡正紘 on 2019/09/17.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// 検索用のtextField
    @IBOutlet weak var inputTextField: UITextField!
    
    /// 検索結果をまとめて表示するためのview
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    /// お気に入りボタン
    @IBOutlet weak var favoriteButton: UIButton!
    
    let rubiModel = RubiModel()
    
    /// favoriteButtonの状態を管理する変数。　0がデフォルト1がお気に入り
    var favoriteState: Int = 0
    
    // 検索内容、結果を保存する配列
    var inputArray = [String]()
    var outputArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultView.isHidden = true
        inputTextField.delegate = self
        
        favoriteButton.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
    }
    
    //画面をタッチした時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputTextField.resignFirstResponder()
    }

    @objc func favoriteAction() {
        
        let userDefault = UserDefaults.standard
        
        if favoriteState == 0 {
            // お気に入りを追加する処理
            
            if userDefault.object(forKey: "inputArray") != nil {
                
                self.inputArray = userDefault.object(forKey: "inputArray") as! [String]
                self.outputArray = userDefault.object(forKey: "outputArray") as! [String]
            }
            
            self.inputArray.append(self.inputTextField.text!)
            self.outputArray.append(self.outputLabel.text!)
            
            favoriteButton.setTitle("★", for: .normal)
            favoriteState = 1
        } else {
            // お気に入りを取り消す処理
            
            self.inputArray.removeLast()
            self.outputArray.removeLast()
                        
            favoriteButton.setTitle("☆", for: .normal)
            favoriteState = 0
        }
        
        userDefault.set(self.inputArray, forKey: "inputArray")
        userDefault.set(self.outputArray, forKey: "outputArray")
    }
    
    // 変換ボタンのアクション
    @IBAction func convertButton(_ sender: UIButton) {
        
        // テキストがからの状態、同じ検索内容の時は反応させない
        if inputTextField.text!.isEmpty || inputLabel.text == inputTextField.text {
            print("同じ検索内容または空")
        } else {
            
            // 検索したらいいねボタンをデフォルトの状態に戻す
            favoriteButton.setTitle("☆", for: .normal)
            favoriteState = 0
            
            rubiModel.fetch(text: inputTextField.text!) { (res, err) in
                DispatchQueue.main.async {
                    
                    self.outputLabel.text = res?.converted
                    self.inputLabel.text = self.inputTextField.text
                    self.resultView.isHidden = false
                    self.inputTextField.resignFirstResponder()
                }
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.resignFirstResponder()
        return true
    }
}

