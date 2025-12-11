//
//  User.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation

struct User: Codable {
    var id: String = ""
    var name: String
    var email: String
    var profileImageURL: String?
    var enrolledCourseIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, email, profileImageURL, enrolledCourseIds
    }
}
