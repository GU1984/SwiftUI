//
//  Home.swift
//  StrageredGrid
//
//  Created by 1 on 05.04.2023.
//

import SwiftUI

struct Home: View {
    @State var posts : [Post] = []
    @State var columns: Int = 2
    
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            StaggeredView(columns: columns, list: posts, content: { post in
                PostCardView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
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
            for index in 1...20 {
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

