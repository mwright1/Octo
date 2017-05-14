//
//  OctopusPatternViewController.swift
//  Crochet Octopus Counter
//
//  Created by Mona Wright on 5/4/17.
//  Copyright © 2017 Mona Wright. All rights reserved.
//

import UIKit

class OctopusPatternViewController: UIViewController {
    @IBOutlet weak var uncheckedButton: UIButton!
    @IBOutlet weak var counterButton: UIButton!
    @IBOutlet weak var counterButtonLabel: UIButton!
    @IBOutlet weak var frogButton: UIButton!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    var cellClass = PatternRowTableViewCell()
    var counter = 0
    var totalStitchesPerIncreaseRound: [Int] =  [2, 2, 4, 4, 4]// 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
    //[4, 12, 18, 24, 30, 36, 36, 36, 36, 36, 36, 36, 36, 36]
    var totalStitchesPerDecreaseRound: [Int] = [16, 18, 24, 30]
    var sevenFourteenRounds: [Int] = [2, 3, 4] //[6, 7, 8, 9, 10, 11, 12]
    var currentRow = 0
    
    var octopusPattern: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
        
        tableViewHeightConstraint.constant = (view.frame.size.height - frogButton.frame.size.height)/2
        
        octopusPattern.append("Rnd 1: 6 sc in Magic Ring, mark beginning of each round with stitch marker (6 sts)")
        octopusPattern.append("2sc in each sc around (12 sts)")
        octopusPattern.append("*1sc in next sc, 2sc in next sc; rep from *, 6 times (18 sts)")
        octopusPattern.append("*1sc in next 2 sc, 2sc in next sc; rep from *, 6 times (24 sts)")
        octopusPattern.append("*1sc in next 3 sc, 2sc in next sc; rep from *, 6 times (30 sts)")
        octopusPattern.append("*1sc in next 4 sc, 2sc in next sc; rep from *, 6 times (36 sts)")
        octopusPattern.append("Rnds 7-14: Sc in each single crochet around (36 sts)")
        octopusPattern.append("Rnd 15: *1sc in next 4 sc, sc2tog; rep from *, 6 times (30 sts)")
        octopusPattern.append("Rnds 16-17: 1sc in each single crochet around (30 sts)")
        octopusPattern.append("Rnd 18: *1sc in next 3 sc, sc2tog; rep from *, 6 times (24 sts)")
        octopusPattern.append("Rnds 19-20: 1 sc in each single crochet around (24 sts)")
        octopusPattern.append("Rnd 21: *1sc in next 2 sc, sc2tog; rep from *, 6 times (18 sts)")
        octopusPattern.append("Rnd 22: 1sc in each single crochet around (18sts)")
        octopusPattern.append("Rnd 23: *1sc in next 7 single crochet, sc2tog; rep from *, 2 times (16 sts)")
        octopusPattern.append("Rnd 24: 1sc in each single crochet around (16 sts)")
        
        counterButtonLabel.setTitle("0", for: .normal)
        frogButton.imageView?.contentMode = .scaleAspectFit
        
        
    }
    
    @IBAction func counterButtonTapped(_ sender: UIButton) {

        counter += 1
        //indexPath.row then do if statement for counter count against # of stitches. once i find a match, i highlight the next row.
        
        for number in totalStitchesPerIncreaseRound {
            
            
            if counter == number {
                totalStitchesPerIncreaseRound.removeFirst()
                
                currentRow += 1
                counter = 0
                //  tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
                
            }
            
            counterButtonLabel.setTitle("\(counter)", for: .normal)
            
            // repeating middle rounds
            for round in sevenFourteenRounds {
                
                if currentRow == round {
                    
                    tableView.selectRow(at: IndexPath(row: 2, section: 0), animated: false, scrollPosition: .none)
                    //deselects it instead coz it was already selected
                    //something to do "func setSelected" in cell class
                 }
                else {
                    tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
                    
                }
            }
         
        }
        
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
        return octopusPattern.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatternRowTableViewCell", for: indexPath) as! PatternRowTableViewCell
        
        cell.rowPatternLabel.text = octopusPattern[indexPath.row]
        
        return cell
    }
}


extension OctopusPatternViewController: UITableViewDelegate {
    
}
