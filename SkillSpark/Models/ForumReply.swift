//
//  ForumReply.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation
import FirebaseFirestore

struct ForumReply: Codable {
    var id: String = ""
    var threadId: String
    var userId: String
    var userName: String
    var content: String
    var timestamp: Timestamp
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case threadId, userId, userName, content, timestamp, imageURL
    }
}
