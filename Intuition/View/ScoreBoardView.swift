//
//  ScoreBoardView.swift
//  Intuition
//
//  Created by Александр Корепанов on 16.05.2024.
//

import SwiftUI

struct ScoreBoardView: View {
    
    @EnvironmentObject private var controller: Controller
    
    @State private var isShowingEndView: Bool = false
    @State private var showingAlert = false
    @State private var username = ""
    private let characterLimit = 10
    
    
    var body: some View {
        
        Image(.scoreboard)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
        
            .fullScreenCover(isPresented: $isShowingEndView, onDismiss: didDismiss, content: {
                EndView()
            })
        
            .overlay {
                List {
                    HStack(spacing: 260) {
                        Text("№")
                        Text("Name")
                        Text("Score")
                    }
                    .listRowBackground(Color.clear)
                    ForEach(controller.playersScore) { scoreRecord in
                        HStack(spacing: 224) {
                            Text("\(scoreRecord.number)")
                            Text(scoreRecord.name)
                                .frame(maxWidth: 150, alignment: .center)
                            Text("\(scoreRecord.score)")
                                .frame(maxWidth: 10, alignment: .center)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                
                Button {
                    isShowingEndView.toggle()
                } label: {
                    Text("Continue")
                        .padding()
                        .font(.custom("matrix", size: 20))
                        .foregroundStyle(.white)
                }
                
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .tint(.black.opacity(0.3))
                .controlSize(.mini)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
            }
            .task {
                
                if controller.playersScore.count < 10 {
                    showingAlert = true
                } else {
                    showingAlert = false
                }
            }
            .scrollContentBackground(.hidden)
            .alert("hello chosen one", isPresented: $showingAlert) {
                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .onChange(of: username) { oldValue, newValue in
                                        if newValue.count > characterLimit {
                                            username = String(newValue.prefix(characterLimit))
                                        }
                                    }
                Button("OK", action: checkAndSave)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please enter your username.")
            }
        
    }
    
    func checkAndSave() {
        
        print(controller.score)
        
        controller.playersScore.append(
            PlayerScore(
                id: UUID(),
                name: username,
                score: controller.score,
                date: .now,
                number: 0
            )
        )
        
        controller.playersScore.sort { $0.score > $1.score }
        
        for i in 0..<controller.playersScore.count {
            controller.playersScore[i].number = 0
        }
        
        for i in 0..<controller.playersScore.count {
            controller.playersScore[i].number = i + 1
        }
        if controller.playersScore.count > 7 {
            controller.playersScore.removeLast()
        }
        
        controller.savePlayerScore()
        controller.lives = 3
        controller.score = 0
    }
    
}

#Preview {
    ScoreBoardView()
}

private extension ScoreBoardView {
    func didDismiss() {
        print("Dismissed view")
    }
}
