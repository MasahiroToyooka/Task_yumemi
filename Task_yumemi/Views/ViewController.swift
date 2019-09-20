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
    
    
    let viewModel = ConvertTextViewModel()
    
    let rubiModel = RubiModel()
    
    var starState: Int = 0
    
    var inputArray = [String]()
    var outputArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultView.isHidden = true
    }

    
    @IBAction func convertButton(_ sender: UIButton) {

        guard let text = inputTextField.text else { return }
        
        rubiModel.fetch(text: text) { (res, err) in
            DispatchQueue.main.async {
                self.outputLabel.text = res?.converted
                self.inputText.text = text
                self.resultView.isHidden = false
            }
        }
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        let userDefault = UserDefaults.standard
        
        if starState == 0 {

            if userDefault.object(forKey: "inputArray") != nil {
                
                self.inputArray = userDefault.object(forKey: "inputArray") as! [String]
                self.outputArray = userDefault.object(forKey: "outputArray") as! [String]
            }

            self.inputArray.append(self.inputTextField.text!)
            self.outputArray.append(self.outputLabel.text!)
            
            print(outputArray.count)
            sender.setTitle("★", for: .normal)
            starState = 1
        } else {
            
            self.inputArray.removeLast()
            self.outputArray.removeLast()
        
            print(outputArray.count)

            sender.setTitle("☆", for: .normal)
            starState = 0
        }
        
        userDefault.set(self.inputArray, forKey: "inputArray")
        userDefault.set(self.outputArray, forKey: "outputArray")
    }
}

