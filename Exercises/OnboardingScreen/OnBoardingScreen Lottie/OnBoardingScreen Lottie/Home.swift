//
//  Home.swift
//  OnBoardingScreen Lottie
//
//  Created by Георгий Усынин on 05.04.2023.
//

import SwiftUI

struct Home: View {
    
    @State var items: [Item] = [
        .init(title: "Request Pickup", subTitle: "Tell us who you're sending it to, what you;re sending and when it's best to pickup the package and we will pick it at the most convinetnt time", lottieView: .init(name: "pickup", bundle: .main)),
        .init(title: "Track Delivery", subTitle: "Tell us who you're sending it to, what you;re sending and when it's best to pickup the package and we will pick it at the most convinetnt time", lottieView: .init(name: "delivery", bundle: .main)),
        .init(title: "Recive Package", subTitle: "Tell us who you're sending it to, what you;re sending and when it's best to pickup the package and we will pick it at the most convinetnt time", lottieView: .init(name: "receive", bundle: .main))
    ]
    
    @State var currentIndex: Int = 0
    
    
    var body: some View {
        
        GeometryReader {
            let size = $0.size
            HStack(spacing: 0) {
                let islastSlide = (currentIndex == items.count - 1)
                ForEach($items) { $item in
                    
                    VStack(spacing: 15) {
                        HStack {
                            Button {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    playAnimation()
                                }

                            } label: {
                                Text("Back")
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            
                            Spacer(minLength: 0)
                            
                            Button {
                                currentIndex = items.count - 1
                                playAnimation()
                            } label: {
                                Text("Skip")
                            }
                            .opacity(islastSlide ? 0 : 1)

                        }
                        .animation(.easeInOut, value: currentIndex)
                        .tint(Color.green)
                        .fontWeight(.bold)
                        
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width
                            
                            ResizableLottieView(item: $item)
                                .frame(height: size.width)
                                .onAppear{
                                    if currentIndex == indexOf(item) {
                                        item.lottieView.play(toProgress: 0.7)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                            
                            Text(item.subTitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                            
                        }
                        
                        Spacer(minLength: 0)
                        
                        VStack(spacing: 15) {
                            Text(islastSlide ? "Login" : "Next")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.vertical, islastSlide ? 13 : 12)
                                .frame(maxWidth: .infinity)
                                .background {
                                    Capsule()
                                        .fill(Color.green)
                                }
                                .padding(.horizontal, islastSlide ? 30 : 100)
                                .onTapGesture {
                                    if currentIndex < items.count - 1 {
                                        
                                        let currentProgress = items[currentIndex].lottieView.currentProgress
                                        
                                        items[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
                                        currentIndex += 1
                                        playAnimation()
                                    }
                                }
                           
                            
                            
                            HStack{
                                Text("Terms of Service")
                                
                                Text("Privacy Policy")
                            }
                            .font(.caption2)
                            .underline(true, color: .primary)
                            .offset(y: 5)
                        }
                        
                    }
                    .animation(.easeInOut, value: islastSlide)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(items.count), alignment: .leading)
        }
    }
    
    func playAnimation(){
        items[currentIndex].lottieView.currentProgress = 0
        items[currentIndex].lottieView.play(toProgress: 0.7)
        
    }
    
    
    func indexOf(_ item: Item)-> Int {
        if let index = items.firstIndex(of: item) {
            return index
        }
        return 0
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct ResizableLottieView: UIViewRepresentable {
    @Binding var item: Item
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func setupLottieView (_ to: UIView) {
        let lottieView = item.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        let constrains = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor),
        ]
        to.addSubview(lottieView)
        to.addConstraints(constrains)
    }
    
}
