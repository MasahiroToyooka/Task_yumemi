//
//  ConvertTextViewModel.swift
//  Task_yumemi
//
//  Created by 豊岡正紘 on 2019/09/18.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation

class ConvertTextViewModel {
    
    var convertText: TextEntity?
    
    func fetch(text: String, comletion: @escaping () -> ()) {

        ConverTextModel().fetch(text: text) { [weak self] (convertText) in
            self?.convertText = convertText
            comletion()
        }
    }
}
