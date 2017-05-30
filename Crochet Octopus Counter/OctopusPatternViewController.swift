//
//  OctopusPatternViewController.swift
//  Crochet Octopus Counter
//
//  Created by Mona Wright on 5/4/17.
//  Copyright © 2017 Mona Wright. All rights reserved.
//

import UIKit

class RoundGroup {
    
    enum State {
        case notStarted
        case inProgress
        case completed
    }
    
    var state = State.notStarted
    var text:String
    var stitchesPerRound:Int
    var totalRounds:Int
    var roundsCompleted:Int = 0 {
        didSet {
            
        }
    }
    
    init(text:String, stitchesPerRound:Int, totalRounds:Int) {
        self.text = text
        self.stitchesPerRound = stitchesPerRound
        self.totalRounds = totalRounds
    }
    
    
}

class OctopusPatternViewController: UIViewController {
    @IBOutlet weak var counterButton: UIButton!
    @IBOutlet weak var counterButtonLabel: UIButton!
    @IBOutlet weak var frogButton: UIButton!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var counter = 0
    var currentRow = 0
    var roundNumber = 0
    var roundGroups:[RoundGroup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
        
        tableViewHeightConstraint.constant = (view.frame.size.height - frogButton.frame.size.height)/2
        
        roundGroups.append(RoundGroup(text: "Rnd 1: 6 sc in Magic Ring, mark beginning of each round with stitch marker (6 sts)", stitchesPerRound: 2, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "2sc in each sc around (12 sts)", stitchesPerRound: 2, totalRounds: 3))
        roundGroups.append(RoundGroup(text: "*1sc in next sc, 2sc in next sc; rep from *, 6 times (18 sts)", stitchesPerRound: 4, totalRounds: 2))
        roundGroups.append(RoundGroup(text: "*1sc in next 2 sc, 2sc in next sc; rep from *, 6 times (24 sts)", stitchesPerRound: 4, totalRounds: 2))
        roundGroups.append(RoundGroup(text: "*1sc in next 3 sc, 2sc in next sc; rep from *, 6 times (30 sts)", stitchesPerRound: 6, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "*1sc in next 4 sc, 2sc in next sc; rep from *, 6 times (36 sts)", stitchesPerRound: 6, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "Rnds 7-14: Sc in each single crochet around (36 sts)", stitchesPerRound: 6, totalRounds: 7))
        roundGroups.append(RoundGroup(text: "Rnd 15: *1sc in next 4 sc, sc2tog; rep from *, 6 times (30 sts)", stitchesPerRound: 6, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "Rnds 16-17: 1sc in each single crochet around (30 sts)", stitchesPerRound: 6, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "Rnd 18: *1sc in next 3 sc, sc2tog; rep from *, 6 times (24 sts)", stitchesPerRound: 6, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "Rnds 19-20: 1 sc in each single crochet around (24 sts)", stitchesPerRound: 6, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "Rnd 21: *1sc in next 2 sc, sc2tog; rep from *, 6 times (18 sts)", stitchesPerRound: 6, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "Rnd 22: 1sc in each single crochet around (18sts)", stitchesPerRound: 6, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "Rnd 23: *1sc in next 7 single crochet, sc2tog; rep from *, 2 times (16 sts)", stitchesPerRound: 6, totalRounds: 1))
        roundGroups.append(RoundGroup(text: "Rnd 24: 1sc in each single crochet around (16 sts)", stitchesPerRound: 6, totalRounds: 1))
        
        counterButtonLabel.setTitle("0", for: .normal)
        frogButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func counterButtonTapped(_ sender: UIButton) {
        counter += 1
        
        if counter == roundGroups[currentRow].stitchesPerRound {
            roundGroups[currentRow].roundsCompleted += 1
            roundNumber += 1
            
            if roundGroups[currentRow].roundsCompleted == roundGroups[currentRow].totalRounds {
                roundGroups[currentRow].state = .completed
            }
            
            if roundGroups[currentRow].roundsCompleted != 0 && roundGroups[currentRow].roundsCompleted != roundGroups[currentRow].totalRounds  && roundGroups[currentRow].totalRounds > 1 {
                roundGroups[currentRow].state = .inProgress
            }
            
            if roundGroups[currentRow].roundsCompleted == 0 {
                roundGroups[currentRow].state = .notStarted
            }
            
            if roundGroups[currentRow].state == .completed {
                if let cell = tableView.cellForRow(at: IndexPath(row: currentRow, section: 0)) as? PatternRowTableViewCell {
                    cell.checkBoxButton.isSelected = true
                    let tealColor = UIColor(red:0.00, green:0.50, blue:0.50, alpha:1.0)
                    cell.rowPatternLabel.textColor = tealColor
                    cell.roundLabel.text = ""
                }
                
                currentRow += 1
            }
            
            if roundGroups[currentRow].totalRounds > 1 {
                if let cell = tableView.cellForRow(at: IndexPath(row: currentRow, section: 0)) as? PatternRowTableViewCell {
                    cell.roundLabel.text = "Rnd \(roundNumber + 1)"
                }
            }
            
            counter = 0
            tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
            tableView.scrollToNearestSelectedRow(at: UITableViewScrollPosition.middle, animated: true)
            frogButton.isUserInteractionEnabled = true
        }
        
        counterButtonLabel.setTitle("\(counter)", for: .normal)
        frogButton.isUserInteractionEnabled = true
    }
    
    
    @IBAction func frogButtonTapped(_ sender: UIButton) {
        if counter >= 1 {
            counter -= 1
            counterButtonLabel.setTitle("\(counter)", for: .normal)
        }
        
        if counter == 0 {
            frogButton.isUserInteractionEnabled = false
        }
    }
}

extension OctopusPatternViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roundGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PatternRowTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PatternRowTableViewCell", for: indexPath) as! PatternRowTableViewCell
        cell.configure(with: roundGroups[indexPath.row], number: roundNumber)
        
        return cell
        
    }
    
}

extension OctopusPatternViewController: UITableViewDelegate {
    
}
