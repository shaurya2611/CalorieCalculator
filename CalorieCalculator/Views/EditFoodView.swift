//
//  EditFoodView.swift
//  CalorieCalculator
//
//  Created by Shaurya Singh on 24/10/23.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section() {
                TextField("\(food.name!)", text: $name)
                    .onAppear {
                        name = food.name!
                        calories = food.calories
                    }
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...2000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().updateFood(food: food, name: name, calorie: calories, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}



