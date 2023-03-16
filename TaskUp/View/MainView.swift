//
//  MainView.swift
//  TaskUp
//
//  Created by Bhumika Patel on 15/03/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var taskModel: TaskViewModel = .init()
    //MARK: Matched Geometry Names
    @Namespace var animation
    
    //MARK: Fetching Task
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
    //MARK: Environment values
    @Environment(\.self) var env
    @State var isOrdinary: Bool = true
    var body: some View {
        VStack {
            VStack{
                VStack(alignment: .leading, spacing: 8){
                    Text("Welcome Back")
                        .font(.callout)
                    Text("Here's Update Today")
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity,  alignment: .leading)
                CustomSegmentedBar()
            }
            .padding()
            ScrollView(.vertical, showsIndicators: false){
                //MARK: Task View
                TaskView()
                    .padding()
                }
            .padding(.vertical,-15)
        }
        .overlay(alignment: .bottom){
            //MARK:Add button
            Button{
                taskModel.openEditTask.toggle()
            }label: {
                Label{
                    Text("Add Task")
                        .font(.callout)
                        .fontWeight(.semibold)
                }icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding(6)
                .background{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.black)
                }
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
        }
        .fullScreenCover(isPresented: $taskModel.openEditTask){
            taskModel.resetTaskData()
        } content: {
            AddNewTask()
                .environmentObject(taskModel)
        }
    }
//    MARK: TaskView
@ViewBuilder
func TaskView()->some View{
    LazyVStack(spacing: 20){
       //MARK:
        DynamicFilteredView(currentTab: taskModel.currentTab){ (task: Task) in
            TaskRowView(task: task)
            }
        }
        .padding(.top,20)
    }
//    MARK: Task RowView
func TaskRowView(task: Task)->some View{
    VStack(alignment: .leading, spacing: 10){
        HStack{
            VStack(alignment: .leading){
                Text(task.title ?? "")
                    .font(.title3.bold())
                    .foregroundColor(.black)
                    .padding(.vertical,1)
                    .onTapGesture {
                        taskModel.editTask = task
                        taskModel.openEditTask = true
                        taskModel.setupTask()
                    }
                HStack{
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.caption)
                }
            }
            .padding(.vertical,1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical,-10)
            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    task.isCompleted.toggle()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background{
            if task.type == "Basic"{
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("Green").opacity(0.2))
            }else if task.type == "Important"{
                RoundedRectangle(cornerRadius: 5)
                .fill(Color("Yellow").opacity(0.2))
            }else{
                RoundedRectangle(cornerRadius: 5)
                .fill(Color("Red").opacity(0.2))
            }
        }
    }
//MARK: Custom Segmented Bar
@ViewBuilder
func CustomSegmentedBar()->some View{
    let tabs = ["Today", "Upcoming", "Task Done", "Failed Task"]// In case missed card
    VStack(alignment: .leading){
        HStack(spacing: 2){
            ForEach(tabs,id: \.self){tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(taskModel.currentTab == tab ? .white: .black)
                    .padding(6)
                    .background{
                        if taskModel.currentTab == tab{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .onTapGesture {
                        withAnimation{taskModel.currentTab = tab}
                    }
                }
            }
        }
    .background(Color("Secondary"))
    .scaledToFit()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
