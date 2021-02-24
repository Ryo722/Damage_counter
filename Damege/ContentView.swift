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
    
        Form {
            Section(header: Text("相手のバトルポケモン")){
                Stepper(value: $opponentdamage[0], in: 0...990, step: 10){
                    Text("\(opponentdamage[0], specifier: "%d")")
                }
            }
            Section(header: Text("相手のベンチポケモン")){
                Stepper(value: $opponentdamage[1], in: 0...990, step: 10){
                    Text("\(opponentdamage[1], specifier: "%d")")
                }
                Stepper(value: $opponentdamage[2], in: 0...990, step: 10){
                    Text("\(opponentdamage[2], specifier: "%d")")
                }
                Stepper(value: $opponentdamage[3], in: 0...990, step: 10){
                    Text("\(opponentdamage[3], specifier: "%d")")
                }
                Stepper(value: $opponentdamage[4], in: 0...990, step: 10){
                    Text("\(opponentdamage[4], specifier: "%d")")
                }
                Stepper(value: $opponentdamage[5], in: 0...990, step: 10){
                    Text("\(opponentdamage[5], specifier: "%d")")
                }
                Stepper(value: $opponentdamage[6], in: 0...990, step: 10){
                    Text("\(opponentdamage[6], specifier: "%d")")
                }
                Stepper(value: $opponentdamage[7], in: 0...990, step: 10){
                    Text("\(opponentdamage[7], specifier: "%d")")
                }
                Stepper(value: $opponentdamage[8], in: 0...990, step: 10){
                    Text("\(opponentdamage[8], specifier: "%d")")
                }
            }
        }
        Form {
            Section(header: Text("自分のバトルポケモン")){
                Stepper(value: $owndamage[0], in: 0...990, step: 10){
                    Text("\(owndamage[0], specifier: "%d")")
                }
            }
            
            Section(header: Text("自分のベンチポケモン")){
                Stepper(value: $owndamage[1], in: 0...990, step: 10){
                    Text("\(owndamage[1], specifier: "%d")")
                }
                Stepper(value: $owndamage[2], in: 0...990, step: 10){
                    Text("\(owndamage[2], specifier: "%d")")
                }
                Stepper(value: $owndamage[3], in: 0...990, step: 10){
                    Text("\(owndamage[3], specifier: "%d")")
                }
                Stepper(value: $owndamage[4], in: 0...990, step: 10){
                    Text("\(owndamage[4], specifier: "%d")")
                }
                Stepper(value: $owndamage[5], in: 0...990, step: 10){
                    Text("\(owndamage[5], specifier: "%d")")
                }
                Stepper(value: $owndamage[6], in: 0...990, step: 10){
                    Text("\(owndamage[6], specifier: "%d")")
                }
                Stepper(value: $owndamage[7], in: 0...990, step: 10){
                    Text("\(owndamage[7], specifier: "%d")")
                }
                Stepper(value: $owndamage[8], in: 0...990, step: 10){
                    Text("\(owndamage[8], specifier: "%d")")
                }
            }
        }
    }
}

struct ConditionlistView: View {
    @ObservedObject var condition: ViewModel
    
    var body: some View{
        Form{
            Section(header: Text("相手のバトルポケモン")){
                Toggle(isOn: $condition.opponentcondition[0]){
                    Text("どく")
                }
                Toggle(isOn: $condition.opponentcondition[1]){
                    Text("やけど")
                }
                Toggle(isOn: $condition.opponentcondition[2]){
                    Text("ねむり")
                }
                Toggle(isOn: $condition.opponentcondition[3]){
                    Text("まひ")
                }
                Toggle(isOn: $condition.opponentcondition[4]){
                    Text("こんらん")
                }
            }
            Section(header: Text("自分のバトルポケモン")){
                Toggle(isOn: $condition.owncondition[0]){
                    Text("どく")
                }
                Toggle(isOn: $condition.owncondition[1]){
                    Text("やけど")
                }
                Toggle(isOn: $condition.owncondition[2]){
                    Text("ねむり")
                }
                Toggle(isOn: $condition.owncondition[3]){
                    Text("まひ")
                }
                Toggle(isOn: $condition.owncondition[4]){
                    Text("こんらん")
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
