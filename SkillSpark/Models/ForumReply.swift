//
//  ForumReply.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation

import UIKit

struct ForumReply {
    var id: String
    var threadId: String
    var userId: String
    var userName: String
    var userImage: UIImage?
    var content: String
    var timestamp: Date
    var image: UIImage?
    
    init(id: String, threadId: String, userId: String, userName: String, userImage: UIImage? = nil, content: String, timestamp: Date = Date(), image: UIImage? = nil) {
        self.id = id
        self.threadId = threadId
        self.userId = userId
        self.userName = userName
        self.userImage = userImage
        self.content = content
        self.timestamp = timestamp
        self.image = image
    }
}
