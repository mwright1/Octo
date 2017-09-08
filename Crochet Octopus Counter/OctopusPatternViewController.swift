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
            counterButtonLabel.contentEdgeInsets = UIEdgeInsetsMake(90, 150, 90, 60)
        }
    }
    
    var currentRow = 0
    var currentSection = 0
    var lastRoundCompleted = 0
    var lastRoundCompletedForBottom = 0
    var lastRoundCompletedForTentacles = 0
    var indexOfTappedInfoButton = 0
    var sectionOfTappedInfoButton = 0
    let kCounterKey = "kCounterKey"
    let klastRoundCompletedKey = "klastRoundCompletedKey"
    let klastRoundCompletedForBottomKey = "klastRoundCompletedForBottomKey"
    let klastRoundCompletedForTentaclesKey = "klastRoundCompletedForTentaclesKey"
    let kCurrentRow = "kCurrentRow"
    let kCurrentSection = "kCurrentSection"
    var roundGroups = [
        RoundGroup(text: "Rnd 1: 6 sc in Magic Ring, mark beginning of each round with stitch marker (6 sts)", stitchesPerRound: 6, totalRounds: 1, startingRound: 1),
        RoundGroup(text: "Rnd 2: 2sc in each sc around (12 sts)", stitchesPerRound: 2, totalRounds: 1, startingRound: 2),
        RoundGroup(text: "Rnd 3: *1sc in next sc, 2sc in next sc; rep from *, 6 times (18 sts)", stitchesPerRound: 18, totalRounds: 1, startingRound: 3),
        RoundGroup(text: "Rnd 4: *1sc in next 2 sc, 2sc in next sc; rep from *, 6 times (24 sts)", stitchesPerRound: 24, totalRounds: 1, startingRound: 4),
        RoundGroup(text: "Rnd 5: *1sc in next 3 sc, 2sc in next sc; rep from *, 6 times (30 sts)", stitchesPerRound: 30, totalRounds: 1, startingRound: 5),
        RoundGroup(text: "Rnd 6: *1sc in next 4 sc, 2sc in next sc; rep from *, 6 times (36 sts)", stitchesPerRound: 36, totalRounds: 1, startingRound: 6, notes: "\nThis is a good point to stop and \n" +
            " \n" +
            "• check for holes:\n" +
            "If a standard 3” lollipop stick can be inserted between stitches, then your holes are too big. See Technique Notes above. \n" +
            " \n" +
            "• check for size:\n" +
            "If your round measures smaller than 1.3 inch (3.5 cm) in diameter at this point, add an additional increase round or two. If your round measures larger than 2 inches in diameter at this point, " +
            "you may need to delete an upcoming round or two so the head doesn’t come out too tall (deleting a few between 7-14 is recommended)."),
        RoundGroup(text: "Rnds 7-14: Sc in each single crochet around (36 sts)", stitchesPerRound: 36, totalRounds: 8, startingRound: 7, notes: "\nThis is a good point to stop and \n" +
            " \n" +
            "• add embroidered features. Features may not be added after stuffing. \n" +
            "\n" +
            "• add or delete rounds for height correction (head height should be about 1.5” at this point) \n" +
            " \n" +
            "• check again for holes"),
        RoundGroup(text: "Rnd 15: *1sc in next 4 sc, sc2tog; rep from *, 6 times (30 sts)", stitchesPerRound: 30, totalRounds: 1, startingRound: 15),
        RoundGroup(text: "Rnds 16-17: 1sc in each single crochet around (30 sts)", stitchesPerRound: 30, totalRounds: 2, startingRound: 16),
        RoundGroup(text: "Rnd 18: *1sc in next 3 sc, sc2tog; rep from *, 6 times (24 sts)", stitchesPerRound: 24, totalRounds: 1, startingRound: 18),
        RoundGroup(text: "Rnds 19-20: 1 sc in each single crochet around (24 sts)", stitchesPerRound: 24, totalRounds: 1, startingRound: 19),
        RoundGroup(text: "Rnd 21: *1sc in next 2 sc, sc2tog; rep from *, 6 times (18 sts)", stitchesPerRound: 18, totalRounds: 1, startingRound: 21),
        RoundGroup(text: "Rnd 22: 1sc in each single crochet around (18sts)", stitchesPerRound: 18, totalRounds: 1, startingRound: 22),
        RoundGroup(text: "Rnd 23: *1sc in next 7 single crochet, sc2tog; rep from *, 2 times (16 sts)", stitchesPerRound: 16, totalRounds: 1, startingRound: 23),
        RoundGroup(text: "Rnd 24: 1sc in each single crochet around (16 sts)", stitchesPerRound: 16, totalRounds: 1, startingRound: 24)
    ]
    
    let bottomRoundGroups = [
        RoundGroup(text: "Rnd 1: 5sc into Magic Ring (5sts)", stitchesPerRound: 5, totalRounds: 1, startingRound: 1),
        RoundGroup(text: "Rnd 2: 2sc in each sc around (10 sts)", stitchesPerRound: 10, totalRounds: 1, startingRound: 2),
        RoundGroup(text: "Rnd 3: *1sc in next sc, 2sc in next sc; rep from *, 5 times (15 sts)", stitchesPerRound: 15, totalRounds: 1, startingRound: 3, notes: "\nFinish with a slip stitch and cut yarn with " +
            "a long tail. Using a darning needle, move the yarn tail from the outside of the circle to the middle/back of the circle to join the beginning tail. Tie the tails together securely, then cut the tails short.\n" +
            " \n" +
            "Put the bottom of the octopus on the opening of the octopus’ head, lining up the stitches of both pieces. \n" +
            " \n" +
            "Pick the head yarn loop back up with your hook, and single crochet around the bottom piece and head. Each sc stitch will join the bottom piece and the octopus head together. (16 sts) \n" +
            " \n" +
            "Continue with Rnd 25 to create the tentacles.")
    ]
    
    let tentaclesRoundGroups = [
        RoundGroup(text: "Rnd 25: *ch 50 (Tightly stretch and measure your chain. Add or subtract chain stitches as needed to obtain a completed, fully stretched tentacle length between 6.3 and 8.5 inches." +
            "The relaxed/coiled length does not matter. Best practice is to aim for about 7 or 7.5 inches, fully and tightly stretched), sc in 2nd chain from hook, then 2sc (or 3sc) in either the back or bottom" +
            "loop of each chain stitch until you reach the body. When done with the chain, slip stitch or sc into the next stitch. Sc again in the next sc; repeat from * until you have a tentacle in every" +
            "other stitch of Rnd 24. Finish with a slip stitch in the same stitch where the first tentacle began, and cut the yarn leaving a long yarn end. Draw the cut end through the last loop and pull tight" +
            "to fasten off. Weave the finished end into the octopus’ head.", stitchesPerRound: 1, totalRounds: 1, startingRound: 1)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableViewHeightConstraint.constant = (view.frame.size.height - frogButton.frame.size.height)/2
        
        frogButton.imageView?.contentMode = .scaleAspectFit
        
        loadState()
        
        DispatchQueue.main.async {
            let currentIndexPath = IndexPath(row: self.currentRow, section: self.currentSection)
            self.tableView.selectRow(at: currentIndexPath, animated: false, scrollPosition: .middle)
        }
        
        self.tableView.contentOffset.y

    }
    
    func reset() {
        self.counter = 0
        self.currentRow = 0
        self.currentSection = 0
        self.lastRoundCompleted = 0
        self.lastRoundCompletedForBottom = 0
        self.lastRoundCompletedForTentacles = 0
        self.indexOfTappedInfoButton = 0
        self.sectionOfTappedInfoButton = 0
        for roundGroup in self.roundGroups {
            roundGroup.roundsCompleted = 0
            roundGroup.updateState(lastRoundCompleted: 0, shouldAutoStart: true)
        }
        
        for roundGroup in self.bottomRoundGroups {
            roundGroup.roundsCompleted = 0
            roundGroup.updateState(lastRoundCompleted: 0, shouldAutoStart: false)
        }
        
        for roundGroup in self.tentaclesRoundGroups {
            roundGroup.roundsCompleted = 0
            roundGroup.updateState(lastRoundCompleted: 0, shouldAutoStart: false)
        }
    }
    
    @IBAction func counterButtonTapped(_ sender: UIButton) {
        counter += 1
        let currentRoundGroup = currentSection == 0 ? roundGroups[currentRow] : (currentSection == 1 ? bottomRoundGroups[currentRow]: tentaclesRoundGroups[currentRow])
        if counter == currentRoundGroup.stitchesPerRound {
            currentRoundGroup.roundsCompleted += 1
            
            if currentSection == 0 {
                lastRoundCompleted += 1
            }
                
            else if currentSection == 1 {
                lastRoundCompletedForBottom += 1
            }
                
            else {
                lastRoundCompletedForTentacles += 1
            }
            
            let lastRoundCompletedForCurrentSection = currentSection == 0 ? lastRoundCompleted : (currentSection == 1 ? lastRoundCompletedForBottom : lastRoundCompletedForTentacles)
            currentRoundGroup.updateState(lastRoundCompleted: lastRoundCompletedForCurrentSection, shouldAutoStart: false)
            
            if currentRoundGroup.state == .completed {
                updateCell(atRow: currentRow, atSection: currentSection)
                currentRow += 1
                
                let currentRoundGroupsCount = currentSection == 0 ? roundGroups.count : (currentSection == 1 ? bottomRoundGroups.count : tentaclesRoundGroups.count)
                
                if currentRow == currentRoundGroupsCount {
                    currentRow = 0
                    
                    if currentSection == 0 {
                        currentSection = 1
                    }
                        
                    else if currentSection == 1 {
                        currentSection = 2
                    }
                        
                    else if currentSection == 2 {
                        let alert = UIAlertController(title: nil, message: "You did it! Pat yourself on the back!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        reset()
                    }
                }
            }
            updateCell(atRow: currentRow, atSection: currentSection) //Updating the current row, or the next row if the current row was completed in the previous line
            
            counter = 0
            tableView.selectRow(at: IndexPath(row: currentRow, section: currentSection), animated: false, scrollPosition: .none)
            tableView.scrollToNearestSelectedRow(at: UITableViewScrollPosition.middle, animated: true)
            frogButton.isUserInteractionEnabled = true
        }
        
        frogButton.isUserInteractionEnabled = true
        saveState()
    }
    
    @IBAction func showActionSheet(_ sender: Any) {
        if self.counter == 0 && self.currentSection == 0 {
            return
        }
        
        let undoMenu = UIAlertController(title: nil, message: "Choose what to frog", preferredStyle: .actionSheet)
        
        let undoStitchButton = UIAlertAction(title: "Frog a stitch", style: .default, handler: { (action) -> Void in
            if self.counter >= 1 {
                self.counter -= 1
            }
                
            else {
                //Alert saying we can't frog past the beginning of the round.
                let alert = UIAlertController(title: nil, message: "Frogging past the beginning of the round is currently not a feature.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            self.tableView.reloadData()
            self.saveState()
        })
        
        let resetButton = UIAlertAction(title: "Clear all", style: .default, handler: { (action) -> Void in
            
            let resetAlert = UIAlertController(title: "Clear all", message: "Are you sure you want to clear all?", preferredStyle: UIAlertControllerStyle.alert)
            resetAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.reset()
                self.tableView.reloadData()
                self.saveState()
            }))
            
            resetAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(resetAlert, animated: true, completion: nil)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        
        updateCell(atRow: currentRow, atSection: currentSection)
        
        undoMenu.addAction(undoStitchButton)
        undoMenu.addAction(resetButton)
        undoMenu.addAction(cancelButton)
        
        self.navigationController!.present(undoMenu, animated: true, completion: nil)
        
    }
    
    @IBAction func unwindToPattern(segue:UIStoryboardSegue) {
        
    }
    
    private func updateCell(atRow row: Int, atSection section: Int) {
        if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as? PatternRowTableViewCell {
            let currentRoundGroup = currentSection == 0 ? roundGroups[row] : (currentSection == 1 ? bottomRoundGroups[row] : tentaclesRoundGroups[row])
            let lastRoundCompletedForCurrentSection = currentSection == 0 ? lastRoundCompleted : (currentSection == 1 ? lastRoundCompletedForBottom : lastRoundCompletedForTentacles)
            
            cell.configure(with: currentRoundGroup, lastRoundCompleted: lastRoundCompletedForCurrentSection)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: nil)
        if segue.identifier == "showsInfoDetails", let nc = segue.destination as? UINavigationController {
            if let vc = nc.topViewController as? InfoDetailsViewController {
                if sectionOfTappedInfoButton == 0 {
                    vc.notes = roundGroups[indexOfTappedInfoButton].notes
                }
                else {
                    vc.notes = bottomRoundGroups[indexOfTappedInfoButton].notes
                }
            }
        }
    }
    
    private func saveState() {
        let defaults = UserDefaults.standard
        
        defaults.set(counter, forKey: kCounterKey)
        defaults.set(lastRoundCompleted, forKey: klastRoundCompletedKey)
        defaults.set(lastRoundCompletedForBottom, forKey: klastRoundCompletedForBottomKey)
        defaults.set(lastRoundCompletedForTentacles, forKey: klastRoundCompletedForTentaclesKey)
        defaults.set(currentRow, forKey: kCurrentRow)
        defaults.set(currentSection, forKey: kCurrentSection)
    }
    
    private func loadState() {
        let defaults = UserDefaults.standard
        
        counter = defaults.integer(forKey: kCounterKey)
        lastRoundCompleted = defaults.integer(forKey: klastRoundCompletedKey)
        lastRoundCompletedForBottom = defaults.integer(forKey: klastRoundCompletedForBottomKey)
        lastRoundCompletedForTentacles = defaults.integer(forKey: klastRoundCompletedForTentaclesKey)
        currentRow = defaults.integer(forKey: kCurrentRow)
        currentSection = defaults.integer(forKey: kCurrentSection)
        
        for round in roundGroups {
            //In-progress:
            if lastRoundCompleted >= round.startingRound && lastRoundCompleted < round.startingRound + round.totalRounds - 1 {
                round.roundsCompleted = lastRoundCompleted - round.startingRound + 1
            }
                //Completed:
            else if lastRoundCompleted >= round.startingRound {
                round.roundsCompleted = round.totalRounds
            }
            
            round.updateState(lastRoundCompleted: lastRoundCompleted, shouldAutoStart: true)
        }
        
        for round in bottomRoundGroups {
            //In-progress:
            if lastRoundCompletedForBottom >= round.startingRound && lastRoundCompletedForBottom < round.startingRound + round.totalRounds - 1 {
                round.roundsCompleted = lastRoundCompletedForBottom - round.startingRound + 1
            }
                //Completed:
            else if lastRoundCompletedForBottom >= round.startingRound {
                round.roundsCompleted = round.totalRounds
            }
            
            round.updateState(lastRoundCompleted: lastRoundCompletedForBottom, shouldAutoStart: false)
        }
        
        for round in tentaclesRoundGroups {
            //In-progress:
            if lastRoundCompletedForTentacles >= round.startingRound && lastRoundCompletedForTentacles < round.startingRound + round.totalRounds - 1 {
                round.roundsCompleted = lastRoundCompletedForTentacles - round.startingRound + 1
            }
                //Completed:
            else if lastRoundCompletedForTentacles >= round.startingRound {
                round.roundsCompleted = round.totalRounds
            }
            
            round.updateState(lastRoundCompleted: lastRoundCompletedForTentacles, shouldAutoStart: false)
        }
        
        tableView.reloadData()
    }
}

extension OctopusPatternViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return roundGroups.count
        }
        else if section == 1 {
            return bottomRoundGroups.count
        }
        else {
            return tentaclesRoundGroups.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PatternRowTableViewCell", for: indexPath) as? PatternRowTableViewCell else {
            fatalError("cell should not be nil!")
        }
        if indexPath.section == 0 {
            cell.configure(with: roundGroups[indexPath.row], lastRoundCompleted: lastRoundCompleted)
        }
        else if indexPath.section == 1 {
            cell.configure(with: bottomRoundGroups[indexPath.row], lastRoundCompleted: lastRoundCompletedForBottom)
        }
        else {
            cell.configure(with: tentaclesRoundGroups[indexPath.row], lastRoundCompleted: lastRoundCompletedForTentacles)
        }
        return cell
    }
}

