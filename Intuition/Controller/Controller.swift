//
//  Controller.swift
//  IntuitionGame
//
//  Created by Александр Корепанов on 17.04.2024.
//

import Foundation
import SwiftUI

class Controller: ObservableObject {
    
    @Published var playersScore: [PlayerScore] = []
    @Published var lives: Int = 3
    @Published var score: Int = 0
    @Published var buttonStatus = [true, false]
    
    init() {
        createChoice()
        loadPlayerScore()
    }
    
    func loadPlayerScore() {
        guard let url = Bundle.main.url(forResource: "players_data", withExtension: "json") else {return}
        
        let playerData = try! Data(contentsOf: url)
        guard playerData.isEmpty == false else {return}
        
        guard let localPlayersScore = try? JSONDecoder().decode([PlayerScore].self, from: playerData) else {
            fatalError("Can't decode players from local resource")
        }
        
        playersScore = localPlayersScore
    }
    func savePlayerScore() {
        guard let url = Bundle.main.url(forResource: "players_data", withExtension: "json") else {return}
        
        do {
            let jsonData = try JSONEncoder().encode(playersScore)
            try jsonData.write(to: url)
        } catch {
            print(error)
        }
        
    }
    
    func createChoice() {
        buttonStatus.shuffle()
    }
    
    func checkLeft() {
        if buttonStatus[0] {
            score += 1
        } else {
            lives -= 1
        }
    }
    
    func checkRight() {
        if buttonStatus[1] {
            score += 1
        } else {
            lives -= 1
        }
    }
}

