//
//  PieChartView.swift
//  7021hw4
//
//  Created by User16 on 2020/6/25.
//  Copyright © 2020 ntou. All rights reserved.
//

import SwiftUI

import SwiftUI

struct PieChartView: View {
    
    @ObservedObject var championData = ChampionData()
    let variety=["控衛","得後","小前","大前","中鋒"]
    @State private var selectedAnalyzeItem = "位置"
    var analyzeItems = ["位置", "勝率",]
    var VarietyAngles: [Angle]
    var VarietyCount: [Double] = [0,0,0,0,0]
    var ResultCount: Double = 0
    var ResultAngles: [Angle]
    var ResultPercent: Double = 0
    
    init(championData: ChampionData)
    {
        self.championData = championData
        
        var totalCount: Double = 0
        
        for data in championData.champions
        {
            totalCount += 1
                if  data.Variety == "控衛"{
                    VarietyCount[0] += 1
                }
                else if  data.Variety == "得後"{
                    VarietyCount[1] += 1
                }
                else if  data.Variety == "小前"{
                    VarietyCount[2] += 1
                }
                else if  data.Variety == "大前"{
                    VarietyCount[3] += 1
                }
                else if  data.Variety == "中鋒"{
                    VarietyCount[4] += 1
                }
                if data.Result == true{
                ResultCount += 1
                }
        }
        var Percentages: [Double] = [0,0,0,0,0]
        Percentages[0] = VarietyCount[0] / totalCount
        Percentages[1] = VarietyCount[1] / totalCount
        Percentages[2] = VarietyCount[2] / totalCount
        Percentages[3] = VarietyCount[3] / totalCount
        Percentages[4] = VarietyCount[4] / totalCount
        VarietyAngles = [Angle]()
        var StartDegree: Double = 0
        for Percentages in Percentages
        {
            VarietyAngles.append(.degrees(StartDegree))
            StartDegree += 360 * Percentages
        }
        if Percentages[4] == 1.0
        {
            VarietyAngles[0] = .degrees(360)
        }
        
        var percentage: [Double] = [0,0]
        percentage[0] = ResultCount / totalCount
        percentage[1] = (totalCount-ResultCount) / totalCount
        ResultPercent = (totalCount-ResultCount) / totalCount
        ResultAngles = [Angle]()
        var startDegree: Double = 0
        for percentage in percentage
        {
            ResultAngles.append(.degrees(startDegree))
            startDegree += 360 * percentage
        }
        if percentage[1] == 1.0
        {
            ResultAngles[0] = .degrees(360)
        }
    }
    struct resultPieChart: View
    {
        var VarietyAngles: [Angle]
        var body: some View
        {
            VStack//(totalHeight:270)
            {
                ZStack//(height:200)
                {
                    PieChart(startAngle: VarietyAngles[0], endAngle: VarietyAngles[1])
                    .fill(Color.black)
                    PieChart(startAngle: VarietyAngles[1], endAngle: VarietyAngles[2])
                    .fill(Color.red)
                    PieChart(startAngle: VarietyAngles[2], endAngle: VarietyAngles[3])
                    .fill(Color.blue)
                    PieChart(startAngle: VarietyAngles[3], endAngle: VarietyAngles[4])
                    .fill(Color.green)
                    PieChart(startAngle: VarietyAngles[4], endAngle: VarietyAngles[0])
                    .fill(Color(hue: 0.975, saturation: 0.395, brightness: 0.958))
                    VStack{
                        
                    HStack{
                        Rectangle()
                        .fill(Color.black)
                        .frame(width: 10, height: 10)
                        Text("控衛")
                        Rectangle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                        Text("得後")
                        Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        Text("小前")
                    }
                    HStack{
                        Rectangle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                        Text("大前")
                        Rectangle()
                        .fill(Color(hue: 0.975, saturation: 0.395, brightness: 0.958))
                        .frame(width: 10, height: 10)
                        Text("中鋒")
                    }
                    }.offset(x:0, y: 200)
                }
                .frame(width: 250, height: 250)
                Spacer()
                .frame(height:40)
            }
        }
    }

    struct resultCircleChart: View {
        var ResultPercent: Double
        var body: some View {
            ZStack {
                Circle()
                    .stroke(Color.green, lineWidth: 20)
                Circle()
                    .trim(from: 0, to: CGFloat(ResultPercent))
                    .stroke(Color.red, lineWidth: 20)
                VStack{
                Text(String(format:"勝率%.0f%%", 100-(ResultPercent * 100))).font(Font.system(size:30))
                if ResultPercent == 0{
                    Text("厲害！")
                }
                else if ResultPercent == 1{
                    Text("打鐵")
                }
                }
            }.frame(width: 250, height: 250)
        }
    }
    
    var body: some View {
        VStack {
            Text("選擇項目：")
            Picker(selection: self.$selectedAnalyzeItem, label: Text("選擇項目："))
            {
                ForEach(self.analyzeItems, id: \.self)
                {
                    (analyzeItem) in
                    Text(analyzeItem)
                }
            }
            .labelsHidden()
            .pickerStyle(SegmentedPickerStyle())
            .padding(20)
            if self.championData.champions.count != 0
            {
                
                if self.selectedAnalyzeItem == "位置"
                {
                  resultPieChart(VarietyAngles: self.VarietyAngles)
                }
                else if self.selectedAnalyzeItem == "勝率"
                {
                    resultCircleChart(ResultPercent: self.ResultPercent)
                }
            }
            else
            {
                Text("去記錄數據吧～")
                .font(Font.system(size:30))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .frame(width:250, height:250)
                 .background(Color.gray)
                 .cornerRadius(150)
            }
        }
    }
}
