//
//  Diamond.swift
//  Set
//
//  Created by 王诺贤 on 2022/8/29.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let up = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let down = CGPoint(x: rect.midX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        
        var p = Path()
        p.move(to: up)
        p.addLine(to: left)
        p.addLine(to: down)
        p.addLine(to: right)
        p.addLine(to: up)
        return p
    }
}
