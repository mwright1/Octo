//
//  OctopusPatternViewController.swift
//  Crochet Octopus Counter
//
//  Created by Mona Wright on 5/4/17.
//  Copyright © 2017 Mona Wright. All rights reserved.
//

import UIKit

class Round {
    var text:String
    var totalStitches:Int
    init(text:String, totalStitches:Int) {
        self.text = text
        self.totalStitches = totalStitches
    }
}

class OctopusPatternViewController: UIViewController {
    @IBOutlet weak var uncheckedButton: UIButton!
    @IBOutlet weak var counterButton: UIButton!
    @IBOutlet weak var counterButtonLabel: UIButton!
    @IBOutlet weak var frogButton: UIButton!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    var counter = 0
    var currentRow = 0
    var rounds:[Round] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
        
        tableViewHeightConstraint.constant = (view.frame.size.height - frogButton.frame.size.height)/2
        
        rounds.append(Round(text: "Rnd 1: 6 sc in Magic Ring, mark beginning of each round with stitch marker (6 sts)", totalStitches: 2))
        rounds.append(Round(text: "2sc in each sc around (12 sts)", totalStitches: 2))
        rounds.append(Round(text: "*1sc in next sc, 2sc in next sc; rep from *, 6 times (18 sts)", totalStitches: 4))
        rounds.append(Round(text: "*1sc in next 2 sc, 2sc in next sc; rep from *, 6 times (24 sts)", totalStitches: 4))
        rounds.append(Round(text: "*1sc in next 3 sc, 2sc in next sc; rep from *, 6 times (30 sts)", totalStitches: 6))
        rounds.append(Round(text: "*1sc in next 4 sc, 2sc in next sc; rep from *, 6 times (36 sts)", totalStitches: 6))
        rounds.append(Round(text: "Rnds 7-14: Sc in each single crochet around (36 sts)", totalStitches: 6))
        rounds.append(Round(text: "Rnd 15: *1sc in next 4 sc, sc2tog; rep from *, 6 times (30 sts)", totalStitches: 6))
        rounds.append(Round(text: "Rnds 16-17: 1sc in each single crochet around (30 sts)", totalStitches: 6))
        rounds.append(Round(text: "Rnd 18: *1sc in next 3 sc, sc2tog; rep from *, 6 times (24 sts)", totalStitches: 6))
        rounds.append(Round(text: "Rnds 19-20: 1 sc in each single crochet around (24 sts)", totalStitches: 6))
        rounds.append(Round(text: "Rnd 21: *1sc in next 2 sc, sc2tog; rep from *, 6 times (18 sts)", totalStitches: 6))
        rounds.append(Round(text: "Rnd 22: 1sc in each single crochet around (18sts)", totalStitches: 6))
        rounds.append(Round(text: "Rnd 23: *1sc in next 7 single crochet, sc2tog; rep from *, 2 times (16 sts)", totalStitches: 6))
        rounds.append(Round(text: "Rnd 24: 1sc in each single crochet around (16 sts)", totalStitches: 6))
        
        counterButtonLabel.setTitle("0", for: .normal)
        
        frogButton.imageView?.contentMode = .scaleAspectFit
        
    }
    
    @IBAction func counterButtonTapped(_ sender: UIButton) {
        counter += 1
                
        if counter == rounds[currentRow].totalStitches {
            currentRow += 1
            counter = 0
            
            tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
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
        return rounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatternRowTableViewCell", for: indexPath) as! PatternRowTableViewCell
        
        cell.rowPatternLabel.text = rounds[indexPath.row].text
        
        return cell
    }
}


extension OctopusPatternViewController: UITableViewDelegate {
    
}
