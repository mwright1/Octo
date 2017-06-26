//
//  RoundGroup.swift
//  Crochet Octopus Counter
//
//  Created by Mona Wright on 6/7/17.
//  Copyright © 2017 Mona Wright. All rights reserved.
//

import Foundation

class RoundGroup {
    
    enum State {
        case notStarted
        case inProgress
        case completed
    }
    
    var notes: String?
    var state = State.notStarted
    var text:String
    var stitchesPerRound:Int
    var totalRounds:Int
    var startingRound:Int
    var roundsCompleted:Int = 0
    
    init(text:String, stitchesPerRound:Int, totalRounds:Int, startingRound:Int, notes: String? = nil) {
        self.text = text
        self.stitchesPerRound = stitchesPerRound
        self.totalRounds = totalRounds
        self.startingRound = startingRound
        self.notes = notes
    }
    
    func updateState(lastRoundCompleted: Int) {
        if roundsCompleted == totalRounds {
            state = .completed
        }
        else if (roundsCompleted != 0 && roundsCompleted != totalRounds && totalRounds > 1)  || startingRound == lastRoundCompleted + 1 {
            state = .inProgress
        }
        else if roundsCompleted == 0 {
            state = .notStarted
        }
    }
}
