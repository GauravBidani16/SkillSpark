//
//  CourseDetailViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class CourseDetailViewController: UIViewController {

    let courseDetailView = CourseDetailView()
    
    var course: Course?
    var lessons: [Lesson] = []
    var isEnrolled: Bool = false
    var enrollment: Enrollment?
    
    override func loadView() {
        view = courseDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Course Details"
        
        courseDetailView.enrollButton.addTarget(self, action: #selector(onEnrollButtonTapped), for: .touchUpInside)
        courseDetailView.forumButton.addTarget(self, action: #selector(onForumButtonTapped), for: .touchUpInside)
        
        setupCourseData()
        fetchLessons()
        checkEnrollmentStatus()
    }
    
    func setupCourseData() {
        guard let course = course else { return }
        
        courseDetailView.bannerImageView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.5)
        
        courseDetailView.titleLabel.text = course.title
        courseDetailView.instructorLabel.text = "By \(course.instructor)"
        courseDetailView.ratingLabel.text = "\(course.rating)"
        courseDetailView.studentsLabel.text = "\(course.studentCount) students"
        courseDetailView.durationLabel.text = "\(course.duration)"
        courseDetailView.descriptionLabel.text = course.description
        
        if course.isFree {
            courseDetailView.priceLabel.text = " FREE "
            courseDetailView.priceLabel.backgroundColor = .systemGreen
        } else {
            courseDetailView.priceLabel.text = " $\(course.price ?? 0) "
            courseDetailView.priceLabel.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        }
        
        courseDetailView.forumButton.isHidden = !course.hasForum
        
        addLearningPoints()
    }
    
    func addLearningPoints() {
        courseDetailView.whatYouLearnStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let course = course else { return }
        
        if course.title.contains("iOS") {
            courseDetailView.addLearningPoint("Swift programming fundamentals")
            courseDetailView.addLearningPoint("Building user interfaces with UIKit")
            courseDetailView.addLearningPoint("Working with Auto Layout and constraints")
            courseDetailView.addLearningPoint("Understanding the iOS app lifecycle")
        } else if course.title.contains("Advanced Swift") {
            courseDetailView.addLearningPoint("Generics and associated types")
            courseDetailView.addLearningPoint("Protocol-oriented programming")
            courseDetailView.addLearningPoint("Concurrency with async/await")
            courseDetailView.addLearningPoint("Memory management and ARC")
        } else if course.title.contains("Data Structures") {
            courseDetailView.addLearningPoint("Arrays, linked lists, and hash tables")
            courseDetailView.addLearningPoint("Stacks, queues, and trees")
            courseDetailView.addLearningPoint("Graphs and traversal algorithms")
            courseDetailView.addLearningPoint("Sorting and searching algorithms")
        } else if course.title.contains("SwiftUI") {
            courseDetailView.addLearningPoint("Declarative UI development")
            courseDetailView.addLearningPoint("State management and data flow")
            courseDetailView.addLearningPoint("Animations and transitions")
            courseDetailView.addLearningPoint("Building complex layouts")
        } else {
            courseDetailView.addLearningPoint("Core concepts and fundamentals")
            courseDetailView.addLearningPoint("Hands-on projects and exercises")
            courseDetailView.addLearningPoint("Best practices and patterns")
        }
    }
    
    func fetchLessons() {
        guard let courseId = course?.id else { return }
        
        FirebaseManager.shared.fetchLessons(courseId: courseId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let lessons):
                self.lessons = lessons
                self.displayLessons()
                
            case .failure(let error):
            }
        }
    }
    
    func displayLessons() {
        courseDetailView.syllabusStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, lesson) in lessons.enumerated() {
            courseDetailView.addSyllabusSection(
                title: "Lesson \(index + 1): \(lesson.title)",
                lessons: lesson.duration
            )
        }
        
        if lessons.isEmpty {
            courseDetailView.addSyllabusSection(title: "Coming Soon", lessons: "Lessons are being prepared")
        }
    }
    
    func checkEnrollmentStatus() {
        guard let courseId = course?.id else { return }
        
        FirebaseManager.shared.getEnrollment(courseId: courseId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let enrollment):
                if let enrollment = enrollment {
                    self.isEnrolled = true
                    self.enrollment = enrollment
                    self.updateEnrollButton()
                } else {
                    self.isEnrolled = false
                }
                
            case .failure(let error):
            }
        }
    }
    
    func updateEnrollButton() {
        if isEnrolled {
            courseDetailView.enrollButton.setTitle("Continue Learning", for: .normal)
            courseDetailView.enrollButton.backgroundColor = .systemGreen
        } else {
            guard let course = course else { return }
            if course.isFree {
                courseDetailView.enrollButton.setTitle("Enroll Now - Free", for: .normal)
            } else {
                courseDetailView.enrollButton.setTitle("Enroll Now - $\(course.price ?? 0)", for: .normal)
            }
            courseDetailView.enrollButton.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        }
    }
    
    @objc func onEnrollButtonTapped() {
        if isEnrolled {
            navigateToCoursePlayer()
        } else {
            enrollInCourse()
        }
    }
    
    func enrollInCourse() {
        guard let courseId = course?.id else { return }
        
        courseDetailView.enrollButton.isEnabled = false
        courseDetailView.enrollButton.setTitle("Enrolling...", for: .normal)
        
        FirebaseManager.shared.enrollInCourse(courseId: courseId) { [weak self] result in
            guard let self = self else { return }
            
            self.courseDetailView.enrollButton.isEnabled = true
            
            switch result {
            case .success:
                self.isEnrolled = true
                self.updateEnrollButton()
                self.showEnrollmentSuccess()
                
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
                self.updateEnrollButton()
            }
        }
    }
    
    func showEnrollmentSuccess() {
        let alert = UIAlertController(
            title: "Enrolled!",
            message: "You've been enrolled in \(course?.title ?? "this course"). Start learning now!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "View My Courses", style: .default) { _ in
            self.tabBarController?.selectedIndex = 1
        })
        alert.addAction(UIAlertAction(title: "Start Learning", style: .cancel) { _ in
            self.navigateToCoursePlayer()
        })
        present(alert, animated: true)
    }
    
    func navigateToCoursePlayer() {
        guard let course = course else { return }
        
        // Fetch the enrollment first
        FirebaseManager.shared.getEnrollment(courseId: course.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let enrollment):
                guard let enrollment = enrollment else {
                    print("No enrollment found")
                    return
                }
                
                let coursePlayerVC = CoursePlayerViewController()
                coursePlayerVC.course = course
                coursePlayerVC.enrollment = enrollment
                self.navigationController?.pushViewController(coursePlayerVC, animated: true)
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func onForumButtonTapped() {
        guard let course = course else { return }
        
        let forumVC = ForumViewController()
        forumVC.courseId = course.id
        forumVC.courseTitle = course.title
        navigationController?.pushViewController(forumVC, animated: true)
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
