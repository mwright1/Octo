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
    @IBOutlet weak var roundLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkBoxButton.isSelected = false
        
    
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkBoxButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
}

