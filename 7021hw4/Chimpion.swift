//
//  Chimpion.swift
//  7021hw4
//
//  Created by User16 on 2020/6/25.
//  Copyright © 2020 ntou. All rights reserved.
//

import SwiftUI

struct Champion: Identifiable, Codable {
    var id = UUID()
    var Mark: Bool
    var Result: Bool
    var ChampionName: String
    var Variety: String
    var Time: Date
    var Kill: String
    var Death: String
    var Assist: String
}
