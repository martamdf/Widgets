//
//  HeroDetailViewModel.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 28/4/24.
//

import Foundation
import KCWidgets
import WidgetKit


final class HeroViewModel: ObservableObject {
    @Published var hero: HeroDetail
    weak var timer: Timer?
    
    init(name: String, provider: HeroDataProvider) {
        let allHeroes = provider.fetchHeroes(forKey: "heroes")
        self.hero = allHeroes.first(where: { $0.name == name }) ?? HeroesSingleton.defaultHero
    }
    
    func startRecovery() {
        timer?.invalidate()
        self.hero.isHealing = true
        self.hero.startHealingDate = Date.now
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            if(self.hero.healthLevel  < 100){
                self.hero.healthLevel += 1
                updateHero(groupName: appGroup, key: "heroes", hero: self.hero)
                self.objectWillChange.send() // Para que los cambios se vean Reflejados
            }
            else {
                self.hero.isHealing = false
                self.objectWillChange.send() // Para que los cambios se vean Reflejados
            }
        }
        updateHero(groupName: appGroup, key: "heroes", hero: self.hero)
        //WidgetCenter.shared.reloadAllTimelines()
    }
    
    func actualizaHP() {
        if hero.isHealing {
            self.hero.healthLevel = calculaHP(currentHP: hero.healthLevel, startHealingDate: hero.startHealingDate)
            self.objectWillChange.send()
            updateHero(groupName: appGroup, key: "heroes", hero: self.hero)
            startRecovery()
        }
    }
    
    func calculaHP(currentHP: Int, startHealingDate: Date) -> Int {
        let diff = Calendar.current.dateComponents([.second], from: startHealingDate, to: Date.now)
        let secondsElapsed = diff.second ?? 0
        var newHP = currentHP + Int(secondsElapsed/2)
        if(newHP > 100){
            newHP = 100
        }
        return newHP
    }
    
    deinit {
        timer?.invalidate()
    }
}



