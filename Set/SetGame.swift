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
    private var numberOfCardsSelected: Int {
        cardsOnTable.filter({ $0.isSelected }).count
    }
    private(set) var matched: Bool? = nil
    
    init() {
        cardsOnTable = []
        cardsInDeck = []
        var id = 0
        for color in SetGame.Color.allCases {
            for shape in SetGame.Shape.allCases {
                for shading in SetGame.Shading.allCases {
                    for number in SetGame.Number.allCases {
                        cardsInDeck.append(Card(id: id, color: color, shape: shape, shading: shading, number: number))
                        id += 1
                    }
                }
            }
        }
        cardsInDeck.shuffle()
        for _ in 0..<12 {
            cardsOnTable.append(cardsInDeck.first!)
            cardsInDeck.removeFirst()
        }
    }
    
    mutating func choose(_ card: Card) {
        if let wereMatched = matched {
            if wereMatched {
                deal3MoreCards()
            }
            matched = nil
            cardsOnTable.indices.forEach { cardsOnTable[$0].isSelected = false }
        }
        if let chosenIndex = cardsOnTable.firstIndex(where: { $0.id == card.id }) {
            cardsOnTable[chosenIndex].isSelected.toggle()
        }
        if numberOfCardsSelected == 3 {
            matched = matching()
            if matched! {
                cardsOnTable.indices.filter({ cardsOnTable[$0].isSelected }).forEach {
                    cardsOnTable[$0].isMatched = true
                }
            }
        }
    }
    
    private func matching() -> Bool {
        let cardsInMatching = cardsOnTable.filter({ $0.isSelected })
        let card1 = cardsInMatching[0]
        let card2 = cardsInMatching[1]
        let card3 = cardsInMatching[2]
        return ((card1.color == card2.color && card1.color == card3.color) ||
            (card1.color != card2.color && card1.color != card3.color && card2.color != card3.color)) &&
            ((card1.shape == card2.shape && card1.shape == card3.shape) ||
            (card1.shape != card2.shape && card1.shape != card3.shape && card2.shape != card3.shape)) &&
            ((card1.shading == card2.shading && card1.shading == card3.shading) ||
            (card1.shading != card2.shading && card1.shading != card3.shading && card2.shading != card3.shading)) &&
            ((card1.number == card2.number && card1.number == card3.number) ||
            (card1.number != card2.number && card1.number != card3.number && card2.number != card3.number))
    }
    
    mutating func deal3MoreCards() {
        var numberOfCardsRemaining: Int = cardsInDeck.isEmpty ? 0 : 3
        var cardsNeedRemove: Array<SetGame.Card> = []
        cardsOnTable.indices.forEach { index in
            if cardsOnTable[index].isMatched {
                if numberOfCardsRemaining > 0 {
                    cardsOnTable[index] = cardsInDeck.first!
                    cardsInDeck.removeFirst()
                    numberOfCardsRemaining -= 1
                } else {
                    cardsNeedRemove.append(cardsOnTable[index])
                }
            }
        }
        for card in cardsNeedRemove {
            cardsOnTable.remove(at: cardsOnTable.firstIndex(where: { $0.id == card.id })!)
        }
        for _ in 0..<numberOfCardsRemaining {
            cardsOnTable.append(cardsInDeck.first!)
            cardsInDeck.removeFirst()
        }
        matched = nil
    }
    
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
    
    enum Number: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
}
