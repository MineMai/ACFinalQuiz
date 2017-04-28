//
//  TableViewCell.swift
//  ACFinalQuiz
//
//  Created by YenShao on 2017/4/28.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
