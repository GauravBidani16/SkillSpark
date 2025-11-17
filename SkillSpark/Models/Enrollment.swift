//
//  Enrollment.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation

struct Enrollment {
    var id: String
    var userId: String
    var courseId: String
    var progress: Double
    var enrolledDate: Date
    var completedLessonIds: [String]
    
    init(id: String, userId: String, courseId: String, progress: Double = 0.0, enrolledDate: Date = Date(), completedLessonIds: [String] = []) {
        self.id = id
        self.userId = userId
        self.courseId = courseId
        self.progress = progress
        self.enrolledDate = enrolledDate
        self.completedLessonIds = completedLessonIds
    }
}
