//
//  ViewController.swift
//  Task_yumemi
//
//  Created by 豊岡正紘 on 2019/09/17.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var inputText: UILabel!
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    let viewModel = ConvertTextViewModel()
    
    let rubiModel = RubiModel()
    
    var favoriteState: Int = 0
    
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
            
            if userDefault.object(forKey: "inputArray") != nil {
                
                self.inputArray = userDefault.object(forKey: "inputArray") as! [String]
                self.outputArray = userDefault.object(forKey: "outputArray") as! [String]
            }
            
            self.inputArray.append(self.inputTextField.text!)
            self.outputArray.append(self.outputLabel.text!)
            
            print(outputArray.count)
            favoriteButton.setTitle("★", for: .normal)
            favoriteState = 1
        } else {
            
            self.inputArray.removeLast()
            self.outputArray.removeLast()
            
            print(outputArray.count)
            
            favoriteButton.setTitle("☆", for: .normal)
            favoriteState = 0
        }
        
        userDefault.set(self.inputArray, forKey: "inputArray")
        userDefault.set(self.outputArray, forKey: "outputArray")
    }
    
    @IBAction func convertButton(_ sender: UIButton) {
        
        if inputTextField.text!.isEmpty || inputText.text == inputTextField.text {
            print("から")
        } else {
        
            favoriteButton.setTitle("☆", for: .normal)
            favoriteState = 0
            
            rubiModel.fetch(text: inputTextField.text!) { (res, err) in
                DispatchQueue.main.async {
                    self.outputLabel.text = res?.converted
                    self.inputText.text = self.inputTextField.text
                    self.resultView.isHidden = false
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

