//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Maor Niv on 7/6/24.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskViewModel: TaskViewModel
    @State private var title = ""
    @State private var tasksData = ""
    @State private var category = ""

    let categories = ["Work", "Personal", "Other"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $title)
                }
                Section(header: Text("Task Data")) {
                    TextField("Task Data", text: $tasksData)
                }
                Section(header: Text("Category")) {
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
            }
            .navigationBarTitle("New Task", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                taskViewModel.addTask(title: title, tasksData: tasksData, category: category)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(taskViewModel: TaskViewModel())
    }
}
