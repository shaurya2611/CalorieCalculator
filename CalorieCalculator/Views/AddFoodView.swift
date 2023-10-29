//
//  AddFoodView.swift
//  CalorieCalculator
//
//  Created by Shaurya Singh on 19/10/23.
//

import SwiftUI
import CoreData

struct AddFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = AddFoodViewViewModel()
    
    // this request happens, veery time app view is loaded , retreving data from database
    @FetchRequest(entity: Food.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    
    var foods: FetchedResults<Food>
    
    var body: some View {
        Form{
            Section{
                
                if !viewModel.errorMessage.isEmpty{
                    TextField(viewModel.errorMessage,
                              text: $viewModel.name).padding(10).foregroundColor(Color.red)
                }else{
                    TextField("Enter Food",
                              text: $viewModel.name).padding(10)
                }
                
                VStack{
                    Text("Calorie : \(Int(viewModel.calorie)) ").bold() + Text("kcal").foregroundColor(.red)
                    Slider(value: $viewModel.calorie,
                           in: 0...1000,
                           step: 10)
                }
                
                HStack{
                    Spacer()
                    Button{
                        viewModel.addFood(name: viewModel.name, 
                                          calorie: viewModel.calorie,
                                          context: managedObjectContext)
                        dismiss()
                        
                    }label: {
                        Text("Submit")
                            .font(.system(.title3))
                            .frame(width: 100, height: 30)
                            .background(Color.red)
                            .foregroundColor(Color.white).bold()
                            .cornerRadius(20)
                    }
                    Spacer()
                }.padding()
                
               
            }
                
        }
    }
}

#Preview {
    AddFoodView()
}
