//
//  TeamViewModel.swift
//  Sofascore2025
//
//  Created by Niko on 25.03.2025..
//


import Foundation
import UIKit

struct TeamViewModel {

    let image: UIImage
    let name: String
    let score: String?
}

struct EventViewModel {

    let startTimeString: String
    let statusString: String
    let homeTeam: TeamViewModel
    let awayTeam: TeamViewModel
}