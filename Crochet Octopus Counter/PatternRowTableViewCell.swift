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
    
    func configure(with round: RoundGroup, number: Int) {
        
        if round.state == .completed {
            checkBoxButton.isSelected = true
            let tealColor = UIColor(red:0.00, green:0.50, blue:0.50, alpha:1.0)
            rowPatternLabel.textColor = tealColor
            roundLabel.text = ""
        }
        
        if round.state == .inProgress {
            
            roundLabel.text = "Rnd \(number + 1)"
        }
        
        if round.state == .notStarted {
            rowPatternLabel.text = round.text
            roundLabel.text = ""
            rowPatternLabel.textColor = .darkGray
        }
        
    }
    
    
}

