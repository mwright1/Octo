//
//  PatternRowTableViewCell.swift
//  Crochet Octopus Counter
//
//  Created by Mona Wright on 5/4/17.
//  Copyright © 2017 Mona Wright. All rights reserved.
//

import UIKit

class PatternRowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var rowPatternLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let tealColor = UIColor(red:0.00, green:0.50, blue:0.50, alpha:1.0)
        rowPatternLabel.textColor = selected ? (tealColor) : .black
        checkBoxButton.isSelected = selected
    }
    
}
