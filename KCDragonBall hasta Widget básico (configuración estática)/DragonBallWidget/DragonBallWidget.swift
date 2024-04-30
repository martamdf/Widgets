//
//  DragonBallWidget.swift
//  DragonBallWidget
//
//  Created by Marta Maquedano on 29/4/24.
//

import WidgetKit
import SwiftUI
import KCWidgets

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        createEntry(hero: HeroesSingleton.goku, hp: 14, date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(createEntry(hero: HeroesSingleton.goku, hp: 14, date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let hero = getHero(name: "Goku")
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
            HeroAvatarView(character: entry.hero)
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
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
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

#Preview(as: .systemSmall) {
    DragonBallWidget()
} timeline: {
    SimpleEntry(date: .now, relevance: nil, hero: HeroesSingleton.goku, hp: 20)
    SimpleEntry(date: .now, relevance: nil, hero: HeroesSingleton.goku, hp: 60)
}


func getHero(name: String) -> HeroDetail {
    let allHeroes = getAllHeroes(groupName: "group.DragonBallWidgetKC", forKey: "heroes", castTo: [HeroDetail].self)
    let hero = allHeroes?.first(where: { $0.name == name }) ?? HeroesSingleton.defaultHero
    
    return hero
}

//func getHero(name: String) -> HeroDetail {
//    let defaultObject = HeroesSingleton.goku
//    if let objects = UserDefaults(suiteName: "group.DragonBallWidgetKC")?.value(forKey: "heroes") as? Data {
//        let decoder = JSONDecoder()
//        if let objectsDecoded =
//            try? decoder.decode(Array.self, from: objects) as [HeroDetail] {
//            if let hero = objectsDecoded.first(where: {$0.name == name}) {
//                return hero
//            }
//        }
//    }
//    return defaultObject
//}

func calculaHP(hero: HeroDetail, currentDate: Date) -> Int {
    // Acceder a Calendar.current
    let calendar = Calendar.current
    let diff = calendar.dateComponents([.second], from: hero.startHealingDate, to: currentDate)
    let secondsElapsed = diff.second ?? 0

    // Calcular nueva HP y asegurarse de que no exceda 100 directamente.
    let newHP = min(hero.healthLevel + (secondsElapsed / 2), 100)
    
//    let calendar = Calendar.current
//    let currentDateTime = currentDate
//    let diff = calendar.dateComponents([.second], from: hero.startHealingDate, to: currentDateTime)
//    let secondsElapsed = diff.second ?? 0
//    var newHP = hero.healthLevel + Int(secondsElapsed/2)
//    if(newHP > 101){
//        newHP = 100
//    }
    return newHP

}


