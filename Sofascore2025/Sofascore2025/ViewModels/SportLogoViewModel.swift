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
    var image: UIImage = UIImage(systemName: "photo")!
    var sportName: String
    var isSelected: Bool
    
    init(image: UIImage, sportName: String, isSelected: Bool) {
        self.image = image
        self.sportName = sportName
        self.isSelected = isSelected
    }
}

