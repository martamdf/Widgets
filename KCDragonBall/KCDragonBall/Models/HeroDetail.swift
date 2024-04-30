//
//  HeroDetail.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 28/4/24.
//

import Foundation

class HeroDetail: Codable, Identifiable, Equatable {
    static func == (lhs: HeroDetail, rhs: HeroDetail) -> Bool {
        return lhs.name == rhs.name
    }
    
    let name: String
    let photo: String
    var healthLevel: Int
    let bio: String
    var favorite: Bool
    
    var isHealing: Bool = false
    var startHealingDate: Date = Date()
    
    init(name: String, photo: String, healthLevel: Int, bio: String, favorite: Bool) {
        self.name = name
        self.photo = photo
        self.healthLevel = healthLevel
        self.bio = bio
        self.favorite = favorite
    }
}

