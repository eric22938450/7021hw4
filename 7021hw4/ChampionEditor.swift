//
//  ChampionEditor.swift
//  7021hw4
//
//  Created by User16 on 2020/6/25.
//  Copyright © 2020 ntou. All rights reserved.
//

import SwiftUI

struct ChampionEditor: View {
@Environment(\.presentationMode) var presentationMode
    var championData: ChampionData
    var varietys = ["控衛", "得後", "小前", "大前", "中鋒"]
    @State private var Mark = true
    @State private var ChampionName = ""
    @State private var Variety = "控衛"
    @State private var Result = true
    @State private var Time = Date()
    @State private var Kill = ""
    @State private var Death = ""
    @State private var Assist = ""
    let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       dateFormatter.timeStyle = .medium
       return dateFormatter
    }()
    var editChampion: Champion?
    
    var body: some View {
        Form {
            
            TextField("名稱 or 綽號 ",text: $ChampionName)

            .font(.largeTitle)
            .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.black, lineWidth: 2))
            .frame(width: 380, height: 50)
            .multilineTextAlignment(.center)
            Toggle("是明星球員嗎", isOn: $Mark)
            Picker(selection: $Variety, label: Text("這場打什麼位置")) {
              ForEach(varietys, id: \.self) { (Variety) in
                  Text(Variety)
               }
            }
            .frame(width: 300, height: 50)
            .cornerRadius(30)
            .shadow(radius: 30)
            .clipped()
            Toggle("勝負", isOn: $Result)
            TextField("得幾分",text: $Kill)
            TextField("抓幾籃板",text: $Death)
            TextField("傳幾助攻",text: $Assist)
            VStack {
               DatePicker("比賽的日期", selection: $Time, displayedComponents: .date)
            }
            
        }
        .navigationBarTitle( "球員紀錄")
        .navigationBarItems(trailing: Button("Save") {
            let champion = Champion(Mark: self.Mark, Result: self.Result, ChampionName: self.ChampionName,  Variety: self.Variety, Time: self.Time, Kill: self.Kill, Death: self.Death, Assist: self.Assist)
            if let editChampion = self.editChampion {
                let index = self.championData.champions.firstIndex {
                    $0.id == editChampion.id
                    }!
                self.championData.champions[index] = champion
            } else {
                self.championData.champions.insert(champion, at: 0)
            }
            self.presentationMode.wrappedValue.dismiss()
            
        })
        .onAppear {
            if let editChampion = self.editChampion {
                self.Mark = editChampion.Mark
                self.ChampionName = editChampion.ChampionName
                self.Variety = editChampion.Variety
                self.Result = editChampion.Result
                self.Time = editChampion.Time
                self.Kill = editChampion.Kill
                self.Death = editChampion.Death
                self.Assist = editChampion.Assist
            }
        }
    }
}

struct ChampionEditor_Previews: PreviewProvider {
    static var previews: some View {
        ChampionEditor(championData: ChampionData())
    }
}
