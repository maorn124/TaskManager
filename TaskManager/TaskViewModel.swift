//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Maor Niv on 7/6/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskViewModel: ObservableObject {
    @Published private(set) var tasks = [TaskModel]()
    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("Tasks").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.tasks = documents.compactMap { queryDocumentSnapshot in
                do {
                    return try queryDocumentSnapshot.data(as: TaskModel.self)
                } catch {
                    print("Error decoding task: \(error)")
                    return nil
                }
            }
        }
    }

    func addTask(title: String, tasksData: String, category: String) {
        let newTask = TaskModel(title: title, tasksData: tasksData, category: category, isComplete: false)
        do {
            let _ = try db.collection("Tasks").addDocument(from: newTask)
        } catch {
            print("Error adding task: \(error)")
        }
    }

    func deleteTask(task: TaskModel) {
        if let taskID = task.id {
            db.collection("Tasks").document(taskID).delete { error in
                if let error = error {
                    print("Error deleting task: \(error)")
                }
            }
        }
    }

    func toggleTaskCompletion(task: TaskModel) {
        var updatedTask = task
        updatedTask.isComplete.toggle()
        do {
            try db.collection("Tasks").document(updatedTask.id!).setData(from: updatedTask)
        } catch {
            print("Error updating task: \(error)")
        }
    }
}
