//
//  ContentView.swift
//  Set
//
//  Created by 王诺贤 on 2022/8/25.
//

import SwiftUI

struct SetGameView: View {
    typealias Card = SetGame.Card
    
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            HStack {
                themeButton
                Spacer()
                newGameButton
            }
            Spacer()
            gameBody
            Spacer()
            deal3MoreCardsButton
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cardsOnTable, aspectRatio: 2/3) { card in
            CardView(card: card)
        }
    }
    
    var themeButton: some View {
        Button("Theme") {
            
        }
    }
    
    var newGameButton: some View {
        Button("New Game") {
            game.startNewGame()
        }
    }
    
    var deal3MoreCardsButton: some View {
        Button("Deal 3 More Cards") {
            game.deal3MoreCards()
        }
    }
}

struct CardView: View {
    let card: SetGame.Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill()
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(lineWidth: 3)
            Diamond()
        }
        .foregroundColor(.red)
        .padding(2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        return SetGameView(game: game)
    }
}
