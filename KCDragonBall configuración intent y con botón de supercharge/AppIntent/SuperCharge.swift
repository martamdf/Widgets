//
//  SuperCharge.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 29/4/24.
//

import AppIntents

struct SuperCharge: AppIntent {
    
    static var title: LocalizedStringResource = "Heroes Supercharger"
    static var description = IntentDescription("All heroes get instant 100% health.")
    
    func perform() async throws -> some IntentResult {
        superCharge()
        return .result()
    }
    
}
