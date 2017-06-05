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
    var startingRound:Int
    var roundsCompleted:Int = 0 {
        didSet {
            if roundsCompleted == totalRounds {
                state = .completed
            } else if roundsCompleted != 0 && roundsCompleted != totalRounds && totalRounds > 1 {
                state = .inProgress
            } else if roundsCompleted == 0 {
                state = .notStarted
            }
        }
    }
    
    init(text:String, stitchesPerRound:Int, totalRounds:Int, startingRound:Int) {
        self.text = text
        self.stitchesPerRound = stitchesPerRound
        self.totalRounds = totalRounds
        self.startingRound = startingRound
    }
    
}

class OctopusPatternViewController: UIViewController {
    @IBOutlet weak var counterButton: UIButton!
    @IBOutlet weak var counterButtonLabel: UIButton!
    @IBOutlet weak var frogButton: UIButton!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var counter = 0 {
        didSet {
            counterButtonLabel.setTitle("\(counter)", for: .normal)
        }
    }
    var currentRow = 0
    var roundNumber = 0
    let roundGroups = [
        RoundGroup(text: "Rnd 1: 6 sc in Magic Ring, mark beginning of each round with stitch marker (6 sts)", stitchesPerRound: 6, totalRounds: 1, startingRound: 1),
        RoundGroup(text: "Rnd 2: 2sc in each sc around (12 sts)", stitchesPerRound: 12, totalRounds: 1, startingRound: 2),
        RoundGroup(text: "Rnd 3: *1sc in next sc, 2sc in next sc; rep from *, 6 times (18 sts)", stitchesPerRound: 18, totalRounds: 1, startingRound: 3),
        RoundGroup(text: "Rnd 4: *1sc in next 2 sc, 2sc in next sc; rep from *, 6 times (24 sts)", stitchesPerRound: 24, totalRounds: 1, startingRound: 4),
        RoundGroup(text: "Rnd 5: *1sc in next 3 sc, 2sc in next sc; rep from *, 6 times (30 sts)", stitchesPerRound: 30, totalRounds: 1, startingRound: 5),
        RoundGroup(text: "Rnd 6: *1sc in next 4 sc, 2sc in next sc; rep from *, 6 times (36 sts)", stitchesPerRound: 36, totalRounds: 1, startingRound: 6),
        RoundGroup(text: "Rnds 7-14: Sc in each single crochet around (36 sts)", stitchesPerRound: 36, totalRounds: 8, startingRound: 7),
        RoundGroup(text: "Rnd 15: *1sc in next 4 sc, sc2tog; rep from *, 6 times (30 sts)", stitchesPerRound: 30, totalRounds: 1, startingRound: 15),
        RoundGroup(text: "Rnds 16-17: 1sc in each single crochet around (30 sts)", stitchesPerRound: 30, totalRounds: 2, startingRound: 16),
        RoundGroup(text: "Rnd 18: *1sc in next 3 sc, sc2tog; rep from *, 6 times (24 sts)", stitchesPerRound: 24, totalRounds: 1, startingRound: 18),
        RoundGroup(text: "Rnds 19-20: 1 sc in each single crochet around (24 sts)", stitchesPerRound: 24, totalRounds: 1, startingRound: 19),
        RoundGroup(text: "Rnd 21: *1sc in next 2 sc, sc2tog; rep from *, 6 times (18 sts)", stitchesPerRound: 18, totalRounds: 1, startingRound: 21),
        RoundGroup(text: "Rnd 22: 1sc in each single crochet around (18sts)", stitchesPerRound: 18, totalRounds: 1, startingRound: 22),
        RoundGroup(text: "Rnd 23: *1sc in next 7 single crochet, sc2tog; rep from *, 2 times (16 sts)", stitchesPerRound: 16, totalRounds: 1, startingRound: 23),
        RoundGroup(text: "Rnd 24: 1sc in each single crochet around (16 sts)", stitchesPerRound: 16, totalRounds: 1, startingRound: 24)
    ]
    
//        Test data
//    let roundGroups = [
//        RoundGroup(text: "Rnd 1: 6 sc in Magic Ring, mark beginning of each round with stitch marker (6 sts)", stitchesPerRound: 2, totalRounds: 1, startingRound: 1),
//        RoundGroup(text: "2sc in each sc around (12 sts)", stitchesPerRound: 2, totalRounds: 3, startingRound: 2),
//        RoundGroup(text: "*1sc in next sc, 2sc in next sc; rep from *, 6 times (18 sts)", stitchesPerRound: 4, totalRounds: 2, startingRound: 3),
//        RoundGroup(text: "*1sc in next 2 sc, 2sc in next sc; rep from *, 6 times (24 sts)", stitchesPerRound: 4, totalRounds: 2, startingRound: 4),
//        RoundGroup(text: "*1sc in next 3 sc, 2sc in next sc; rep from *, 6 times (30 sts)", stitchesPerRound: 6, totalRounds: 1, startingRound: 5),
//        RoundGroup(text: "*1sc in next 4 sc, 2sc in next sc; rep from *, 6 times (36 sts)", stitchesPerRound: 6, totalRounds: 1, startingRound: 6),
//        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Octo"
        
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
        
        tableViewHeightConstraint.constant = (view.frame.size.height - frogButton.frame.size.height)/2
                
        counter = 0
        frogButton.imageView?.contentMode = .scaleAspectFit
    }

    
    @IBAction func counterButtonTapped(_ sender: UIButton) {
        counter += 1
        let currentRound = roundGroups[currentRow]
        
        if counter == currentRound.stitchesPerRound {
            currentRound.roundsCompleted += 1
            roundNumber += 1
            
            if currentRound.state == .completed {
                if let cell = tableView.cellForRow(at: IndexPath(row: currentRow, section: 0)) as? PatternRowTableViewCell {
                    
                    cell.configure(with: currentRound, roundNumber: roundNumber)
                }
                
                currentRow += 1
            }
            
            let nextRound = roundGroups[currentRow]
            if nextRound.startingRound == roundNumber + 1 {
                nextRound.state = .inProgress
            }
            
            if nextRound.totalRounds > 1 {
                if let cell = tableView.cellForRow(at: IndexPath(row: currentRow, section: 0)) as? PatternRowTableViewCell {
                    cell.configure(with: nextRound, roundNumber: roundNumber)
                }
            }
            
            counter = 0
            tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
            tableView.scrollToNearestSelectedRow(at: UITableViewScrollPosition.middle, animated: true)
            frogButton.isUserInteractionEnabled = true
        }
        
        frogButton.isUserInteractionEnabled = true
    }
    
    
    @IBAction func frogButtonTapped(_ sender: UIButton) {
        if counter >= 1 {
            counter -= 1
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PatternRowTableViewCell", for: indexPath) as? PatternRowTableViewCell else {
            fatalError("cell should not be nil!")
        }
        
        cell.configure(with: roundGroups[indexPath.row], roundNumber: roundNumber)
        
        
        return cell
        
    }
    
}

extension OctopusPatternViewController: UITableViewDelegate {
    
}
