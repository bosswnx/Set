//
//  SetGameViewModel.swift
//  Set
//
//  Created by 王诺贤 on 2022/8/29.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    
    @Published private var model = SetGame()
    
    var cardsOnTable: Array<SetGame.Card> {
        model.cards.filter({ $0.isOnTable && !$0.isMatched })
    }
    
    // MARK: - Intent
    
    func startNewGame() {
        model = SetGame()
    }
    
    func deal3MoreCards() {
        model.deal3MoreCards()
    }
    
    
}