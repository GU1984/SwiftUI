//
//  Home4.swift
//  MatchGeometryEffect
//
//  Created by 1 on 14.09.2022.
//

import SwiftUI

struct Home4: View {
                    
    @Namespace var namespace
    @State var isExpanded: Bool = false
    @State var expandedProfile: Profile?
    
    @State var loadExpandContent: Bool = false
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    ForEach(profiles) { profile in
                        RowView(profile: profile)
                    }
                }
                .padding()
            }
            .navigationTitle("Vehicle List")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .overlay(content: {
            Rectangle()
                .fill(.black)
                .opacity(loadExpandContent ? 1 : 0)
                .opacity(offsetProgress())
                .ignoresSafeArea(.all)
        })
        .overlay {
            if let expandedProfile = expandedProfile,isExpanded {
                ExpandedView(profile: expandedProfile)
            }
        }
    }
    
    func offsetProgress() -> CGFloat{
        let progress = offset.height / 100
        if offset.height < 0 {
            return 1
        } else {
            return 1 - (progress < 1 ? progress : 1)
        }
    }
    
    @ViewBuilder
    func ExpandedView(profile: Profile) -> some View {
        VStack{
            GeometryReader{ proxy in
               let size = proxy.size
                Image(profile.profilePicture)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped() //
//                    .cornerRadius(loadExpandContent ? 0 : size.height)
                    
                    .offset(y: loadExpandContent ? offset.height : .zero)
                    .gesture(
                    DragGesture()
                        .onChanged({ value in
                            offset = value.translation
                        })
                        .onEnded({ value in
                            let height = value.translation.height
                            if height > 0 && height > 100 {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    loadExpandContent = false
                                }
                                withAnimation(.easeInOut(duration: 0.4).delay(0.05)) {
                                    isExpanded = false
                                }
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    offset = .zero
                                }
                            } else {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    offset = .zero
                                }
                            }
                        })
                    )
            }
            .matchedGeometryEffect(id: profile.id, in: namespace)
            .frame(height: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment:.top, content: {
            HStack{
                Button {
                    withAnimation(.easeInOut(duration: 4)) {
                        loadExpandContent = false
                    }
                    withAnimation(.easeInOut(duration: 4).delay(0.05)) {
                        isExpanded = false
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Text(profile.name)
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Spacer()

            }
            .padding()
            .opacity(loadExpandContent ? 1 : 0)
            .opacity(offsetProgress())
        })
    
        .transition(.offset(x: 0, y: 1))
        .onAppear{
            withAnimation(.easeInOut(duration: 0.4)) {
                loadExpandContent = true
            }
        }
    }
    
    @ViewBuilder
    func RowView(profile: Profile) -> some View {
        HStack(spacing: 12) {
            VStack {
                if expandedProfile?.id == profile.id && isExpanded {
                    Image(profile.profilePicture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 150)
                        .clipped()
                        .opacity(0)
                } else {
                 
                    Image(profile.profilePicture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                       
                       
                        .frame(width: 250, height: 150)
                        
                        .clipped()
                        .matchedGeometryEffect(id: profile.id, in: namespace)
                    
                }
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isExpanded = true
                    expandedProfile = profile
                }
            }
//            VStack(alignment: .leading, spacing: 6){
//                Text(profile.name)
//                    .font(.title)
//                    .bold()
//                Text(profile.name)
//                    .font(.caption)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}



struct Home4_Previews: PreviewProvider {
    static var previews: some View {
        Home4()
    }
}
