//
//  SetApp.swift
//  Set
//
//  Created by 王诺贤 on 2022/8/25.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            let game = SetGameViewModel()
            SetGameView(game: game)
        }
    }
}
