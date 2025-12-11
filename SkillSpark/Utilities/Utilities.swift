////
////  Utilities.swift
////  SkillSpark
////
////  Created by Gaurav Bidani on 11/17/25.
////
//
//import Foundation
//import UIKit
//
//class Utilities {
//    
//    // MARK: - Current User (simulating logged in user)
//    static var currentUser = User(
//        id: "user1",
//        name: "John Doe",
//        email: "john.doe@email.com",
//        profileImage: UIImage(systemName: "person.circle.fill"),
//        enrolledCourseIds: ["course1", "course3"]
//    )
//    
//    // MARK: - Sample Courses
//    static var courses: [Course] = [
//        Course(
//            id: "course1",
//            title: "iOS Development Basics",
//            description: "Master the fundamentals of iOS development with Swift and UIKit. Perfect for beginners looking to build their first iOS app.",
//            instructor: "Sarah Johnson",
//            isFree: true,
//            rating: 4.8,
//            studentCount: 2543,
//            duration: "12 hours",
//            image: UIImage(systemName: "swift"),
//            hasForum: true,
//            lessons: [
//                Lesson(id: "lesson1", title: "Introduction to iOS", duration: "5:30", isCompleted: true),
//                Lesson(id: "lesson2", title: "Setting up Xcode", duration: "8:15", isCompleted: true),
//                Lesson(id: "lesson3", title: "Your First App", duration: "12:40", isCompleted: false),
//                Lesson(id: "lesson4", title: "Understanding Views", duration: "10:20", isCompleted: false),
//                Lesson(id: "lesson5", title: "Auto Layout Basics", duration: "15:30", isCompleted: false)
//            ]
//        ),
//        Course(
//            id: "course2",
//            title: "Advanced SwiftUI",
//            description: "Master SwiftUI animations and architecture patterns for building modern iOS apps.",
//            instructor: "Michael Chen",
//            isFree: false,
//            price: 29.99,
//            rating: 4.9,
//            studentCount: 1234,
//            duration: "18 hours",
//            image: UIImage(systemName: "app.badge"),
//            hasForum: false,
//            lessons: [
//                Lesson(id: "lesson6", title: "SwiftUI Fundamentals", duration: "20:00"),
//                Lesson(id: "lesson7", title: "State Management", duration: "25:30"),
//                Lesson(id: "lesson8", title: "Advanced Animations", duration: "30:15")
//            ]
//        ),
//        Course(
//            id: "course3",
//            title: "Data Structures in Swift",
//            description: "Essential algorithms and data structures every iOS developer should know.",
//            instructor: "Emily Rodriguez",
//            isFree: true,
//            rating: 4.7,
//            studentCount: 3120,
//            duration: "10 hours",
//            image: UIImage(systemName: "cpu"),
//            hasForum: true,
//            lessons: [
//                Lesson(id: "lesson9", title: "Arrays and Collections", duration: "12:00", isCompleted: false),
//                Lesson(id: "lesson10", title: "Linked Lists", duration: "15:20", isCompleted: false),
//                Lesson(id: "lesson11", title: "Trees and Graphs", duration: "18:45", isCompleted: false)
//            ]
//        ),
//        Course(
//            id: "course4",
//            title: "Mobile App Design",
//            description: "UI/UX principles for creating beautiful and intuitive mobile applications.",
//            instructor: "David Park",
//            isFree: false,
//            price: 19.99,
//            rating: 4.6,
//            studentCount: 890,
//            duration: "8 hours",
//            image: UIImage(systemName: "paintpalette"),
//            hasForum: false,
//            lessons: [
//                Lesson(id: "lesson12", title: "Design Principles", duration: "10:30"),
//                Lesson(id: "lesson13", title: "Color Theory", duration: "12:15"),
//                Lesson(id: "lesson14", title: "Typography", duration: "9:45")
//            ]
//        ),
//        Course(
//            id: "course5",
//            title: "Firebase for iOS",
//            description: "Learn to integrate Firebase services into your iOS applications.",
//            instructor: "Lisa Wang",
//            isFree: true,
//            rating: 4.8,
//            studentCount: 1876,
//            duration: "14 hours",
//            image: UIImage(systemName: "flame"),
//            hasForum: true,
//            lessons: [
//                Lesson(id: "lesson15", title: "Firebase Setup", duration: "8:00"),
//                Lesson(id: "lesson16", title: "Authentication", duration: "16:30"),
//                Lesson(id: "lesson17", title: "Firestore Database", duration: "20:00")
//            ]
//        )
//    ]
//    
//    // MARK: - Sample Enrollments
//    static var enrollments: [Enrollment] = [
//        Enrollment(
//            id: "enrollment1",
//            userId: "user1",
//            courseId: "course1",
//            progress: 0.35,
//            enrolledDate: Date().addingTimeInterval(-86400 * 7),  // 7 days ago
//            completedLessonIds: ["lesson1", "lesson2"]
//        ),
//        Enrollment(
//            id: "enrollment2",
//            userId: "user1",
//            courseId: "course3",
//            progress: 0.05,
//            enrolledDate: Date().addingTimeInterval(-86400 * 2),  // 2 days ago
//            completedLessonIds: []
//        )
//    ]
//    
//    // MARK: - Sample Forum Threads (for iOS Development Basics course)
//    static var forumThreads: [ForumThread] = [
//        ForumThread(
//            id: "thread1",
//            courseId: "course1",
//            userId: "user2",
//            userName: "John Doe",
//            userImage: UIImage(systemName: "person.circle.fill"),
//            title: "Having trouble with Auto Layout constraints",
//            content: "Can someone explain how to center a view using constraints? I'm trying to center a UILabel in my view controller, but the constraints don't seem to work as expected.",
//            timestamp: Date().addingTimeInterval(-7200),  // 2 hours ago
//            replyCount: 8
//        ),
//        ForumThread(
//            id: "thread2",
//            courseId: "course1",
//            userId: "user3",
//            userName: "Sarah M",
//            userImage: UIImage(systemName: "person.circle.fill"),
//            title: "Best practices for organizing Swift code?",
//            content: "What's your preferred project structure for medium-sized apps? I'm working on my first real project and want to set it up properly from the start.",
//            timestamp: Date().addingTimeInterval(-18000),  // 5 hours ago
//            replyCount: 15
//        ),
//        ForumThread(
//            id: "thread3",
//            courseId: "course1",
//            userId: "user4",
//            userName: "Mike Chen",
//            userImage: UIImage(systemName: "person.circle.fill"),
//            title: "Xcode simulator keeps crashing",
//            content: "Anyone else experiencing this issue with Xcode 15? The simulator crashes whenever I try to run my app.",
//            timestamp: Date().addingTimeInterval(-86400),  // 1 day ago
//            replyCount: 3
//        )
//    ]
//    
//    // MARK: - Sample Forum Replies (for thread1)
//    static var forumReplies: [ForumReply] = [
//        ForumReply(
//            id: "reply1",
//            threadId: "thread1",
//            userId: "user3",
//            userName: "Sarah M",
//            userImage: UIImage(systemName: "person.circle.fill"),
//            content: "You need to make sure you're setting `translatesAutoresizingMaskIntoConstraints = false` on your label. That's likely why it's not respecting your constraints!",
//            timestamp: Date().addingTimeInterval(-3600)  // 1 hour ago
//        ),
//        ForumReply(
//            id: "reply2",
//            threadId: "thread1",
//            userId: "user4",
//            userName: "Mike Chen",
//            userImage: UIImage(systemName: "person.circle.fill"),
//            content: "Also, here's how I usually center views. This works perfectly for me.",
//            timestamp: Date().addingTimeInterval(-2700)  // 45 min ago
//        ),
//        ForumReply(
//            id: "reply3",
//            threadId: "thread1",
//            userId: "user2",
//            userName: "John Doe",
//            userImage: UIImage(systemName: "person.circle.fill"),
//            content: "Thank you both! That fixed it. I was missing the translatesAutoresizing... line. 🎉",
//            timestamp: Date().addingTimeInterval(-1800)  // 30 min ago
//        )
//    ]
//    
//    // MARK: - Helper Methods
//    
//    // Get course by ID
//    static func getCourse(byId id: String) -> Course? {
//        return courses.first(where: { $0.id == id })
//    }
//    
//    // Get enrolled courses for current user
//    static func getEnrolledCourses() -> [Course] {
//        let enrolledIds = currentUser.enrolledCourseIds
//        return courses.filter { enrolledIds.contains($0.id) }
//    }
//    
//    // Get enrollment for a course
//    static func getEnrollment(forCourseId courseId: String) -> Enrollment? {
//        return enrollments.first(where: { $0.userId == currentUser.id && $0.courseId == courseId })
//    }
//    
//    // Check if user is enrolled in a course
//    static func isEnrolled(courseId: String) -> Bool {
//        return currentUser.enrolledCourseIds.contains(courseId)
//    }
//    
//    // Enroll in a course
//    static func enrollInCourse(courseId: String) {
//        if !isEnrolled(courseId: courseId) {
//            currentUser.enrolledCourseIds.append(courseId)
//            let newEnrollment = Enrollment(
//                id: "enrollment\(enrollments.count + 1)",
//                userId: currentUser.id,
//                courseId: courseId
//            )
//            enrollments.append(newEnrollment)
//        }
//    }
//    
//    // Get forum threads for a course
//    static func getForumThreads(forCourseId courseId: String) -> [ForumThread] {
//        return forumThreads.filter { $0.courseId == courseId }
//    }
//    
//    // Get replies for a thread
//    static func getReplies(forThreadId threadId: String) -> [ForumReply] {
//        return forumReplies.filter { $0.threadId == threadId }
//    }
//}
