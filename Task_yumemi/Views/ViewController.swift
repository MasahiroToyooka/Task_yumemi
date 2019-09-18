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
    
    let viewModel = ConvertTextViewModel()
    
    let rubiModel = RubiModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func convertButton(_ sender: UIButton) {
//        viewModel.fetch(text: "東西南北") {
//            print(self.viewModel.convertText!.converted)
//        }
        
        rubiModel.fetch(text: "東西") { (res, err) in
            DispatchQueue.main.async {
                print(res?.converted)
            }
        }
    }
    
}

