//
//  DataMapper.swift
//  Sofascore2025
//
//  Created by Niko on 26.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

enum DataMapper {
    static func teamLoadColor(team: TeamViewModel, status : EventStatus, otherTeamGoal : Int?) -> TeamViewModel {
        var modifiedTeam = team

        if status == .finished || status == .inProgress {
            if status == .inProgress {
                modifiedTeam.goalsColor = .red
            }
            
            if (modifiedTeam.score! < otherTeamGoal! && status == .finished)  {
                modifiedTeam.teamColor = .semiTransparentDark
            }
        }
        
        return modifiedTeam
    }
    
    static func updateMinuteLabel(event: EventViewModel) -> EventViewModel {
        var modifiedEvent = event
        let date = Date(timeIntervalSince1970: TimeInterval(modifiedEvent.startTimeString))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        modifiedEvent.time = dateFormatter.string(from: date)

        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)

        switch modifiedEvent.statusString {
        case .notStarted:
            modifiedEvent.minute = "-"
        case .inProgress:
            modifiedEvent.minute  = "\(minute)'"
            modifiedEvent.minuteColor = .red
        case .finished:
            modifiedEvent.minute  = "FT"
        case .halftime:
            modifiedEvent.minute  = "HT"
        }
        return modifiedEvent
    }

}
