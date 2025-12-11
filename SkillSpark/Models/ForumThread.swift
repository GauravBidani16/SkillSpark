//
//  ForumThread.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation
import FirebaseFirestore

struct ForumThread: Codable {
    var id: String = ""
    var courseId: String
    var userId: String
    var userName: String
    var title: String
    var content: String
    var timestamp: Timestamp
    var replyCount: Int
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case courseId, userId, userName, title, content
        case timestamp, replyCount, imageURL
    }
}
