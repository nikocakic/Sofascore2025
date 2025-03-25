//
//  TeamViewModel.swift
//  Sofascore2025
//
//  Created by Niko on 25.03.2025..
//


import Foundation
import UIKit
import SofaAcademic

struct TeamViewModel {

    let image: UIImage
    let name: String
    let score: Int?
}

struct EventViewModel {

    let startTimeString: Int
    let statusString: EventStatus
    let homeTeam: TeamViewModel
    let awayTeam: TeamViewModel
}

struct LeagueViewModel{
    let leagueName: String
    let countryName: String
    let image: UIImage
}


