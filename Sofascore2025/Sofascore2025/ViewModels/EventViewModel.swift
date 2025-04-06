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
    var startTimeString: Int = 0
    var statusString: EventStatus = .notStarted
    var homeTeam: TeamViewModel
    var awayTeam: TeamViewModel
    
    var time: String = ""
    var minute: String = ""
    var minuteColor: UIColor = .semiTransparentDark
    
    init (event: Event){
        var homeTeam = TeamViewModel(team: event.homeTeam, score: event.homeScore)
        var awayTeam = TeamViewModel(team: event.awayTeam, score: event.awayScore)
        
        
        homeTeam.image = DataMapper.imageUrlToUIImage(imageURL: event.homeTeam.logoUrl) ?? UIImage()
        awayTeam.image = DataMapper.imageUrlToUIImage(imageURL: event.awayTeam.logoUrl) ?? UIImage()
        
        homeTeam = homeTeam.teamLoadColor(team: homeTeam, status: event.status, otherTeamGoal: event.awayScore)
        awayTeam = awayTeam.teamLoadColor(team: awayTeam, status: event.status, otherTeamGoal: event.homeScore)
        
        self.startTimeString = event.startTimestamp
        self.statusString = event.status
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self = self.updateMinuteLabel(event: self)
    }
    
    func updateMinuteLabel(event: EventViewModel) -> EventViewModel {
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

