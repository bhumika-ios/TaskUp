//
//  DynamicFilterView.swift
//  TaskUp
//
//  Created by Bhumika Patel on 15/03/23.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View,T>:View where T: NSManagedObject {
    // MARK: Core data request
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    
    //MARK:
    init(currentTab: String, @ViewBuilder content: @escaping (T)->Content){
        let calendar = Calendar.current
        var predicate: NSPredicate!
        
        if currentTab == "Today"{
            let today = calendar.startOfDay(for: Date())
            let tommorow = calendar.date(byAdding: .day, value: 1, to: today)!
            
            // Filter key
            
            let filterKey = "deadline"
            
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today,tommorow,0])
        }else if currentTab == "Upcoming"{
            let today = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!)
            let tommorow = Date.distantFuture
            
            let filterKey = "deadline"
            
            
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today,tommorow,0])
        }else if currentTab == "Failed Task"{
            let today = calendar.startOfDay(for: Date())
            let past = Date.distantPast
            
            let filterKey = "deadline"
            
            
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [past,today,0])
            
        }else {
            // 0-false, 1-true
            predicate = NSPredicate(format: " isCompleted == %i", argumentArray: [1])
        }
        
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.deadline, ascending: false)], predicate: predicate)
        self.content = content
        
        
    }
    var body: some View{
        Group{
            if request.isEmpty{
                Text("No tasks found!!!")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y: 220)
            }else{
                ForEach(request,id: \.objectID){Object in
                    self.content(Object)
                }
            }
        }
    }
}

  
