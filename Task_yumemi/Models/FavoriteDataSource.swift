//
//  UserDefalts.swift
//  Task_yumemi
//
//  Created by 豊岡正紘 on 2019/09/22.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation

class FavoriteDataSource {
    
    var inputArray = [String]()
    var outputArray = [String]()
    
    let userDefault = UserDefaults.standard
    
    func loadData() {
        
        if UserDefaults.standard.object(forKey: "inputArray") != nil {
            
            self.inputArray = UserDefaults.standard.object(forKey: "inputArray") as! [String]
            self.outputArray = UserDefaults.standard.object(forKey: "outputArray") as! [String]
        }
    }
    
    func saveData(inputText: String, outputText: String) {
        
        loadData()
        
        self.inputArray.append(inputText)
        self.outputArray.append(outputText)
        
        userDefault.set(self.inputArray, forKey: "inputArray")
        userDefault.set(self.outputArray, forKey: "outputArray")
    }
    
    func deleteLastData() {
        
        loadData()
        
        
        self.inputArray.removeLast()
        self.outputArray.removeLast()
        
        userDefault.set(self.inputArray, forKey: "inputArray")
        userDefault.set(self.outputArray, forKey: "outputArray")
    }
    
    
    func deleteData(indexPath: Int) {
            
            loadData()
            
            self.inputArray.remove(at: indexPath)
            self.outputArray.remove(at: indexPath)
            
            userDefault.set(self.inputArray, forKey: "inputArray")
            userDefault.set(self.outputArray, forKey: "outputArray")
    }
    
    func count() -> Int {
        return inputArray.count
    }
}
