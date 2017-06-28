//
//  OctopusPatternViewController.swift
//  Crochet Octopus Counter
//
//  Created by Mona Wright on 5/4/17.
//  Copyright © 2017 Mona Wright. All rights reserved.
//

import UIKit


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
    var lastRoundCompleted = 0
    var indexOfTappedInfoButton = 0
    let kCounterKey = "kCounterKey"
    let klastRoundCompletedKey = "klastRoundCompletedKey"
    let roundGroups = [
        RoundGroup(text: "Rnd 1: 6 sc in Magic Ring, mark beginning of each round with stitch marker (6 sts)", stitchesPerRound: 6, totalRounds: 1, startingRound: 1),
        RoundGroup(text: "Rnd 2: 2sc in each sc around (12 sts)", stitchesPerRound: 12, totalRounds: 1, startingRound: 2),
        RoundGroup(text: "Rnd 3: *1sc in next sc, 2sc in next sc; rep from *, 6 times (18 sts)", stitchesPerRound: 18, totalRounds: 1, startingRound: 3),
        RoundGroup(text: "Rnd 4: *1sc in next 2 sc, 2sc in next sc; rep from *, 6 times (24 sts)", stitchesPerRound: 24, totalRounds: 1, startingRound: 4),
        RoundGroup(text: "Rnd 5: *1sc in next 3 sc, 2sc in next sc; rep from *, 6 times (30 sts)", stitchesPerRound: 30, totalRounds: 1, startingRound: 5),
        RoundGroup(text: "Rnd 6: *1sc in next 4 sc, 2sc in next sc; rep from *, 6 times (36 sts)", stitchesPerRound: 36, totalRounds: 1, startingRound: 6, notes: "Note: This is a good point to stop and " +
            "• check for holes:\n" +
            "If a standard 3” lollipop stick can be inserted between stitches, then " +
            "your holes are too big. See Technique Notes above.\n" +
            "• check for size:\n" +
            "If your round measures smaller than 1.3 inch (3.5 cm) in diameter at " +
            "this point, add an additional increase round or two.\n" +
            "If your round measures larger than 2 inches in diameter at this " +
            "point, you may need to delete an upcoming round or two so the " +
            "head doesn’t come out"),
        RoundGroup(text: "Rnds 7-14: Sc in each single crochet around (36 sts)", stitchesPerRound: 36, totalRounds: 8, startingRound: 7, notes: "buddy"),
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
        
        tableView.delegate = self
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
        
        tableViewHeightConstraint.constant = (view.frame.size.height - frogButton.frame.size.height)/2
        
        frogButton.imageView?.contentMode = .scaleAspectFit
        
        loadState()
    }
    
    
    @IBAction func counterButtonTapped(_ sender: UIButton) {
        counter += 1
        let currentRound = roundGroups[currentRow]
        
        if counter == currentRound.stitchesPerRound {
            currentRound.roundsCompleted += 1
            lastRoundCompleted += 1
            
            currentRound.updateState(lastRoundCompleted: lastRoundCompleted)
            
            if currentRound.state == .completed {
                updateCell(atRow: currentRow)
                currentRow += 1
            }
            updateCell(atRow: currentRow) //Updating the current row, or the next row if the current row was completed in the previous line
            
            counter = 0
            tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
            tableView.scrollToNearestSelectedRow(at: UITableViewScrollPosition.middle, animated: true)
            frogButton.isUserInteractionEnabled = true
        }
        
        frogButton.isUserInteractionEnabled = true
        
        saveState()
    }
    
    
    @IBAction func frogButtonTapped(_ sender: UIButton) {
        if counter >= 1 {
            counter -= 1
        }
        
        if counter == 0 {
            frogButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func unwindToPattern(segue:UIStoryboardSegue) {
    
    }
    
    private func updateCell(atRow row: Int) {
        if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? PatternRowTableViewCell {
            cell.configure(with: roundGroups[row], lastRoundCompleted: lastRoundCompleted)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: nil)
        if segue.identifier == "showsInfoDetails", let nc = segue.destination as? UINavigationController {
            if let vc = nc.topViewController as? InfoDetailsViewController {
                vc.notes = roundGroups[self.indexOfTappedInfoButton].notes
            }
        }
    }
    
    private func saveState() {
        let defaults = UserDefaults.standard
        
        defaults.set(counter, forKey: kCounterKey)
        defaults.set(lastRoundCompleted, forKey: klastRoundCompletedKey)
    }
    
    private func loadState() {
        let defaults = UserDefaults.standard
        
        counter = defaults.integer(forKey: kCounterKey)
        lastRoundCompleted = defaults.integer(forKey: klastRoundCompletedKey)
        
        for round in roundGroups {
            //In-progress:
            if lastRoundCompleted >= round.startingRound && lastRoundCompleted < round.startingRound + round.totalRounds - 1 {
                round.roundsCompleted = lastRoundCompleted - round.startingRound + 1
            }
            //Completed:
            else if lastRoundCompleted >= round.startingRound {
                round.roundsCompleted = round.totalRounds
            }
            
            round.updateState(lastRoundCompleted: lastRoundCompleted)
        }
        
        tableView.reloadData()
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
        
        cell.configure(with: roundGroups[indexPath.row], lastRoundCompleted: lastRoundCompleted)
        
        return cell
        
    }
    
    
}

extension OctopusPatternViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.indexOfTappedInfoButton = indexPath.row
        performSegue(withIdentifier: "showsInfoDetails", sender: nil)
        
    }
}


