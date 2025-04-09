//
//  SportLogoViewModel.swift
//  Sofascore2025
//
//  Created by Niko on 01.04.2025..
//

import Foundation
import UIKit
import SofaAcademic


struct SportLogoViewModel {
    var isSelected: Bool
    var sportEnum: SportType
    
    init(isSelected: Bool, sportEnum: SportType) {
        self.isSelected = isSelected
        self.sportEnum = sportEnum
    }
}
import UIKit

enum SportType {
    case football
    case basketball
    case americanFootball

    var name: String {
        switch self {
        case .football: return "Football"
        case .basketball: return "Basketball"
        case .americanFootball: return "Am. Football"
        }
    }

    var icon: UIImage {
        switch self {
        case .football: return UIImage(named: "footballIcon") ?? UIImage()
        case .basketball: return UIImage(named: "basketballIcon") ?? UIImage()
        case .americanFootball: return UIImage(named: "amFootballIcon") ?? UIImage()
        }
    }

    init?(fromName name: String) {
        switch name {
        case "Football":
            self = .football
        case "Basketball":
            self = .basketball
        case "Am. Football":
            self = .americanFootball
        default:
            return nil
        }
    }
}