extension OctopusPatternViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        indexOfTappedInfoButton = indexPath.row
        sectionOfTappedInfoButton = indexPath.section
        performSegue(withIdentifier: "showsInfoDetails", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        headerView.backgroundColor = .white
        
        let headerLabel1 = UILabel()
        headerLabel1.translatesAutoresizingMaskIntoConstraints = false
        headerLabel1.textAlignment = NSTextAlignment.center
        headerLabel1.textColor = .darkGray
        headerLabel1.font = UIFont.boldSystemFont(ofSize: 18)
        headerView.addSubview(headerLabel1)
        
        let headerLabel2 = UILabel()
        headerLabel2.translatesAutoresizingMaskIntoConstraints = false
        headerLabel2.textAlignment = NSTextAlignment.left
        headerLabel2.textColor = .darkGray
        headerLabel2.font = UIFont.systemFont(ofSize: 16)
        headerLabel2.lineBreakMode = .byWordWrapping
        headerLabel2.numberOfLines = 0
        headerView.addSubview(headerLabel2)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[headerLabel1]-(10)-|", options: [], metrics: nil, views: ["headerLabel1":headerLabel1]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[headerLabel2]-(10)-|", options: [], metrics: nil, views: ["headerLabel2":headerLabel2]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(5)-[headerLabel1]-(0)-[headerLabel2]-(5)-|", options: [], metrics: nil, views: ["headerLabel1":headerLabel1, "headerLabel2":headerLabel2]))
        
        if section == 0 {
            headerLabel1.text = "Octopus Head (Body)"
        }
        else if section == 1{
            headerLabel1.text = "Bottom of Octopus"
            headerLabel2.text = "The bottom of the octopus is a separate piece, that will “cap” the end of the " +
                "octopus’ head, holding in the stuffing. It can be created with a second, " +
                "contrasting color of yarn, so that the head yarn does not need to be cut. You will " +
            "be picking the head yarn back up to attach the bottom piece."
        }
        else {
            headerLabel1.text = "Tentacles"
            
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 200
        }
        else {
            return 44
        }
    }
}


