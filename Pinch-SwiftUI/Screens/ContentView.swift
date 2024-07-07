//
//  ContentView.swift
//  Pinch-SwiftUI
//
//  Created by Mahan Kheirollahi on 7/7/24.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTY
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    
    var body: some View {
        NavigationView{
            ZStack{
                //MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 12,x: 2,y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(imageScale)
                //MARK: - TAP GESTURE
                    .onTapGesture(count:2,perform: {
                    if imageScale == 1{
                        withAnimation(.spring()){
                            imageScale = 5
                        }
                    }else{
                        withAnimation(.spring()){
                            imageScale = 1
                        }
                    }
                })
            }//: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
               
            })
        } //: NAVIGATION VIEW
        .navigationViewStyle(.stack)
        
    }
      
}

#Preview {
    ContentView()
}
