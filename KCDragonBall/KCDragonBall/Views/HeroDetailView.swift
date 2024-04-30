//
//  HeroDetailView.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 28/4/24.
//

import SwiftUI
import KCWidgets
import WidgetKit

struct HeroDetailView: View {
    @StateObject var viewModel : HeroViewModel
    
    var body: some View {
        VStack{
            HeroAvatarView(character: viewModel.hero)
                .padding()
            VStack(alignment: .leading, spacing: 24) {
                Text("HP: \(viewModel.hero.healthLevel)")
                KCProgressBarView(health: viewModel.hero.healthLevel)
            }.padding()
            HStack {
                Button {
                    //viewModel.startRecovery()
                    viewModel.startCounter()
                } label: {
                    Text("Recuperar")
                }
                
                Button {
                    viewModel.deleteActivity()
                } label: {
                    Text("Eliminar Actividad")
                }
            }
            .buttonStyle(MyButtonStyle())
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 16) {
                    Text("Bio")
                        .font(.title)
                    Text("\(viewModel.hero.bio)")
                        .font(.caption)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                
            }
            .padding()
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) {_ in
            viewModel.actualizaHP()
            WidgetCenter.shared.reloadAllTimelines()
        }
    }

}

#Preview {
    HeroDetailView(viewModel: HeroViewModel(name: "Goku", provider: DefaultHeroDataProvider()))
}

struct HeroHealthView: View {
    let healthLevel: Int
    var body: some View{
        VStack(alignment: .leading, spacing: 24) {
            Text("HP: \(healthLevel)")
            KCProgressBarView(health: healthLevel)
        }.padding()
    }
}

