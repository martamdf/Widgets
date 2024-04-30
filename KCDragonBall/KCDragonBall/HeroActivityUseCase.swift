//
//  HeroActivityUseCase.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 7/4/24.
//

import Foundation
import ActivityKit

final class HeroActivityUseCase {
    
    static func startActivity(name: String,
                              image: String,
                              hp: Int) throws -> String {
        //Creamos la implementación
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return "" }
        
        let estimatedHealingDate = calculateHealingCompletionTime(currentHealth: hp)
        
        let initialState = StatusAttributes.ContentState(name: name, 
                                                         estimatedHour: estimatedHealingDate,
                                                         image: image,
                                                         hp: hp)

        let activityContent = ActivityContent(state: initialState, staleDate: estimatedHealingDate)//estimatedHealingDate)
        let attributes = StatusAttributes()
        
        do{
            let activity = try Activity.request(attributes: attributes, content: activityContent)
            return activity.id
        } catch {
            throw error
        }
    }
    
    static func endActivity(withActivityIdentifier activityIdentifier: String) async {
        let value = Activity<StatusAttributes>.activities.first(where: { $0.id == activityIdentifier })
        await value?.end(nil)
    }
}
