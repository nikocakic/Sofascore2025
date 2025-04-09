//
//  TeamViewModel.swift
//  Sofascore2025
//
//  Created by Niko on 01.04.2025..
//

import Foundation
import UIKit
import SofaAcademic

struct TeamViewModel {
    var image: UIImage?
    var name: String
    var score: Int?
    var goalsColor: UIColor?
    var teamColor: UIColor?
    
    init(team: Team, score: Int?, status: EventStatus, otherTeamGoal: Int?) {
        self.image = DataMapper.imageUrlToUIImage(imageURL: team.logoUrl) ?? UIImage()
        self.name = team.name
        if let score = score,
           let otherTeamGoal=otherTeamGoal{
            
            self.score = score
            let colors = teamLoadColor(team: team, score: score, status: status, otherTeamGoal: otherTeamGoal)
            
            self.teamColor = colors.teamColor
            self.goalsColor = colors.goalsColor
        }
        
        self.image = DataMapper.imageUrlToUIImage(imageURL: team.logoUrl) ?? UIImage()
        

    }
    
    func teamLoadColor(team: Team, score: Int?, status: EventStatus, otherTeamGoal: Int?) -> (teamColor: UIColor, goalsColor: UIColor) {
        var teamColor: UIColor = .black
        var goalsColor: UIColor = .black

        if status == .inProgress {
            goalsColor = .red
        }

        if status == .finished,
           let teamScore = score,
           let opponentScore = otherTeamGoal,
           teamScore < opponentScore {
            teamColor = .semiTransparentDark
            goalsColor = .semiTransparentDark
        }

        return (teamColor, goalsColor)
    }
}
