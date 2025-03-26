//
//  Untitled.swift
//  Sofascore2025
//
//  Created by Niko on 26.03.2025..
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
