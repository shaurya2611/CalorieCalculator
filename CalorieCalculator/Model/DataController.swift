//
//  DataController.swift
//  CalorieCalculator
//
//  Created by Shaurya Singh on 19/10/23.
//

import Foundation
import CoreData

class  DataController: ObservableObject{
    
//    NSPersistentContainer used to set up all the model, context, and store coordinator at once.
    let container = NSPersistentContainer(name: "FoodModel")
    
    init(){
    // loadPersistentStores : to instruct the container to load the persistent stores and complete the creation of the Core Data stack
        container.loadPersistentStores{desc , error in
            if error != nil {
                print("unable to load database")
            }
    
        }
    }

    func save(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Data saved in DB")
        }catch{
            print("Failed to save data in DB!!")
        }
    }
    
    func addFood(name: String, calorie: Double, context: NSManagedObjectContext){
        let food = Food(context: context)
        food.id = UUID()
        food.name = name
        food.calories = calorie
        food.date = Date()
        
        save(context: context)
    }
    
    func updateFood(food: Food, name: String, calorie: Double, context: NSManagedObjectContext){
        food.name = name
        food.calories = calorie
        food.date = Date()
        
        save(context: context)
    }
}
