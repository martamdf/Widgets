//
//  StatusAttributes.swift
//  KcHeroesWidgets
//
//  Created by Marta Maquedano on 7/4/24.
//

import Foundation
import ActivityKit

struct StatusAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var name: String
        var estimatedHour: Date
        var image: String
        var hp: Int
    }
}
