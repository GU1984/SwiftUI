//
//  Home.swift
//  Home
//
//  Created by Георгий Усынин on 21.09.2021.
//

import SwiftUI

struct Home: View {
    @State var posts : [Post] = []
    @State var columns: Int = 2
    
    var body: some View {
        NavigationView {
            StaggeredView(columns: columns, list: posts, content: { post in
                PostCardView(post: post)
            })
                .padding(.horizontal)
                .navigationTitle("Staggered Grid")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            columns += 1
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            columns = max(columns - 1, 1)
                        } label: {
                            Image(systemName: "minus")
                        }
                    }
                    
                }
                .animation(.easeInOut, value: columns)
        }
        .onAppear {
            for index in 1...10 {
                posts.append(Post(imageURL: "post\(index)"))
            }
                    
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct PostCardView: View {
    
    var post: Post
    
    var body: some View {
        Image(post.imageURL)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
    
    
    
}


