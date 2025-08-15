//
//  LeaderBoard.swift
//  Intuition
//
//  Created by Александр Корепанов on 10.05.2024.
//

import Foundation

struct  PlayerScore: Identifiable, Codable {
    
    let id: UUID
    let name: String
    let score: Int
    let date: Date
    var number: Int
}
