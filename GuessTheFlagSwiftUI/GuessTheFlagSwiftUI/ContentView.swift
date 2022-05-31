//
//  ContentView.swift
//  GuessTheFlagSwiftUI
//
//  Created by Kostya Ozhiganov on 31.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["USA", "UK", "Greece", "Bangladesh", "Germany", "Argentina", "Brazil", "Canada", "Sweden", "mordor"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.red, .yellow],
                startPoint: .topLeading,
                endPoint: .bottom
            )
            
            .ignoresSafeArea(.container, edges: [.top, .horizontal, .bottom])
            VStack (spacing: 20){
                VStack{
                    Text("Choose the Flag:")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                        .bold()
                    Text(countries[correctAnswer])
                        .font(.title)
                        .foregroundColor(Color.black)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showScore = true
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 220, height: 120)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 0.5)
                    }
                }
                Text("Score is \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
        }.alert(isPresented: $showScore){
            Alert(title: Text(scoreTitle), message: Text("Total score \(score)"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
    }
}
        func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Incorrect! This is \(countries[number])"
            score -= 1
        }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        }
    }
}
