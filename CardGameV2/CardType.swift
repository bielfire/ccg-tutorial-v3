//
//  CardType.swift
//  CardGame
//
//  Created by Gabriel Jacinto on 13/12/19.
//  Copyright © 2019 Brian Broom. All rights reserved.
//

import SpriteKit

enum CardType: Int {
    case wolf
    case bear
    case dragon
    case chicken
    
    var texture: SKTexture {
        switch self {
        case .wolf:
            return SKTexture(imageNamed: "card_creature_wolf")
        case .bear:
            return SKTexture(imageNamed: "card_creature_bear")
        case .dragon:
            return SKTexture(imageNamed: "card_creature_dragon")
        case .chicken:
            return SKTexture(imageNamed: "")
        }
    }
    
    var largeTexture: SKTexture {
        switch self {
        case .wolf:
            return SKTexture(imageNamed: "card_creature_wolf_large")
        case .bear:
            return SKTexture(imageNamed: "card_creature_bear_large")
        case .dragon:
            return SKTexture(imageNamed: "card_creature_dragon_large")
        case .chicken:
            return SKTexture(imageNamed: "")
        }
    }
}
