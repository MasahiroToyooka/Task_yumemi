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
        
        if starState == 0 {
            sender.setTitle("★", for: .normal)
            starState = 1
        } else {
        
            sender.setTitle("☆", for: .normal)
            starState = 0
        }
    }
}

