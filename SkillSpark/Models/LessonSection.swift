//
//  LessonSection.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/10/25.
//

import Foundation

struct LessonSection: Codable {
    var id: String = ""
    var heading: String
    var order: Int
    var paragraphs: [String]
    
    enum CodingKeys: String, CodingKey {
        case heading, order, paragraphs
    }
}
