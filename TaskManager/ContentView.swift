//
//  ContentView.swift
//  TaskManager
//
//  Created by Maor Niv on 7/6/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var taskViewModel = TaskViewModel()
    @EnvironmentObject var authManager: FirebaseAuthManager
    @State private var showingAddTaskView = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskViewModel.tasks) { task in
                        NavigationLink(destination: TaskDetailView(taskViewModel: taskViewModel, task: task)) {
                            HStack {
                                Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                                    .onTapGesture {
                                        taskViewModel.toggleTaskCompletion(task: task)
                                    }

                                VStack(alignment: .leading) {
                                    Text(task.title)
                                        .strikethrough(task.isComplete, color: .black)
                                    Text(task.tasksData)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text(task.category) // Display the category
                                        .font(.footnote)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                taskViewModel.toggleTaskCompletion(task: task)
                            } label: {
                                Label("Complete", systemImage: "checkmark.circle")
                            }
                            .tint(.green)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }

                Button(action: {
                    authManager.signOut()
                }) {
                    Text("Sign Out")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            .navigationBarTitle("Tasks")
            .navigationBarItems(trailing: Button(action: {
                showingAddTaskView = true
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                taskViewModel.fetchData()
            }
        }
        .sheet(isPresented: $showingAddTaskView) {
            AddTaskView(taskViewModel: taskViewModel)
        }
    }

    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = taskViewModel.tasks[index]
            taskViewModel.deleteTask(task: task)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FirebaseAuthManager())
    }
}
