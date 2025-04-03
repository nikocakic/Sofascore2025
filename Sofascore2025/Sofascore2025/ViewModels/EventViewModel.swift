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
    
    init (event: Event, homeTeam: TeamViewModel, awayTeam: TeamViewModel){
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

