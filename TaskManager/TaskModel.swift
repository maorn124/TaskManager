//
//  TaskModel.swift
//  TaskManager
//
//  Created by Maor Niv on 7/6/24.
//

// TaskModel.swift
import Foundation
import FirebaseFirestoreSwift

struct TaskModel: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var tasksData: String
    var category: String
    var isComplete: Bool
}
