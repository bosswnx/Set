//
//  SetGame.swift
//  Set
//
//  Created by 王诺贤 on 2022/8/25.
//

import Foundation

struct SetGame {
    private(set) var cardsInDeck: Array<Card>
    private(set) var cardsOnTable: Array<Card>
    
    struct Card: Hashable, Identifiable {
        var isMatched = false
        var isSelected = false
        let id: Int
        let color: Color
        let shape: Shape
        let shading: Shading
        let number: Number
    }
    
    enum Color: CaseIterable {
        case color1, color2, color3
    }
    
    enum Shape: CaseIterable {
        case shape1, shape2, shape3
    }
    
    enum Shading: CaseIterable {
        case shading1, shading2, shading3
    }
    
    enum Number: CaseIterable {
        case one, two, three
    }
}
