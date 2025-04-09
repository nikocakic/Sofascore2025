//
//  Untitled.swift
//  Sofascore2025
//
//  Created by Niko on 26.03.2025..
//

import Foundation
import UIKit
import SofaAcademic

struct EventViewModel {
    var startTimeString: Int
    var statusString: EventStatus
    var homeTeam: TeamViewModel
    var awayTeam: TeamViewModel
    
    var time: String
    var minute: String
    var minuteColor: UIColor
    
    init (event: Event){
        self.homeTeam = TeamViewModel(team: event.homeTeam, score: event.homeScore, status: event.status, otherTeamGoal: event.awayScore)
        self.awayTeam = TeamViewModel(team: event.awayTeam, score: event.awayScore, status: event.status, otherTeamGoal: event.homeScore)
        
        self.startTimeString = event.startTimestamp
        self.statusString = event.status
        
        let result = Self.updateMinuteLabel(event: event)
        self.time = result.time
        self.minute = result.minute
        self.minuteColor = result.minuteColor
    }
    
    static func updateMinuteLabel(event: Event) -> (time: String, minute: String, minuteColor: UIColor) {
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)

        let calendar = Calendar.current
        let minuteValue = calendar.component(.minute, from: date)

        var minute = "-"
        var minuteColor: UIColor = .semiTransparentDark

        switch event.status {
        case .notStarted:
            minute = "-"
        case .inProgress:
            minute = "\(minuteValue)'"
            minuteColor = .red
        case .finished:
            minute = "FT"
        case .halftime:
            minute = "HT"
        }

        return (time, minute, minuteColor)
    }

}

