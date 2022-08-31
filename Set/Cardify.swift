//
//  Cardify.swift
//  Set
//
//  Created by 王诺贤 on 2022/8/30.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isSelected: Bool
    var matchedSuccessfully: Bool?
    var color: SetGame.Color
    
    func body(content: Content) -> some View {
        return ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            shape.fill().foregroundColor(.white)
            if let matchedSuccessfully = matchedSuccessfully, isSelected {
                if matchedSuccessfully {
                    shape.fill().foregroundColor(.green).opacity(DrawingConstants.selectedOpacity)
                } else {
                    shape.fill().foregroundColor(.red).opacity(DrawingConstants.selectedOpacity)
                }
            } else if isSelected {
                shape.fill().foregroundColor(.yellow).opacity(DrawingConstants.selectedOpacity)
            }
            shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            content
        }
        .modifier(CardColor(color: color))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 2
        static let selectedOpacity: CGFloat = 0.25
    }
}

extension Shape {
    func shading(_ shading: SetGame.Shading) -> some View {
        ZStack {
            switch shading {
            case .shading1:
                self.opacity(0)
            case .shading2:
                self.opacity(0.3)
            case .shading3:
                self.opacity(1)
            }
            self.stroke()
        }
    }
}

private struct CardColor: ViewModifier {
    var color: SetGame.Color
    func body(content: Content) -> some View {
        switch color {
        case .color1:
            return content.foregroundColor(.red)
        case .color2:
            return content.foregroundColor(.green)
        case .color3:
            return content.foregroundColor(.blue)
        }
    }
}

extension View {
    func cardify(isSelected: Bool, matchedSuccessfully: Bool?, color: SetGame.Color) -> some View {
        self.modifier(Cardify(isSelected: isSelected, matchedSuccessfully: matchedSuccessfully, color: color))
    }
}
