//
//  FirebaseManager.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/9/25.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import UIKit

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    // MARK: - Firebase References
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    // MARK: - Current User
    var currentUserId: String = "user1"
    
    // MARK: - COURSES
    
    /// Fetch all courses
    func fetchCourses(completion: @escaping (Result<[Course], Error>) -> Void) {
        db.collection("courses").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            var courses: [Course] = []
            for document in documents {
                do {
                    var course = try document.data(as: Course.self)
                    course.id = document.documentID
                    courses.append(course)
                } catch {
                    print("Error decoding course: \(error)")
                }
            }
            
            courses.sort { $0.title < $1.title }
            completion(.success(courses))
        }
    }
    
    /// Fetch a single course by ID
    func fetchCourse(courseId: String, completion: @escaping (Result<Course, Error>) -> Void) {
        db.collection("courses").document(courseId).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Course not found"])))
                return
            }
            
            do {
                var course = try snapshot.data(as: Course.self)
                course.id = snapshot.documentID
                completion(.success(course))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    /// Fetch lessons for a course
    func fetchLessons(courseId: String, completion: @escaping (Result<[Lesson], Error>) -> Void) {
        db.collection("courses").document(courseId).collection("lessons")
            .order(by: "order")
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                var lessons: [Lesson] = []
                for document in documents {
                    do {
                        var lesson = try document.data(as: Lesson.self)
                        lesson.id = document.documentID
                        lessons.append(lesson)
                    } catch {
                        print("Error decoding lesson: \(error)")
                    }
                }
                
                completion(.success(lessons))
            }
    }
    
    // MARK: - USERS
    
    /// Fetch current user
    func fetchCurrentUser(completion: @escaping (Result<User, Error>) -> Void) {
        db.collection("users").document(currentUserId).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                return
            }
            
            do {
                var user = try snapshot.data(as: User.self)
                user.id = snapshot.documentID
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    /// Update user profile
    func updateUser(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection("users").document(user.id).setData(from: user) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - ENROLLMENTS
    
    /// Fetch enrollments for current user
    func fetchEnrollments(completion: @escaping (Result<[Enrollment], Error>) -> Void) {
        db.collection("enrollments")
            .whereField("userId", isEqualTo: currentUserId)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                var enrollments: [Enrollment] = []
                for document in documents {
                    do {
                        var enrollment = try document.data(as: Enrollment.self)
                        enrollment.id = document.documentID
                        enrollments.append(enrollment)
                    } catch {
                        print("Error decoding enrollment: \(error)")
                    }
                }
                
                completion(.success(enrollments))
            }
    }
    
    /// Enroll in a course
    func enrollInCourse(courseId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Check if already enrolled
        db.collection("enrollments")
            .whereField("userId", isEqualTo: currentUserId)
            .whereField("courseId", isEqualTo: courseId)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let documents = snapshot?.documents, !documents.isEmpty {
                    completion(.success(()))
                    return
                }
                
                let enrollment = Enrollment(
                    id: UUID().uuidString,
                    userId: self.currentUserId,
                    courseId: courseId,
                    progress: 0.0,
                    enrolledDate: Timestamp(),
                    completedLessonIds: []
                )
                
                do {
                    try self.db.collection("enrollments").document(enrollment.id).setData(from: enrollment) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            self.db.collection("users").document(self.currentUserId).updateData([
                                "enrolledCourseIds": FieldValue.arrayUnion([courseId])
                            ]) { error in
                                if let error = error {
                                    print("Error updating user enrollments: \(error)")
                                }
                                completion(.success(()))
                            }
                        }
                    }
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    /// Update enrollment progress
    func updateEnrollmentProgress(enrollmentId: String, progress: Double, completedLessonIds: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("enrollments").document(enrollmentId).updateData([
            "progress": progress,
            "completedLessonIds": completedLessonIds
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    /// Get enrollment for a specific course
    func getEnrollment(courseId: String, completion: @escaping (Result<Enrollment?, Error>) -> Void) {
        db.collection("enrollments")
            .whereField("userId", isEqualTo: currentUserId)
            .whereField("courseId", isEqualTo: courseId)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let document = snapshot?.documents.first else {
                    completion(.success(nil))
                    return
                }
                
                do {
                    var enrollment = try document.data(as: Enrollment.self)
                    enrollment.id = document.documentID
                    completion(.success(enrollment))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    
    /// Fetch forum threads for a course
    func fetchForumThreads(courseId: String, completion: @escaping (Result<[ForumThread], Error>) -> Void) {
        db.collection("forumThreads")
            .whereField("courseId", isEqualTo: courseId)
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                var threads: [ForumThread] = []
                for document in documents {
                    do {
                        var thread = try document.data(as: ForumThread.self)
                        thread.id = document.documentID
                        threads.append(thread)
                    } catch {
                        print("Error decoding thread: \(error)")
                    }
                }
                
                completion(.success(threads))
            }
    }
    
    /// Create a new forum thread
    func createForumThread(courseId: String, title: String, content: String, completion: @escaping (Result<String, Error>) -> Void) {
        fetchCurrentUser { result in
            switch result {
            case .success(let user):
                let thread = ForumThread(
                    id: UUID().uuidString,
                    courseId: courseId,
                    userId: self.currentUserId,
                    userName: user.name,
                    title: title,
                    content: content,
                    timestamp: Timestamp(),
                    replyCount: 0
                )
                
                do {
                    try self.db.collection("forumThreads").document(thread.id).setData(from: thread) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(thread.id))
                        }
                    }
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    /// Fetch replies for a thread
    func fetchForumReplies(threadId: String, completion: @escaping (Result<[ForumReply], Error>) -> Void) {
        db.collection("forumReplies")
            .whereField("threadId", isEqualTo: threadId)
            .order(by: "timestamp")
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                var replies: [ForumReply] = []
                for document in documents {
                    do {
                        var reply = try document.data(as: ForumReply.self)
                        reply.id = document.documentID
                        replies.append(reply)
                    } catch {
                        print("Error decoding reply: \(error)")
                    }
                }
                
                completion(.success(replies))
            }
    }
    
    /// Add a reply to a thread
    func addForumReply(threadId: String, content: String, imageURL: String? = nil, completion: @escaping (Result<Void, Error>) -> Void) {
        fetchCurrentUser { result in
            switch result {
            case .success(let user):
                let reply = ForumReply(
                    id: UUID().uuidString,
                    threadId: threadId,
                    userId: self.currentUserId,
                    userName: user.name,
                    content: content,
                    timestamp: Timestamp(),
                    imageURL: imageURL
                )
                
                do {
                    try self.db.collection("forumReplies").document(reply.id).setData(from: reply) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            self.db.collection("forumThreads").document(threadId).updateData([
                                "replyCount": FieldValue.increment(Int64(1))
                            ]) { error in
                                if let error = error {
                                    print("Error updating reply count: \(error)")
                                }
                                completion(.success(()))
                            }
                        }
                    }
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - STORAGE (Images)
    
    /// Upload image to Firebase Storage
    func uploadImage(image: UIImage, path: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Compress image
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not compress image"])))
            return
        }
        
        let storageRef = storage.reference().child(path)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let downloadURL = url else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not get download URL"])))
                    return
                }
                
                completion(.success(downloadURL.absoluteString))
            }
        }
    }
    
    /// Upload profile image
    func uploadProfileImage(image: UIImage, userId: String, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "profile_images/\(userId)/\(UUID().uuidString).jpg"
        uploadImage(image: image, path: path) { result in
            switch result {
            case .success(let url):
                self.db.collection("users").document(userId).updateData([
                    "profileImageURL": url
                ]) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(url))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Upload forum reply image
    func uploadForumImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let path = "forum_images/\(UUID().uuidString).jpg"
        uploadImage(image: image, path: path, completion: completion)
    }
    
    
    /// Listen to forum threads (real-time updates)
    func listenToForumThreads(courseId: String, completion: @escaping (Result<[ForumThread], Error>) -> Void) -> ListenerRegistration {
        return db.collection("forumThreads")
            .whereField("courseId", isEqualTo: courseId)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                var threads: [ForumThread] = []
                for document in documents {
                    do {
                        var thread = try document.data(as: ForumThread.self)
                        thread.id = document.documentID
                        threads.append(thread)
                    } catch {
                        print("Error decoding thread: \(error)")
                    }
                }
                
                completion(.success(threads))
            }
    }
    
    /// Listen to forum replies (real-time updates)
    func listenToForumReplies(threadId: String, completion: @escaping (Result<[ForumReply], Error>) -> Void) -> ListenerRegistration {
        return db.collection("forumReplies")
            .whereField("threadId", isEqualTo: threadId)
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                var replies: [ForumReply] = []
                for document in documents {
                    do {
                        var reply = try document.data(as: ForumReply.self)
                        reply.id = document.documentID
                        replies.append(reply)
                    } catch {
                        print("Error decoding reply: \(error)")
                    }
                }
                
                completion(.success(replies))
            }
    }
    
    /// Unenroll from a course
    func unenrollFromCourse(enrollmentId: String, courseId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("enrollments").document(enrollmentId).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Remove courseId from user's enrolledCourseIds array
            self.db.collection("users").document(self.currentUserId).updateData([
                "enrolledCourseIds": FieldValue.arrayRemove([courseId])
            ]) { error in
                if let error = error {
                    print("Error updating user enrollments: \(error)")
                }
                completion(.success(()))
            }
        }
    }
    
    func registerUser(name: String, email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let firebaseUser = authResult?.user else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create user"])))
                return
            }
            
            let newUser = User(
                id: firebaseUser.uid,
                name: name,
                email: email,
                profileImageURL: nil,
                enrolledCourseIds: []
            )
            
            do {
                try self.db.collection("users").document(firebaseUser.uid).setData(from: newUser) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    // Update currentUserId
                    self.currentUserId = firebaseUser.uid
                    completion(.success(newUser))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

    /// Login existing user
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let firebaseUser = authResult?.user else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to sign in"])))
                return
            }
            
            self.currentUserId = firebaseUser.uid
            
            self.fetchCurrentUser(completion: completion)
        }
    }

    /// Sign out current user
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            currentUserId = ""
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    /// Check if user is logged in
    func isUserLoggedIn() -> Bool {
        if let user = Auth.auth().currentUser {
            currentUserId = user.uid
            return true
        }
        return false
    }

    /// Get current Firebase Auth user ID
    func getCurrentAuthUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    // MARK: - LESSON SECTIONS

    /// Fetch sections for a lesson
    func fetchLessonSections(courseId: String, lessonId: String, completion: @escaping (Result<[LessonSection], Error>) -> Void) {
        db.collection("courses").document(courseId)
            .collection("lessons").document(lessonId)
            .collection("sections")
            .order(by: "order")
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                var sections: [LessonSection] = []
                for document in documents {
                    do {
                        var section = try document.data(as: LessonSection.self)
                        section.id = document.documentID
                        sections.append(section)
                    } catch {
                        print("Error decoding section: \(error)")
                    }
                }
                
                completion(.success(sections))
            }
    }
}
