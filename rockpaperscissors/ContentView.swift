//
//  ContentView.swift
//  rockpaperscissors
//
//  Created by Atin Agnihotri on 05/06/21.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldWin = false
    private var rolls = ["Rock", "Paper", "Scissors"]
    @State private var moves = 1
    @State private var currentRoll = 0
    @State private var score = 0
    @State private var userAns = ""
    @State private var showScore = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Your score is \(score)")
                .padding()
                .border(Color.black, width: 1)
            Spacer()
            Text(shouldWin ? "Win against a \(rolls[currentRoll])" : "Lose against a \(rolls[currentRoll])")
                .padding()
            
            Spacer()
            VStack {
                ForEach(0..<rolls.count) { count in
                    Button (rolls[count]){
                        nextMove(userAns: rolls[count])
                    }
                }
                    .frame(minWidth: 20, idealWidth: 20, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: .infinity, alignment: .center)
                    .border(Color.black, width: 1)
            }
        }.alert(isPresented: $showScore) {
            Alert(title: Text("Your Score"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) )
        }
    }
    
    func nextMove(userAns: String) {
        scoreKeeping(userAns: userAns)
        if moves < 10 {
            moves += 1
            shouldWin = Bool.random()
            currentRoll = Int.random(in: 0...2)
        } else {
            showScore = true
        }
    }
    
    func rollPromptResolver(roll: String) -> String{
        switch roll {
            case "Rock":
                return shouldWin ? "Paper" : "Scissors"
            case "Paper":
                return shouldWin ? "Scissors" : "Rock"
            case "Scissors":
                return shouldWin ? "Rock" : "Paper"
            default:
                return "-1"
        }
    }
    
    func scoreKeeping(userAns: String) {
        let correctAns = rollPromptResolver(roll: rolls[currentRoll])
        if userAns == correctAns {
            score += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
