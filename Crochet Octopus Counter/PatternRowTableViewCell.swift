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
//        if isSelected {
//            rowPatternLabel.textColor = .blue
//        }
//        else {
//            rowPatternLabel.textColor = .black
//        }
        rowPatternLabel.textColor = selected ? .blue : .black
        checkBoxButton.isSelected = selected
    }

}
