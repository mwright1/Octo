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
    
    
    var octopusPattern: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        octopusPattern.append("Rnd 1: 6 sc in Magic Ring, mark beginning of each round with stitch marker (6 sts)")
        octopusPattern.append("blah")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
        octopusPattern.append("blahh")
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
