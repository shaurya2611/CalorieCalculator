//
//  ContentView.swift
//  CalorieCalculator
//
//  Created by Shaurya Singh on 19/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // this request happens, every time app view is loaded , data will be fetched from database
    @FetchRequest(entity: Food.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    
    var body: some View {
        // NavigationView : is like an container containing all the view
        // NavigationLink : contains link to represnt a particular view
        NavigationView{
            VStack(alignment: .leading){ //alignment
                
                Text("\(Int(totalCaloriesToday())) KCal (Today)")
                    .foregroundColor(.gray)
                    .padding([.horizontal])
                
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    
                                    Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.red)
                                }
                                
                                Spacer()
                                
                                Text(calcTimeSince(date: food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                    // onDelete() can only be used with List along with ForEach loop to perform delete operation
                }
                .listStyle(.plain)
            }
            // giving title to that particuar view
            .navigationTitle("Calories++")
            // placed at the top of the screen above navigation title
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add food", systemImage: "plus.circle")
                    }
                }
                
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
                
            }
            
        }
        .navigationViewStyle(.stack) // Removes sidebar on iPad
    }
    
    // Deletes food at the current offset
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }
                .forEach(managedObjectContext.delete)
            
            // Saves to our database
            DataController().save(context: managedObjectContext)
        }
    }
    
    
    private func totalCaloriesToday() -> Double {
        var caloriesToday : Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        print("Calories today: \(caloriesToday)")
        return caloriesToday
    }
}


#Preview {
    ContentView()
}
