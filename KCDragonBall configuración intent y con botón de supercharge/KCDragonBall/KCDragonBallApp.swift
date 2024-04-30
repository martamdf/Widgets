//
//  KCDragonBallApp.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 28/4/24.
//

import SwiftUI

@main
struct KCDragonBallApp: App {
    var body: some Scene {
        WindowGroup {
            HeroesView()
                .environmentObject(HeroesViewModel())
        }
    }
}

