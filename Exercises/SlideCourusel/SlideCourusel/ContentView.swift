
//
//  ContentView.swift
//  Planets
//
//  Created by Георгий Усынин on 10.04.2020.
//  Copyright © 2020 Георгий Усынин. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width
    @State var op: CGFloat = 0
    
        @State var numberOfImages = 9
    //    @State var imageName = "planet"
    
    @State var data = [
        Card(id: 0, img: "planet1", name: "Солнце", show: false),
        Card(id: 1, img: "planet2", name: "Меркурий", show: false),
        Card(id: 2, img: "planet3", name: "Венера", show: false),
        Card(id: 3, img: "planet4", name: "Земля", show: false),
        Card(id: 4, img: "planet5", name: "Марс", show: false),
        Card(id: 5, img: "planet6", name: "Юпитер", show: false),
        Card(id: 6, img: "planet7", name: "Сатурн", show: false),
        Card(id: 7, img: "planet8", name: "Уран", show: false),
        Card(id: 8, img: "planet9", name: "Нептун", show: false)
    ]
    
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    ForEach(data) {i in
                        CardView(data: i)
                            .offset(x: self.x)
                            
                            .highPriorityGesture(DragGesture()
                                .onChanged({ (value) in
                                    
                                    if value.translation.width > 0 {
                                        self.x = value.location.x
                                    } else {
                                        self.x = value.location.x - self.screen
                                    }
                                })
                                .onEnded({ (value) in
                                    if value.translation.width > 0 {
                                        if value.translation.width > ((self.screen) / 2) && Int(self.count) != 0 {
                                            self.count -= 1
                                            self.x = -(self.screen) * self.count
                                        } else {
                                            self.x = -(self.screen) * self.count
                                        }
                                    } else {
                                        if -value.translation.width > ((self.screen) / 2) && Int(self.count) != (self.data.count - 1) {
                                            self.count += 1
                                            self.x = -(self.screen) * self.count
                                        } else {
                                            self.x = -(self.screen) * self.count
                                        }
                                    }
                                })
                        )
                    }
                }
                .offset(x: self.op)
                
                HStack(spacing: 0.0) {
                    Text("\(Int(count + 1))")
                    
                    Text("/\(Int(self.data.count))")
                    
                }
                .foregroundColor(Color.white)
                .frame(width: 40, height: 40)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .offset(x: screen / 2 - 40)
                .padding()
            }
            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.vertical)
        .animation(.spring())
        .onAppear{
            
          
            self.op = ((self.screen) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.screen) / 2) : 0)
            
  
        }
        
    }
    
    
}


struct CardView: View {
    
    var data : Card
    
    var body: some View {
        VStack {
            
            Image(data.img)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height:  400)
                .clipShape(Rectangle())
            .pinchToZoom()
            
            
        }
        
    }
}

struct Card : Identifiable {
    
    var id: Int
    var img : String
    var name : String
    var show : Bool
    
}


