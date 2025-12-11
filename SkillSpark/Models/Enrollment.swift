//
//  Enrollment.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation
import FirebaseFirestore

struct Enrollment: Codable {
    var id: String = ""
    var userId: String
    var courseId: String
    var progress: Double
    var enrolledDate: Timestamp
    var completedLessonIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case userId, courseId, progress, enrolledDate, completedLessonIds
    }
}
