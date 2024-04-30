//
//  HeroSingleton.swift
//  KcHeroesWidgets
//
//  Created by Marta Maquedano on 12/3/24.
//

import Foundation

let appGroup = "group.DragonBallWidgetKC"

class HeroesSingleton {
    
    var heroes: [HeroDetail] = [vegeta, goku, trunks, freezer, krilin]
    
    static var shared: HeroesSingleton = {
        let instance = HeroesSingleton()
        
        return instance
    }()
    
    private init() {}
    
    static var vegeta = HeroDetail(
        name: "Vegeta",
        photo: "VegetaAvatar",
        healthLevel: 67,
        bio: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.",
        favorite: false)
    
    static var goku = HeroDetail(
        name: "Goku",
        photo: "GokuAvatar",
        healthLevel: 14,
        bio: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
        favorite: true)
    
    static var freezer = HeroDetail(
        name: "Freezer",
        photo: "FreezerAvatar",
        healthLevel: 48,
        bio: "Freezer es el villano más temido del universo Dragon Ball, es la maldad personificada. Es el responsable de la muerte de los padres de Goku, del Rey Vegeta, de los Saiyan del Planeta Vegeta, donde provocó un genocidio. La serie mostró en varias ocasiones su crueldad, ya que disfruta de la muerte y del sufrimiento de sus víctimas. Y no tiene límites. Freezer es la razón por la que Vegeta termina uniéndose a Goku. Tanto Vegeta como Freezer desean la inmortalidad, así que ambos compiten por reunir las bolas de Dragón. Finalmente todos se enfrentan a él. El propio Piccolo es resucitado y trasladado a Namek para enfrentarse al villano. Pronto revelará que tiene varias transformaciones más poderosas, siendo la forma final la más fuerte de todas. Trunks del Futuro consigue matarle, aunque más tarde será revivido para volver a dar guerra en Dragon Ball Super.",
        favorite: false)
    
    static var trunks = HeroDetail(
        name: "Trunks",
        photo: "TrunksAvatar",
        healthLevel: 22,
        bio: "Trunks es hijo de Bulma y Vegeta, pero tarda bastante en aparecer en la trama. Todo se vuelve más interesante cuando aparece un misterioso viajero del tiempo que se llama Trunks del Futuro, que será determinante en Dragon Ball Z. Este personaje es una versión del pequeño Trunks que ha viajado al pasado para advertir de las amenazas que pueden destruir el mundo. Es el único superviviente de los Guerreros Z en un futuro alternativo apocalíptico, así que utiliza la máquina del tiempo que inventa su madre para regresar al tiempo presente.",
        favorite: true)
    
    static var krilin = HeroDetail(
        name: "Krilin",
        photo: "KrilinAvatar",
        healthLevel: 83,
        bio: "Krilin lo tiene todo. Cuando aún no existían los 'memes', Krilin ya los protagonizaba. Junto a Yamcha ha sido objeto de burla por sus desafortunadas batallas en Dragon Ball Z. Inicialmente, Krilin era el mejor amigo de Goku siendo sólo dos niños que querían aprender artes marciales. El Maestro Roshi les entrena para ser dos grandes luchadores, pero la diferencia entre ambos cada vez es más evidente. Krilin era ambicioso y se ablanda con el tiempo. Es un personaje que acepta un papel secundario para apoyar el éxito de su mejor amigo Goku de una forma totalmente altruista.",
        favorite: false)
    
    static var defaultHero = HeroDetail(
        name: "Unknown",
        photo: "GokuAvatar",
        healthLevel: 100,
        bio: "",
        favorite: false)
}

