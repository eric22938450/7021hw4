//
//  ChampionData.swift
//  7021hw4
//
//  Created by User16 on 2020/6/25.
//  Copyright © 2020 ntou. All rights reserved.
//

import Foundation

class ChampionData: ObservableObject {
    
    @Published var champions = [Champion]() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(champions) {
                UserDefaults.standard.set(data, forKey: "champions")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "champions") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Champion].self, from: data) {
                champions = decodedData
            }
        }
    }
    
}

