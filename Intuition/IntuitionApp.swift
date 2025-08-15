//
//  IntuitionApp.swift
//  Intuition
//
//  Created by Александр Корепанов on 23.04.2024.
//

import SwiftUI

@main
struct IntuitionApp: App {
    
    @StateObject private var controller = Controller()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(controller)
        }
    }
}
