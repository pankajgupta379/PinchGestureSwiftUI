//
//  ContentView.swift
//  PinchGestureDemo
//
//  Created by Pankaj Gupta on 10/06/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Properties
    
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1.0
    @State private var imagePosition: CGSize = .zero
    @State private var drawerWidth: CGFloat = 100
    @State private var isDrawerOpen: Bool = true
    
    let viewData: [Page] = pageData
    @State private var pageIndex: Int = 0
        
    // MARK: Private Functions
    
    private func resetImage() {
        return withAnimation(.spring()) {
            imageScale = 1
            imagePosition = .zero
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                
                Image(viewData[pageIndex].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                    .padding()
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imagePosition.width, y: imagePosition.height)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        }
                        else {
                            resetImage()
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                withAnimation(.linear(duration: 0.5)) {
                                    imagePosition = gesture.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetImage()
                                }
                            })
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                if value >= 1 && value <= 5 {
                                    withAnimation(.spring()) {
                                        imageScale = value
                                    }
                                } else if value > 5 {
                                    withAnimation(.spring()) {
                                        imageScale = 5
                                    }
                                }
                            })
                            .onEnded({ value in
                                if value < 1 {
                                    resetImage()
                                } else if value > 5 {
                                    withAnimation(.spring()) {
                                        imageScale = 5
                                    }
                                }
                            })
                    )
                
            }
            .navigationTitle("Pinch and zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            }
            .overlay(alignment: .top, content: {
                InfoPannelView(scale: imageScale, offSet: imagePosition)
                    .padding(.horizontal)
                    .padding(.top, 30)
            })
            
            // MARK: - Controls
            .overlay(alignment: .bottom) {
                Group {
                    HStack {
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "plus.magnifyingglass")
                                .font(.system(size: 30))
                        }
                        
                        Button {
                            withAnimation(.spring()) {
                                resetImage()
                            }
                        } label: {
                            Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                                .font(.system(size: 30))
                        }
                        
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    if imageScale < 1 {
                                        resetImage()
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "minus.magnifyingglass")
                                .font(.system(size: 30))
                        }
                    }
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                .padding(.bottom, 20)
            }
            
            .overlay(alignment: .topTrailing) {
                HStack(spacing: 12) {
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isDrawerOpen.toggle()
                            }
                        }
                                        
                    ForEach(viewData) { item in
                        Image(item.thumbNailImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(5)
                            .shadow(radius: 8)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    isAnimating = true
                                    pageIndex = item.id - 1
                                }
                            }
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .opacity(isAnimating ? 1 : 0)
                .frame(width: 260)
                .padding(.top, UIScreen.main.bounds.height / 12)
                .offset(x: isDrawerOpen ? 20 : 215)
            }
        }
        .navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
