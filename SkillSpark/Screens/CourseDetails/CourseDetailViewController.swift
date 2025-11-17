//
//  CourseDetailViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class CourseDetailViewController: UIViewController {

    let courseDetailView = CourseDetailView()
        
        override func loadView() {
            view = courseDetailView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Course Details"
            
            setupPlaceholderData()
            
            courseDetailView.enrollButton.addTarget(self, action: #selector(onEnrollButtonTapped), for: .touchUpInside)
            courseDetailView.forumButton.addTarget(self, action: #selector(onForumButtonTapped), for: .touchUpInside)
        }
        
        func setupPlaceholderData() {
            courseDetailView.bannerImageView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.5)
            
            courseDetailView.titleLabel.text = "iOS Development Basics"
            courseDetailView.instructorLabel.text = "By Sarah Johnson"
            courseDetailView.ratingLabel.text = "4.8 (1,234 ratings)"
            courseDetailView.studentsLabel.text = "2,543 students"
            courseDetailView.durationLabel.text = "12 hours"
            
            courseDetailView.priceLabel.text = "FREE"
            courseDetailView.priceLabel.backgroundColor = .systemGreen
            
            courseDetailView.descriptionLabel.text = "Master the fundamentals of iOS development with Swift and UIKit. This comprehensive course covers everything you need to know to build your first iOS app. Perfect for beginners with no prior mobile development experience."
            
            courseDetailView.addLearningPoint("Swift programming fundamentals")
            courseDetailView.addLearningPoint("Building user interfaces with UIKit")
            courseDetailView.addLearningPoint("Working with Auto Layout and constraints")
            courseDetailView.addLearningPoint("Understanding the iOS app lifecycle")
            courseDetailView.addLearningPoint("Handling user interactions and gestures")
            
            courseDetailView.addSyllabusSection(title: "Section 1: Getting Started", lessons: "5 lessons • 45 min")
            courseDetailView.addSyllabusSection(title: "Section 2: Swift Basics", lessons: "8 lessons • 1.5 hours")
            courseDetailView.addSyllabusSection(title: "Section 3: Building Your First App", lessons: "6 lessons • 2 hours")
        }
        
        @objc func onEnrollButtonTapped() {
            let alert = UIAlertController(title: "Enrolled!", message: "You've been enrolled in this course.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "View My Courses", style: .default) { _ in
                self.tabBarController?.selectedIndex = 1
            })
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
        
        @objc func onForumButtonTapped() {
            let forumVC = ForumViewController()
            navigationController?.pushViewController(forumVC, animated: true)
        }

}
