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
}
