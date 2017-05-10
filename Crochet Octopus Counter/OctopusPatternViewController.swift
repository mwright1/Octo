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
    
    var counter = 0
    
    var octopusPattern: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHeightConstraint.constant = (view.frame.size.height - frogButton.frame.size.height)/2
        
        octopusPattern.append("Rnd 1: 6 sc in Magic Ring, mark beginning of each round with stitch marker (6 sts)")
        octopusPattern.append("blah")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        
        counterButtonLabel.setTitle("0", for: .normal)
        frogButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func counterButtonTapped(_ sender: UIButton) {
        counter += 1
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
