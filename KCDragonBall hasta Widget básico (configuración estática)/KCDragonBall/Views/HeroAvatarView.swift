//
//  HeroAvatarView.swift
//  KCDragonBall
//
//  Created by Marta Maquedano on 28/4/24.
//

import SwiftUI
import KCWidgets

struct HeroAvatarView: View {
    var character: HeroDetail
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Avatar(photo: character.photo)
                    NameView(name: character.name,
                                 isFav: character.favorite)
                }
            }
        }
    }
}

#Preview {
    HeroAvatarView(character: HeroesSingleton.goku)
}
