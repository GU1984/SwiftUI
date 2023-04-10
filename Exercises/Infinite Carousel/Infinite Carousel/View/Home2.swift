//
//  Home.swift
//  Infinite Carousel
//
//  Created by Георгий Усынин on 10.04.2023.
//

import SwiftUI

struct Home2: View {
    
    
    @State private var imageArray = [
        "Delta_II0",
        "Delta_II1",
        "Delta_II12",
        "Delta_II13",
        "Delta_II6",
        "Delta_II7",
        "Delta_II8",
        "Delta_II9"]
    
    @State private var currentPage: String = ""
    @State private var listOfPages: [Page2] = []
    
    @State private var fakedPages: [Page2] = []
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            TabView(selection: $currentPage) {
                ForEach(fakedPages) { page in
                    Image(page.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                        .tag(page.id.uuidString)
                        .offsetX(currentPage == page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(page)))
                            
                            let pageProgress = pageOffset / size.width
                            
                            if -pageProgress < 1.0 {
                                if fakedPages.indices.contains(fakedPages.count - 1) {
                                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                                }
                            }
                            if -pageProgress > CGFloat(fakedPages.count - 1) {
                                if fakedPages.indices.contains(1) {
                                    currentPage = fakedPages[1].id.uuidString
                                }
                            }
                            
                            
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(totalPages: listOfPages.count, currentPAge: originalIndex(currentPage))
                    .offset(y: -35)
            }
          
        }
        .frame(height: 600)
        .onAppear{
            guard fakedPages.isEmpty else {return}
            for image in imageArray {
                listOfPages.append(.init(imageName: image))
            }
            
            fakedPages.append(contentsOf: listOfPages)
            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                currentPage = firstPage.id.uuidString
                
                firstPage.id = .init()
                lastPage.id = .init()
                
                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
            
        }
    }
    
    func fakeIndex(_ of: Page2) -> Int {
        return fakedPages.firstIndex(of: of) ?? 0
    }
    
    func originalIndex(_ id: String) -> Int {
        return listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
}

struct Home2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

