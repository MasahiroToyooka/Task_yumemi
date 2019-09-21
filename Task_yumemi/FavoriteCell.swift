//
//  FavoriteCell.swift
//  Task_yumemi
//
//  Created by 豊岡正紘 on 2019/09/21.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    // ひらがなを表示するラベル
    @IBOutlet weak var outputLabel: UILabel!
    
    // 漢字つきのテキストを表示するラベル
    @IBOutlet weak var inputLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
