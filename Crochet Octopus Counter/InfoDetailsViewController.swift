//
//  InfoDetailsViewController.swift
//  Crochet Octopus Counter
//
//  Created by Mona Wright on 6/21/17.
//  Copyright © 2017 Mona Wright. All rights reserved.
//

import UIKit

class InfoDetailsViewController: UIViewController {
    
    var notes: String?
    
    @IBOutlet weak var tipsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipsTextView.text = notes
    }
    
}
