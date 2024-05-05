//
//  Controller.swift
//  IntuitionGame
//
//  Created by Александр Корепанов on 17.04.2024.
//

import Foundation
import SwiftUI

class Controller: ObservableObject {
    
    
    
    @Published var lives: Int = 3
    @Published var score: Int = 0
    
    @Published var buttonStatus = [true, false]
    @Published var buttonOneColour = "white"
    @Published var buttonTwoColur = "white"
    
    init() {
        createChoice()
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

