//
//  HeroesViewModel.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 28/4/24.
//

import Foundation
import KCWidgets


final class HeroesViewModel: ObservableObject {
    @Published var heroes: [HeroDetail] = []

    init() {
        loadHeroes()
    }

    private func loadHeroes() {
        if let loadedHeroes = getAllHeroes(groupName: appGroup, forKey: "heroes", castTo: [HeroDetail].self) {
            heroes = loadedHeroes
        } else {
            // If UserDefaults is empty, initialize from the singleton and save to UserDefaults
            heroes = HeroesSingleton.shared.heroes
            saveAllHeroes(groupName: appGroup, forKey: "heroes", heroes)
        }
    }
}
