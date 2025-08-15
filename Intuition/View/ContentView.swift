//
//  ContentView.swift
//  IntuitionGame
//
//  Created by Александр Корепанов on 07.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingChooseView: Bool = false
    
    var body: some View {
        ZStack {
            Image(.matrix)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            Button {
                isShowingChooseView.toggle()
            } label: {
                Text("Make your choice")
                    .padding()
                    .font(.custom("matrix", size: 50))
                    .foregroundStyle(.green)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .tint(.black.opacity(0.7))
            .controlSize(.extraLarge)
        }
        .fullScreenCover(isPresented: $isShowingChooseView, onDismiss: didDismiss, content: {
            ChooseView()
        })
    }
}

#Preview {
    ContentView()
}

private extension ContentView {
    func didDismiss() {
        print("Dismissed view")
    }
}

