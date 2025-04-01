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
    var image: UIImage = UIImage(systemName: "photo")!
    var name: String = "Unknown"
    var score: Int? = nil
    var goalsColor: UIColor? = .black
    var teamColor: UIColor? = .black
}

struct EventViewModel {
    var startTimeString: Int = 0
    var statusString: EventStatus = .notStarted
    var homeTeam: TeamViewModel = TeamViewModel()
    var awayTeam: TeamViewModel = TeamViewModel()
    
    var time: String = ""
    var minute: String = ""
    var minuteColor: UIColor = .semiTransparentDark
}

struct SportLogoViewModel {
    var image: UIImage = UIImage(systemName: "photo")!
    var sportName: String
    var isSelected: Bool
}
