//
//  ForumThread.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import Foundation
import UIKit

struct ForumThread {
    var id: String
    var courseId: String
    var userId: String
    var userName: String
    var userImage: UIImage?
    var title: String
    var content: String
    var timestamp: Date
    var replyCount: Int
    var image: UIImage?
    
    init(id: String, courseId: String, userId: String, userName: String, userImage: UIImage? = nil, title: String, content: String, timestamp: Date = Date(), replyCount: Int = 0, image: UIImage? = nil) {
        self.id = id
        self.courseId = courseId
        self.userId = userId
        self.userName = userName
        self.userImage = userImage
        self.title = title
        self.content = content
        self.timestamp = timestamp
        self.replyCount = replyCount
        self.image = image
    }
}
