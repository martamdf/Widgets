//
//  HeroDataProvider.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 28/4/24.
//

import Foundation

protocol HeroDataProvider {
    func fetchHeroes(forKey key: String) -> [HeroDetail]
}
