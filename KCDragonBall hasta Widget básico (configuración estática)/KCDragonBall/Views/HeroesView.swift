//
//  HeroesView.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 28/4/24.
//

import SwiftUI

struct HeroesView: View {
    @EnvironmentObject var viewModel: HeroesViewModel
    
    var body: some View {
        NavigationStack {
            List (viewModel.heroes) { hero in
                NavigationLink(destination: HeroDetailView(viewModel: HeroViewModel(name: hero.name, provider: DefaultHeroDataProvider()))) {
                    HeroAvatarView(character: hero)
                }
                .padding()
            }
            .navigationBarTitle("Dragon Ball Heroes")
        }
    }
}

#Preview {
    HeroesView()
        .environmentObject(HeroesViewModel())
}
