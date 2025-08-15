
//
//  ChooseView.swift
//  IntuitionGame
//
//  Created by Александр Корепанов on 07.04.2024.
//

import SwiftUI

struct ChooseView: View {
    
    @EnvironmentObject private var controller: Controller
    
//    @State private var isShowingEndView: Bool = false
    @State private var isShowingScoreBoardView: Bool = false
    @State private var isButtonsHidden:Bool = true
    
    private var leftButtonColour: Color {
        isButtonsHidden ? Color.white : colorForState(state: controller.buttonStatus[0])
    }
    private var rightButtonColour: Color {
        isButtonsHidden ? Color.white : colorForState(state: controller.buttonStatus[1])
    }
    
    private func colorForState(state: Bool) -> Color {
        state ? Color.red : Color.blue
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Lives x \(controller.lives)")
                    .frame(width: 100, height: 50)
                //                    .font(.custom("matrix", size: 20))
                    .foregroundStyle(.green)
                    .padding()
                Spacer()
                Text("Score x \(controller.score)")
                    .frame(width: 100, height: 50)
                //                    .font(.custom("matrix", size: 20))
                    .foregroundColor(.green)
                    .padding()
            }
            Spacer()
            HStack(spacing: 500) {
                Button(action: {
                    isButtonsHidden = false
                    controller.checkLeft()
                    nextGame()
                }, label: {
                    Text("")
                        .frame(width: 90, height: 20)
                        .padding()
                        .tint(.white)
                        .background(leftButtonColour)
                        .clipShape(Capsule())
                })
                .allowsHitTesting(isButtonsHidden)
                
                Button(action: {
                    isButtonsHidden = false
                    controller.checkRight()
                    nextGame()
                    
                }, label: {
                    Text("")
                        .frame(width: 90, height: 20)
                        .padding()
                        .tint(.white)
                        .background(rightButtonColour)
                        .clipShape(Capsule())
                })
                .allowsHitTesting(isButtonsHidden)
            }
            .padding(.bottom, 40)
        }
//        .fullScreenCover(isPresented: $isShowingEndView, onDismiss: didDismiss, content: {
//            EndView()
//        })
        .fullScreenCover(isPresented: $isShowingScoreBoardView, onDismiss: didDismiss, content: {
            ScoreBoardView()
        })

        .background {
            Image(.choose)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func nextGame() {
        if controller.lives == 0 {
//            isShowingEndView = true
            isShowingScoreBoardView = true
        }
        Task {
            do {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                controller.createChoice()
                isButtonsHidden = true
            } catch {
                //canceled
            }
        }
    }
}

#Preview {
    ChooseView()
}

private extension ChooseView {
    func didDismiss() {
        print("Dismissed view")
    }
}
