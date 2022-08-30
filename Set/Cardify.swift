//
//  Cardify.swift
//  Set
//
//  Created by 王诺贤 on 2022/8/30.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    private var isSelected: Bool
    
    init(isSelected: Bool) {
        self.isSelected = isSelected
    }
    
    func body(content: Content) -> some View {
        
    }
}

extension View {
    func cardify(isSelected: Bool) -> some View {
        self.modifier(Cardify(isSelected: isSelected))
    }
}
