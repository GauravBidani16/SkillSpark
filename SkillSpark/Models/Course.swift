//
//  Course.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation

struct Course: Codable {
    var id: String = ""
    var title: String
    var description: String
    var instructor: String
    var isFree: Bool
    var price: Double?
    var rating: Double
    var studentCount: Int
    var duration: String
    var imageURL: String?
    var hasForum: Bool
    
    enum CodingKeys: String, CodingKey {
        case title, description, instructor, isFree, price
        case rating, studentCount, duration, imageURL, hasForum
    }
}

struct Lesson: Codable {
    var id: String = ""
    var title: String
    var duration: String
    var order: Int
    
    enum CodingKeys: String, CodingKey {
        case title, duration, order
    }
}
