//
//  TaskViewModel.swift
//  TaskUp
//
//  Created by Bhumika Patel on 15/03/23.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var currentTab: String = "Today"
    //MARK: New Task Property
    @Published var iscomp: Bool = false
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadLine: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker: Bool = false
//    MARK: Editing exiting task data
    @Published var editTask: Task?
    
    
    //MARK: Adding Task to core data
    func addTask(context: NSManagedObjectContext)->Bool{
        var task: Task!
        if let editTask = editTask {
            
            task = editTask
      
        }else{
            task = Task(context: context)
        }
       
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadLine
        task.type = taskType
        task.isCompleted = false
        
        if let _ = try? context.save(){
            return true
        }
        return false
    }
    //MARK: Resetting Data
    func resetTaskData(){
        taskType = "Basic"
        taskColor = "Yellow"
        taskTitle = ""
        taskDeadLine = Date()
    }
//    MARK: existing setup data
    func setupTask(){
        if let editTask = editTask{
           
            taskType = editTask.type ?? "Basic"
            taskColor = editTask.color ?? "Yellow"
            taskTitle = editTask.title ?? ""
            taskDeadLine = editTask.deadline ?? Date()
        }
    }
}
