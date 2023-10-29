//
//  CalorieCalculatorApp.swift
//  CalorieCalculator
//
//  Created by Shaurya Singh on 19/10/23.
//

import SwiftUI

@main
struct CalorieCalculatorApp: App {
    // Using dataController class refrence (as DataController class is marked @observableObject)
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            // enjecting container from datacontroller class as Envoronment varibale to be available through out the app
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
