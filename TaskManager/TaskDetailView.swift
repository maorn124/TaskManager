//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by Maor Niv on 7/6/24.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskViewModel: TaskViewModel
    var task: TaskModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text(task.tasksData)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            taskViewModel.deleteTask(task: task)
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "trash")
                .foregroundColor(.red)
        })
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(taskViewModel: TaskViewModel(), task: TaskModel(id: "1", title: "Sample Task", tasksData: "Sample Data", category: "Work", isComplete: false))
    }
}
