//
//  AddNewTask.swift
//  TaskUp
//
//  Created by Bhumika Patel on 15/03/23.
//

import SwiftUI

struct AddNewTask: View {
    @EnvironmentObject var taskModel: TaskViewModel
    //MARK:All environment values in one variable
    @Environment(\.self) var env
    @Namespace var animation
    var body: some View {
        VStack(spacing: 12){
            Text("Task")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading){
                    Button{
                        env.dismiss()
                    }label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
                .overlay(alignment: .trailing){
                        Button{
                            if let editTask = taskModel.editTask{
                              env.managedObjectContext.delete(editTask)
                                try? env.managedObjectContext.save()
                                env.dismiss()
                            }
                        }label: {
                            Image(systemName: "trash")
                                .font(.title3)
                                .foregroundColor(.red)
                        }
                        .opacity(taskModel.editTask == nil ? 0 : 1)
                }
                .padding(.vertical,10)
                VStack(alignment: .leading, spacing: 12){
                    Text("Task DeadLine")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(taskModel.taskDeadLine.formatted(date: .abbreviated, time: .omitted) + ", " + taskModel.taskDeadLine.formatted(date: .omitted, time: .shortened))
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.top,8)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .overlay(alignment: .bottomTrailing){
                    Button{
                        taskModel.showDatePicker.toggle()
                    } label: {
                        Image(systemName: "calendar")
                        .foregroundColor(.black)
                    }
                }
                Divider()
                VStack(alignment: .leading, spacing: 12){
                    Text("Task Title")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("", text: $taskModel.taskTitle)
                        .frame(maxWidth: .infinity)
                        .padding(.top,8)
                }
                .padding(.top,10)
                Divider()
                // MARK: sample TaskType
                let taskTypes: [String] = ["Basic", "Important", "Urgent"]
                VStack(alignment: .leading, spacing: 12){
                        Text("TaskType")
                            .font(.caption)
                            .foregroundColor(.gray)
                        HStack(spacing: 12){
                            ForEach(taskTypes,id: \.self){type in
                                Text(type)
                                    .font(.callout)
                                    .padding(.vertical,8)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(taskModel.taskType == type ? .white : .black)
                                    .background{
                                        if taskModel.taskType == type{
                                            RoundedRectangle(cornerRadius: 5)
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "TYPE", in: animation)
                                        }else{
                                            RoundedRectangle(cornerRadius: 5)
                                            .strokeBorder(.black)  
                                        }
                                    }
                                // animation effect
                                .onTapGesture {
                                    withAnimation{taskModel.taskType = type}
                                }
                            }
                        }
                        .padding(.top,8)
                    }
                    .padding(.vertical, 10)
                    Divider()
                    //MARK SaveButton
                    Button{
                        //MARK: If success closing view
                        if taskModel.addTask(context: env.managedObjectContext){
                            env.dismiss()
                        }
                    } label: {
                        Text("SaveTask")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical,12)
                            .foregroundColor(.white)
                        .background{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.black)
                        }
                    }
                    .frame(maxHeight:.infinity, alignment: .bottom)
                    .padding(.bottom,10)
                    // Color lightway
                    .disabled(taskModel.taskTitle == "")
                    .opacity(taskModel.taskTitle == "" ? 0.6 : 1)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .overlay{
                ZStack {
                    if taskModel.showDatePicker{
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                    .onTapGesture {
                        taskModel.showDatePicker = false
                    }
                    //MARK: Disable Past Date
                    DatePicker.init("", selection: $taskModel.taskDeadLine, in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 12, style:.continuous))
                        .padding()
                }
            }
            .animation(.easeInOut, value: taskModel.showDatePicker)
        }
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskViewModel())
    }
}
