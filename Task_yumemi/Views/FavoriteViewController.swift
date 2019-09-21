//
//  FavoriteViewController.swift
//  Task_yumemi
//
//  Created by 豊岡正紘 on 2019/09/21.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 検索内容、結果を保存する配列
    var inputArray = [String]()
    var outputArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        // UserDafaultsからデータ取得してtableViewに反映
        if UserDefaults.standard.object(forKey: "inputArray") != nil {
            
            self.inputArray = UserDefaults.standard.object(forKey: "inputArray") as! [String]
            self.outputArray = UserDefaults.standard.object(forKey: "outputArray") as! [String]
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteCell
        
        cell.outputLabel.text = outputArray[indexPath.row]
        cell.inputLabel.text = inputArray[indexPath.row]
        
        return cell
    }
    
    // スワイプでセルを消す処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            inputArray.remove(at: indexPath.row)
            outputArray.remove(at: indexPath.row)
            
            UserDefaults.standard.set(self.inputArray, forKey: "inputArray")
            UserDefaults.standard.set(self.outputArray, forKey: "outputArray")
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
