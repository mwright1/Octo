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
        roundLabel.text = ""
        rowPatternLabel.textColor = .darkGray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        checkBoxButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func configure(with round: RoundGroup, lastRoundCompleted: Int) {
        
        if round.notes != nil {
            accessoryType = .detailButton
        }
        else {
            accessoryType = .none
        }
        
        rowPatternLabel.text = round.text
           
        switch round.state {
        case .completed:
            checkBoxButton.isSelected = true
            let tealColor = UIColor(red:0.00, green:0.50, blue:0.50, alpha:1.0)
            rowPatternLabel.textColor = tealColor
            roundLabel.text = ""
            
        case .inProgress:
            if round.totalRounds > 1 {
                roundLabel.text = "Rnd \(lastRoundCompleted + 1)"
            }
            else {
                roundLabel.text = ""
            }
            
        case .notStarted:
            roundLabel.text = ""
            rowPatternLabel.textColor = .darkGray
            
        }
    }
    
    
}

