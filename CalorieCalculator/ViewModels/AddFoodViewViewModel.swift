//
//  AddFoodViewViewModel.swift
//  CalorieCalculator
//
//  Created by Shaurya Singh on 20/10/23.
//

import Foundation
import CoreData

class AddFoodViewViewModel: ObservableObject{
    
    @Published var name: String = ""
    @Published var calorie: Double = 500
    @Published var errorMessage: String = ""
    
    
    func addFood(name: String, calorie: Double, context: NSManagedObjectContext){
        guard validateFoodForm() else{
            return
        }
        DataController().addFood(name: name, calorie: calorie, context: context)
    }
    
    func validateFoodForm() -> Bool{
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter food name!!!"
            return false
        }
        return true
    }
}
