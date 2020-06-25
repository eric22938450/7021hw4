//
//  PieChart.swift
//  7021hw4
//
//  Created by User16 on 2020/6/25.
//  Copyright © 2020 ntou. All rights reserved.
//

import SwiftUI

struct PieChart: Shape
{
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path
    {
        Path{(path) in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)
            path.addArc(center: center, radius: rect.midX,
                startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
