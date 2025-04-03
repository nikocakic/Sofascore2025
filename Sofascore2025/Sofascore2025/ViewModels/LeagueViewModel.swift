//
//  TeamViewModel.swift
//  Sofascore2025
//
//  Created by Niko on 25.03.2025..
//


import Foundation
import UIKit
import SofaAcademic

struct LeagueViewModel {
    let leagueName: String
    let countryName: String
    let image: UIImage?

    init(league: League) {
        self.leagueName = league.name
        self.countryName = league.country?.name ?? "Nepoznato"
        self.image = DataMapper.imageUrlToUIImage(imageURL: league.logoUrl)
    }
}

