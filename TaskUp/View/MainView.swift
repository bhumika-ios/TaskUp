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
    
//    MARK: Fetching Task
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
//    MARK: Environment values
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
                //.padding(.vertical)
                
                
                CustomSegmentedBar()
            }
            .padding()
           // .padding(.top,5)
ScrollView(.vertical, showsIndicators: false){
        //MARK: Task View
            TaskView()
        .padding()
        //Later will come
        
    }
.padding(.vertical,-10)

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
            //.padding(.vertical, 12)
            .padding(6)
            .background{
                RoundedRectangle(cornerRadius: 5)
                    .fill(.black)
            }
            
        }
        //MARK:Linear GradientBG
        .padding(.top, 10)
        .frame(maxWidth: .infinity)
        .background{
            LinearGradient(colors: [
                .white.opacity(0.05),
                .white.opacity(0.4),
                .white.opacity(0.7),
                .white
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        }
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
            //            Text(task.type ?? "")
            //                .font(.callout)
            //                .padding(6)
            //                //.padding(.horizontal)
            //
            //                .background{
            //                    if task.type == "Basic"{
            //                    RoundedRectangle(cornerRadius: 5)
            //                        .stroke(Color("Green"))
            //                    RoundedRectangle(cornerRadius: 5)
            //                        .fill(Color("Green").opacity(0.3))
            //                    }else if task.type == "Important"{
            //                        RoundedRectangle(cornerRadius: 5)
            //                            .stroke(Color("Yellow"))
            //                        RoundedRectangle(cornerRadius: 5)
            //                            .fill(Color("Yellow").opacity(0.3))
            //                    }else{
            //                        RoundedRectangle(cornerRadius: 5)
            //                            .stroke(Color("Red"))
            //                        RoundedRectangle(cornerRadius: 5)
            //                            .fill(Color("Red").opacity(0.3))
            //                    }
            //            }
            
            
            //                MARK:  Edit button only for noncomleted task
            //&& taskModel.currentTab != "Failed Task"
            
            
            //        }
            
            VStack(alignment: .leading){
                Text(task.title ?? "")
                    .font(.title3.bold())
                    .foregroundColor(.black)
                    .padding(.vertical,1)
                
             //   Spacer()
                
                //            if !task.isCompleted {
                //                Button{
                //                    taskModel.editTask = task
                //                    taskModel.openEditTask = true
                //                    taskModel.setupTask()
                //                }label: {
                //                    Image(systemName: "square.and.pencil")
                //                        .foregroundColor(.black)
                //                }
                //            }
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
            //.padding()
             .padding(.vertical,1)
           // HStack(alignment: .bottom, spacing: 0){
             //   VStack(alignment: .leading, spacing: 10){
                   
            //    }
                .frame(maxWidth: .infinity, alignment: .leading)
                //  .padding(.vertical,-10)
                //&& taskModel.currentTab != "Failed Task"
                // if !task.isCompleted {
               
                //            if task.isCompleted {
                //                Button{
                ////                        MARK: updating Coredata
                //                    task.isCompleted = false
                //
                //                    try? env.managedObjectContext.save()
                //                } label: {
                //                    Circle()
                //                        .strokeBorder(.black,lineWidth: 1.5)
                //                        .frame(width: 20, height: 20)
                //                       // .contentShape(Circle())
                //                }
                //
                //
                //
                //            }
                
           // }
            .padding(.vertical,-10)
            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    
                    task.isCompleted.toggle()
                    
                    //   }
                    //                Button{
                    ////                        MARK: updating Coredata
                    //                    task.isCompleted = true
                    //
                    //                    try? env.managedObjectContext.save()
                    //                } label: {
                    //                    Circle()
                    //                        .strokeBorder(.black,lineWidth: 1.5)
                    //                        .frame(width: 20, height: 20)
                    //                      //  .contentShape(Circle())
                    //                }
                }
        }
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background{
//        RoundedRectangle(cornerRadius: 5)
//            .fill(.gray).opacity(0.1)
        if task.type == "Basic"{
//        RoundedRectangle(cornerRadius: 5)
//            .stroke(Color("Green"))
        RoundedRectangle(cornerRadius: 5)
            .fill(Color("Green").opacity(0.2))
        }else if task.type == "Important"{
//            RoundedRectangle(cornerRadius: 5)
//                .stroke(Color("Yellow"))
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("Yellow").opacity(0.2))
        }else{
//            RoundedRectangle(cornerRadius: 5)
//                .stroke(Color("Green"))
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
                // .padding(.horizontal,1)
                    .padding(6)
                    
                    .background{
                        if taskModel.currentTab == tab{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.black)
                            
                                .matchedGeometryEffect(id: "TAB", in: animation)
                            
                            //.frame(width: 90, height: 25)
                            // .padding()
                        }
                    }
                    .contentShape(Capsule())
                
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
