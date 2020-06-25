//
//  AppView.swift
//  7021hw4
//
//  Created by User16 on 2020/6/25.
//  Copyright © 2020 ntou. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var championData = ChampionData()
        var body: some View {
            TabView {
                ChampionList(championData: self.championData).tabItem {
                    Image(systemName: "heart")
                    Text("比賽紀錄")
                }
                PieChartView(championData: self.championData).tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("比賽分析")
                }
            }
        }
    }
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

