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
    @State private var imageOffset: CGSize = .zero
    
    //MARK: - FUNCTION
    func resetImageState(){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.clear
                //MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 12,x: 2,y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x:imageOffset.width,y: imageOffset.height)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(imageScale)
                //MARK: - TAP GESTURE
                    .onTapGesture(count:2,perform: {
                        if imageScale == 1{
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }else{
                           resetImageState()
                        }
                    })
                //MARK: - DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged{value in
                                withAnimation(.linear(duration: 1)){
                                    imageOffset = value.translation
                                }
                            }
                            .onEnded{_ in
                                
                                if imageScale <= 1{
                                    resetImageState()
                                }
                            }
                    )
                
            }//: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
                
            })
            //MARK: - INFO PANEL
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
            .padding(.horizontal)
            .padding(.top, 30)
            ,alignment: .top)
            //MARK: - CONTROLS
            .overlay(
                Group{
                    HStack{
                        // SCALE DOWN
                        Button{
                            withAnimation(.spring()){
                                if imageScale > 1{
                                    imageScale -= 1
                                    
                                    if imageScale <= 1{
                                        resetImageState()
                                    }
                                }
                            }
                        }label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // RESET
                        Button{
                            resetImageState()
                        }label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        // SCALE UP
                        Button{
                            withAnimation(.spring()){
                                if imageScale < 5 {
                                    imageScale += 1
                                    
                                    if imageScale > 5{
                                        imageScale = 5
                                    }
                                }
                            }
                        }label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    } //: CONTROLS
                    
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30)
                ,alignment: .bottom
            )
            
        } //: NAVIGATION VIEW
        .navigationViewStyle(.stack)
        
    }
    
}

#Preview {
    ContentView()
}
