//
//  ContentView.swift
//  CatchTheBall
//
//  Created by Atakan Cengiz KURT on 13.10.2021.
//

import SwiftUI

struct ContentView: View {
  @State var score = 0
  @State var timeLeft = 10.0
  @State var chosenX = 200
  @State var chosenY = 300
  @State var showAlert = false
  
  let x = [70,200,330]
  let y = [140,300,460]
  
  var counterTimer: Timer {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      if self.timeLeft < 0.5{
        self.showAlert = true
      }else{
      self.timeLeft -= 1
      }
    }
  }
  
  var timer : Timer {
    Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { _ in
      self.chosenX = x[Int.random(in: 0..<x.count)]
      self.chosenY = y[Int.random(in: 0..<y.count)]
    }
  }
  
  
  
  var body: some View {
    VStack{
      Spacer().frame( height: 100)
      Text("Catch The Ball")
        .font(.largeTitle)
      
      Text("Time Left: \(String(self.timeLeft))")
        .font(.title)
      Text("Score: \(String(self.score))")
        .font(.title)
      
      
      Spacer()
      Image("ball")
        .resizable()
        .frame(width: 100, height: 100, alignment: .center)
        .position(x: CGFloat(self.chosenX), y: CGFloat(self.chosenY))
        .gesture(TapGesture(count: 1).onEnded({ _ in
          self.score += 1
        }))
        .onAppear{
          _ = self.timer
          _ = self.counterTimer
        }
      
      Spacer()
    }
    .alert(isPresented: $showAlert, content: {
      return Alert(title: Text("Time Over!"), message: Text("Want to Play Again?"), primaryButton: Alert.Button.default(Text("Ok"), action: {
        self.score = 0
        self.timeLeft = 10.0
      
      }), secondaryButton: Alert.Button.cancel())
    })
    
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    
  }
}
