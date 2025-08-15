//
//  EndView.swift
//  IntuitionGame
//
//  Created by Александр Корепанов on 07.04.2024.
//

import SwiftUI

struct EndView: View {
    
    @State private var isStartNewGame = false
    @State private var isEndGame = false
    
    var body: some View {
        VStack {
            Image(.endgame)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        }
        .fullScreenCover(isPresented: $isStartNewGame, onDismiss: didDismiss, content: {
            ChooseView()
        })
        .fullScreenCover(isPresented: $isEndGame, onDismiss: didDismiss, content: {
            ContentView()
        })
        
        .overlay {
            VStack {
                Spacer()
                Text("Game Over")
                    .foregroundStyle(.green)
                    .font(.custom("matrix", size: 50))
                Text("Try again ?")
                    .foregroundStyle(.green)
                    .font(.custom("matrix", size: 30))
                Spacer()
                HStack(spacing: 100) {
                    Button(action: {
                        isStartNewGame = true
                    }, label: {
                        Text("Yes")
                            .frame(width: 90, height: 20)
                            .font(.custom("matrix", size: 30))
                            .padding()
                            .tint(.white)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    })
                    Button(action: {
                        isEndGame = true
                    }, label: {
                        Text("No")
                            .frame(width: 90, height: 20)
                            .font(.custom("matrix", size: 30))
                            .padding()
                            .tint(.white)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    })
                }
                Spacer()
            }
        }
    }
}

#Preview {
    EndView()
}

private extension EndView {
    func didDismiss() {
        print("Dismissed view")
    }
}
