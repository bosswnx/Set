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
            CardView(card: card, matchedSuccessfully: game.matched)
                .onTapGesture {
                    game.choose(card)
                }
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
        .disabled(game.cardsInDeck.isEmpty)
    }
}

struct CardView: View {
    let card: SetGame.Card
    
    let matchedSuccessfully: Bool?
    
    var body: some View {
        ZStack {
            VStack(spacing: -1) {
                Spacer()
                ForEach(0..<card.number.rawValue, id:\.self) { _ in
                    Group {
                        ZStack {
                            switch card.shape {
                            case .shape1:
                                Diamond().fill().foregroundColor(.white)
                                Diamond().shading(card.shading)
                            case .shape2:
                                Ellipse().fill().foregroundColor(.white)
                                Ellipse().shading(card.shading)
                            case .shape3:
                                Rectangle().fill().foregroundColor(.white)
                                Rectangle().shading(card.shading)
                            }
                        }
                    }
                    .aspectRatio(2/1, contentMode: .fit)
                    .scaleEffect(0.8)
                }
                Spacer()
            }
        }
        .cardify(isSelected: card.isSelected, matchedSuccessfully: matchedSuccessfully, color: card.color)
        .foregroundColor(.red)
        .padding(CardConstants.cardsPadding)
    }
    
    private struct CardConstants {
        static let cardsPadding: CGFloat = 3
        static let cardsContentPadding: CGFloat = 15
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        return SetGameView(game: game)
    }
}
