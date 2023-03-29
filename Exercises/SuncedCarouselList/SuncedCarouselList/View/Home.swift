//
//  Home.swift
//  SuncedCarouselList
//
//  Created by Георгий Усынин on 12.01.2022.
//

import SwiftUI

struct Home: View {
    
    @State var posts: [Post] = staticData
    
    @State var currentPost : String = ""
    
    @State var fullPrreview : Bool = false
    
    var body: some View {
        TabView(selection: $currentPost) {
            ForEach(posts) { post in
                GeometryReader {proxy in
                    
                    let size = proxy.size
                    
                    Image(post.postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(0)
                }
                .tag(post.id)
                .edgesIgnoringSafeArea(.all)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            withAnimation {
                fullPrreview.toggle()
            }
        }
        
        
        //Top detail view
        .overlay(
            HStack {
                Text("Scenatio Pic's")
                    .font(.title2.bold())
                Spacer(minLength: 0)
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2)
                }

            }
                .foregroundColor(.white)
                .padding()
                .background(BlurView(style:
                                .systemUltraThinMaterialDark)
                                .ignoresSafeArea())
                .offset(y: fullPrreview ? -150 : 0),
            
            alignment: .top
        )
        
        //Bottom image View
        .overlay(
            ScrollViewReader{ proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(posts) {post in
                            Image (post.postImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 60)
                                .cornerRadius(12)
                                .padding(2)
                                .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(Color.white, lineWidth: 2)
                                    .opacity(currentPost == post.id ? 1 : 0)
                                )
                                .id(post.id)
                                .onTapGesture {
                                    withAnimation {
                                        currentPost = post.id
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .frame( height: 80)
                .background(BlurView(style:
                                .systemUltraThinMaterialDark)
                                .ignoresSafeArea())
                .onChange(of: currentPost) { _ in
                    withAnimation {
                        proxy.scrollTo(currentPost, anchor: .bottom)
                    }
                }
            }
                .offset(y: fullPrreview ? 150 : 0),
            alignment: .bottom
        )
        .onAppear{
            currentPost = posts.first?.id ?? ""
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
