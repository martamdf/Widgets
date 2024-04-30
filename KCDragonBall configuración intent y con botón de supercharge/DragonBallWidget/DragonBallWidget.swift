//
//  DragonBallWidget.swift
//  DragonBallWidget
//
//  Created by Marta Maquedano on 29/4/24.
//

import WidgetKit
import SwiftUI
import KCWidgets

struct Provider: IntentTimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        createEntry(hero: HeroesSingleton.goku, hp: 14, date: Date())
    }
    
    func character(for configuration: CharacterSelectionIntent) -> HeroDetail {
        switch configuration.hero {
            
        case .unknown:
            return getHero(name: "Trunks")
        case .goku:
            return getHero(name: "Goku")
        case .vegeta:
            return getHero(name: "Vegeta")
        case .trunks:
            return getHero(name: "Trunks")
        }
    }
    
    func getSnapshot(for configuration: CharacterSelectionIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(createEntry(hero: HeroesSingleton.goku, hp: 14, date: Date()))
    }
    
    func getTimeline(for configuration: CharacterSelectionIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let hero = character(for: configuration)
        var entries: [SimpleEntry] = []
        var currentDate = Date()
        let oneMinute: TimeInterval = 60

        if hero.isHealing {
            var hp = hero.healthLevel
            entries.append(createEntry(hero: hero, hp: hero.healthLevel, date: currentDate))

            while hp < 100 {
                currentDate += oneMinute
                let newHP = calculaHP(hero: hero, currentDate: currentDate)
                hp = newHP
                // Crear y añadir la nueva entrada con la fecha y hp actualizados.
                entries.append(createEntry(hero: hero, hp: newHP, date: currentDate))
            }
        }
        else {
            entries.append(createEntry(hero: hero, hp: hero.healthLevel, date: currentDate.addingTimeInterval(0.5)))
        }

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
    
    // Helper function to create entries
    private func createEntry(hero: HeroDetail, hp: Int, date: Date) -> SimpleEntry {
        SimpleEntry(date: date, relevance: TimelineEntryRelevance(score: Float(1)), hero: hero, hp: hp)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let relevance: TimelineEntryRelevance?
    let hero: HeroDetail
    let hp: Int
}

struct DragonBallWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            HStack {
                Avatar(photo: entry.hero.photo)
                if #available(iOS 17.0, *) {
                    SuperChargeButton(name: entry.hero.name)
                }
            }

            VStack(alignment: .leading, spacing: 24) {
                Text("HP: \(entry.hero.healthLevel)")
                KCProgressBarView(health: entry.hero.healthLevel)
            }
        }
    }
}

struct DragonBallWidget: Widget {
    let kind: String = "DragonBallWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: CharacterSelectionIntent.self, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                DragonBallWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DragonBallWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct SuperChargeButton: View {
    var name: String
    
    var body: some View {
        HStack(alignment: .top) {

            Button(intent: SuperCharge()) {
                Image(systemName: "bolt.fill")
            }
        }
        .tint(.yellow)
        .padding()
    }
}


#Preview(as: .systemSmall) {
    DragonBallWidget()
} timeline: {
    SimpleEntry(date: .now, relevance: nil, hero: HeroesSingleton.goku, hp: 20)
    SimpleEntry(date: .now, relevance: nil, hero: HeroesSingleton.goku, hp: 60)
}





