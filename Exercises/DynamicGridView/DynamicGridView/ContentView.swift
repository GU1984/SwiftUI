//
//  ContentView.swift
//  DynamicGridView
//
//  Created by 1 on 24.06.2020.
//  Copyright © 2020 GeorgeUsyninApp. All rights reserved.
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
    
    @State var data = [
        Type(name: "Earth", pic: "earth"),
        Type(name: "Mars", pic: "mars"),
        Type(name: "Venera", pic: "venera"),
        Type(name: "Mercury", pic: "mercury")
        
    ]
    
    @State var Grid : [Int] = []
    
    var body: some View {
        
        VStack(spacing: 0.0) {
            ZStack {
                HStack {
                    Button(action: {
                        self.data.append(Type(name: "Mars", pic: "mars"))
                        self.Grid.removeAll()
                        self.generateGrid()
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .frame(width: 25, height: 25)
                            .font(.title)
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "person")
                            .font(.title)
                            .foregroundColor(Color.gray)
                            .frame(width: 25, height: 25)
                    }
                }
                
                Text("Games")
                    .font(.title)
                    .fontWeight(.bold)
                
            }
            .padding()
            //            .padding(.top, 30)
            
            MainView(data: self.$data, Grid: self.$Grid)
            
            TabBar()
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.top))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear{
            self.generateGrid()
        }
        
        
    }
    
    func generateGrid() {
        for i in stride(from: 0, to: self.data.count, by: 2) {
            if i != self.data.count{
                self.Grid.append(i)
            }
        }
    }
}


struct TabBar: View {
    @State var index = 0
    
    var body: some View {
        
        HStack {
            Button(action: {
                self.index = 0
            }) {
                VStack {
                    Image(systemName: "house")
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .foregroundColor(self.index == 0 ? .red : .gray)
                    
                    if self.index == 0  {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 8, height: 8)
                    }
                    
                }
                
                Spacer()
                
                Button(action: {
                    self.index = 1
                }) {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .foregroundColor(self.index == 1 ? .red : .gray)
                        
                        if self.index == 1  {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    self.index = 2
                }) {
                    VStack {
                        Image(systemName: "bubble.left")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .foregroundColor(self.index == 2 ? .red : .gray)
                        
                        if self.index == 2  {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    self.index = 3
                }) {
                    VStack {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .foregroundColor(self.index == 3 ? .red : .gray)
                        
                        if self.index == 3  {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 35)
        .padding(.top, 12)
        .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 15)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.04), radius: 0, x: 0, y: -6)
        .animation(.default)
        
    }
}


struct Card : View {
    
    var data : Type
    
    var body: some View {
        
        VStack(spacing: 15.0) {
            Image(data.pic)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: (UIScreen.main.bounds.width - 45 ) / 2, height: 260)
                .cornerRadius(12)
            
            Text(data.name)
            
            Button(action: {
                
            }) {
                Text("Play Now")
                    .foregroundColor(Color.white)
                    .frame(width: (UIScreen.main.bounds.width - 70 ) / 2)
                    .padding(.vertical, 10)
            }.background(Color.red)
                .cornerRadius(10)
            
        }
        
    }
    
}

struct MainView : View {
    
    @Binding var data : [Type]
    @Binding var Grid: [Int]
    
    var body: some View {
        
        VStack {
            if !self.Grid.isEmpty {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 25.0) {
                        ForEach(self.Grid, id:  \.self) { i in
                            HStack(spacing: 15.0){
                                ForEach(i...i+1, id:  \.self) { j in
                                    VStack {
                                        if j != self.data.count{
                                            Card(data: self.data[j])
                                        }
                                    }
                                }
                                
                                if i == self.Grid.last && self.data.count % 2 != 0 {
                                    Spacer(minLength: 0)
                                }
                            }
                        }
                    }.padding()
                }
            }
        }
    }
}

struct Type {
    
    var name: String
    var pic: String
    
}
