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
    var image: UIImage = UIImage(systemName: "photo")!
    var name: String = "Unknown"
    var score: Int? = nil
    var goalsColor: UIColor? = .black
    var teamColor: UIColor? = .black
    
    init(team: Team, score: Int?) {
        self.image = DataMapper.imageUrlToUIImage(imageURL: team.logoUrl) ?? UIImage()
        self.name = team.name
        if let score = score {
            self.score = score
        }

    }
    
    func teamLoadColor(team: TeamViewModel, status: EventStatus, otherTeamGoal: Int?) -> TeamViewModel{
        var modifiedTeam = team

        if status == .finished || status == .inProgress {
            if status == .inProgress {
                modifiedTeam.goalsColor = .red
            }

            if let teamScore = modifiedTeam.score, let opponentScore = otherTeamGoal,
               teamScore < opponentScore, status == .finished {
                modifiedTeam.teamColor = .semiTransparentDark
            }
        }
        return modifiedTeam
    }
}
