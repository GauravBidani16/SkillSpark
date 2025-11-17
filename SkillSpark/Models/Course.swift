//
//  Course.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation
import UIKit

struct Course {
    var id: String
    var title: String
    var description: String
    var instructor: String
    var isFree: Bool
    var price: Double?
    var rating: Double
    var studentCount: Int
    var duration: String
    var image: UIImage?
    var hasForum: Bool
    var lessons: [Lesson]
    
    init(id: String, title: String, description: String, instructor: String, isFree: Bool, price: Double? = nil, rating: Double, studentCount: Int, duration: String, image: UIImage? = nil, hasForum: Bool = false, lessons: [Lesson] = []) {
        self.id = id
        self.title = title
        self.description = description
        self.instructor = instructor
        self.isFree = isFree
        self.price = price
        self.rating = rating
        self.studentCount = studentCount
        self.duration = duration
        self.image = image
        self.hasForum = hasForum
        self.lessons = lessons
    }
}

struct Lesson {
    var id: String
    var title: String
    var duration: String
    var isCompleted: Bool
    
    init(id: String, title: String, duration: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.duration = duration
        self.isCompleted = isCompleted
    }
}
