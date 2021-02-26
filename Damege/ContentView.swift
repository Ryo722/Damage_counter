//
//  ContentView.swift
//  Damege
//
//  Created by 花崎諒 on 2021/02/23.
//

import SwiftUI


final class ViewModel: ObservableObject {
    @Published var opponentcondition = [false,false,false,false,false]
    @Published var owncondition = [false,false,false,false,false]
}

struct ContentView: View {
    @State private var opponentdamage = [0,0,0,0,0,0,0,0,0]
    @State private var owndamage = [0,0,0,0,0,0,0,0,0]
    @State private var showAlert = false
    @State private var showcondition = false
    @State private var coin = "表"
    
    @ObservedObject var condition = ViewModel()
    
    
    var body: some View {
        HStack{
            Button("コイントス") {
                let randomBool = Bool.random()
                self.showAlert = true
                
                if randomBool {
                    coin = "表"
                }
                else{
                    coin = "裏"
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("コイントス結果"),
                    message: Text(coin),
                    dismissButton: .default(Text("OK"))
                )
            }
            Button("状態異常"){
                self.showcondition.toggle()
            }
            .sheet(isPresented: $showcondition){
                ConditionlistView(condition: self.condition)
            }
        }
        
        List{
            Section(header: Text("相手のポケモン")){
                ForEach( opponentdamage, id: \.self) { index in
                    Stepper(value: $opponentdamage[index], in: 0...990, step: 10){
                        Text("\(self.opponentdamage[index], specifier: "%d")")
                    }
                }
                /// 行入れ替え操作時に呼び出す処理の指定
                .onMove(perform: rowReplace)
            }
            .environment(\.editMode, .constant(.active))
        }
        .listStyle(InsetGroupedListStyle())
        
        List{
            Section(header: Text("自分のポケモン")){
                ForEach(0 ..< owndamage.count) { index in
                    Stepper(value: $owndamage[index], in: 0...990, step: 10){
                        Text("ポケモン\(index+1)　ダメージ:\(self.owndamage[index], specifier: "%d")")
                    }
                }
                /// 行入れ替え操作時に呼び出す処理の指定
                .onMove(perform: rowReplace)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    /// 行入れ替え処理
    func rowReplace(_ from: IndexSet, _ to: Int) {
        opponentdamage.move(fromOffsets: from, toOffset: to)
        owndamage.move(fromOffsets: from, toOffset: to)
        
    }
}

struct ConditionlistView: View {
    @ObservedObject var condition: ViewModel
    var conditionword = ["どく","やけど","ねむり","まひ","こんらん"]
    
    var body: some View{
        Form{
            Section(header: Text("相手のバトルポケモン")){
                ForEach(0 ..< condition.opponentcondition.count) { index in
                    Toggle(isOn: $condition.opponentcondition[index]){
                        Text("\(self.conditionword[index])")
                    }
                }
            }
            Section(header: Text("自分のバトルポケモン")){
                ForEach(0 ..< condition.owncondition.count) { index in
                    Toggle(isOn: $condition.owncondition[index]){
                        Text("\(self.conditionword[index])")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
