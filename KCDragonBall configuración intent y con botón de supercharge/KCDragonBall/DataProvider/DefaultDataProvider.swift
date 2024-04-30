//
//  DefaultDataProvider.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 28/4/24.
//

import Foundation
import KCWidgets

struct DefaultHeroDataProvider: HeroDataProvider {
    func fetchHeroes(forKey key: String) -> [HeroDetail] {
        return getAllHeroes(groupName: appGroup, forKey: key, castTo: [HeroDetail].self) ?? []
    }
}
