//
//  ChampionRow.swift
//  7021hw4
//
//  Created by User16 on 2020/6/25.
//  Copyright © 2020 ntou. All rights reserved.
//

import SwiftUI

struct ChampionRow: View {
    var champion: Champion
    let dateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    var body: some View {
        HStack {
            
            Image(champion.Result ? "讚" : "倒讚")
               .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width:50, height: 50)
                .clipShape(Circle())
                
            VStack (alignment: .leading) {
                Text("球員:\(champion.ChampionName) ")
                Text("位置:\(champion.Variety)")
            }
        Text("\(champion.Kill)/\(champion.Death)/\(champion.Assist)")
            VStack (alignment: .leading) {
           
                   Text("\(dateFormatter.string(from: champion.Time))")
            }
            Image(champion.Mark ? "allstar" : "sbl")
            .resizable()
            .scaledToFill()
            .frame(width: 30, height: 30, alignment: .leading)
        }
    }
}

struct ChampionRow_Previews: PreviewProvider {
    static var previews: some View {
        ChampionRow(champion: Champion(Mark: true, Result: false, ChampionName: "james", Variety: "得後", Time: Date(), Kill: "23", Death: "10", Assist: "11"))
    }
}
