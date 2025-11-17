//
//  User.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation

import UIKit

struct User {
    var id: String
    var name: String
    var email: String
    var profileImage: UIImage?
    var enrolledCourseIds: [String]
    
    init(id: String, name: String, email: String, profileImage: UIImage? = nil, enrolledCourseIds: [String] = []) {
        self.id = id
        self.name = name
        self.email = email
        self.profileImage = profileImage
        self.enrolledCourseIds = enrolledCourseIds
    }
}
