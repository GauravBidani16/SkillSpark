//
//  CoursePlayerViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/9/25.
//

import UIKit

class CoursePlayerViewController: UIViewController {
    
    let coursePlayerView = CoursePlayerView()
    
    var course: Course?
    var enrollment: Enrollment?
    var lessons: [Lesson] = []
    var completedLessonIds: Set<String> = []
    
    override func loadView() {
        view = coursePlayerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Course Player"
        
        coursePlayerView.tableViewLessons.delegate = self
        coursePlayerView.tableViewLessons.dataSource = self
        
        setupCourseHeader()
        setupProgress()
        fetchLessons()
    }
    
    func setupCourseHeader() {
        guard let course = course else { return }
        
        coursePlayerView.courseTitleLabel.text = course.title
        coursePlayerView.instructorLabel.text = "By \(course.instructor)"
        
        if course.title.contains("iOS") {
            coursePlayerView.courseImageView.image = UIImage(systemName: "swift")
        } else if course.title.contains("Swift") {
            coursePlayerView.courseImageView.image = UIImage(systemName: "chevron.left.forwardslash.chevron.right")
        } else if course.title.contains("Data") {
            coursePlayerView.courseImageView.image = UIImage(systemName: "cpu")
        } else if course.title.contains("SwiftUI") {
            coursePlayerView.courseImageView.image = UIImage(systemName: "rectangle.stack")
        } else {
            coursePlayerView.courseImageView.image = UIImage(systemName: "book.fill")
        }
    }
    
    func setupProgress() {
        guard let enrollment = enrollment else { return }
        
        completedLessonIds = Set(enrollment.completedLessonIds)
        updateProgressUI()
    }
    
    func updateProgressUI() {
        guard let enrollment = enrollment else { return }
        
        let progress: Double
        if lessons.isEmpty {
            progress = enrollment.progress
        } else {
            progress = Double(completedLessonIds.count) / Double(lessons.count)
        }
        
        let progressPercent = Int(progress * 100)
        coursePlayerView.progressPercentLabel.text = "\(progressPercent)%"
        coursePlayerView.progressBar.progress = Float(progress)
    }
    
    func fetchLessons() {
        guard let courseId = course?.id else { return }
        
        FirebaseManager.shared.fetchLessons(courseId: courseId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let lessons):
                print("✅ Got \(lessons.count) lessons for player")
                self.lessons = lessons
                self.coursePlayerView.tableViewLessons.reloadData()
                self.updateProgressUI()
                
            case .failure(let error):
                print("❌ Error fetching lessons: \(error.localizedDescription)")
            }
        }
    }
    
    func toggleLessonCompletion(lesson: Lesson) {
        guard let enrollment = enrollment else { return }
        
        if completedLessonIds.contains(lesson.id) {
            completedLessonIds.remove(lesson.id)
        } else {
            completedLessonIds.insert(lesson.id)
        }
        
        let newProgress = lessons.isEmpty ? 0.0 : Double(completedLessonIds.count) / Double(lessons.count)
        
        FirebaseManager.shared.updateEnrollmentProgress(
            enrollmentId: enrollment.id,
            progress: newProgress,
            completedLessonIds: Array(completedLessonIds)
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.enrollment?.progress = newProgress
                self.enrollment?.completedLessonIds = Array(self.completedLessonIds)
                self.updateProgressUI()
                self.coursePlayerView.tableViewLessons.reloadData()
                
                if newProgress >= 1.0 {
                    self.showCompletionAlert()
                }
                
            case .failure(let error):
            }
        }
    }
    
    func showCompletionAlert() {
        let alert = UIAlertController(
            title: "Congratulations!",
            message: "You've completed '\(course?.title ?? "this course")'! Great job!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Awesome!", style: .default))
        present(alert, animated: true)
    }
}

extension CoursePlayerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        
        let lesson = lessons[indexPath.row]
        let isCompleted = completedLessonIds.contains(lesson.id)
        
        cell.configure(
            lessonNumber: indexPath.row + 1,
            title: lesson.title,
            duration: lesson.duration,
            isCompleted: isCompleted
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lesson = lessons[indexPath.row]
        let isCompleted = completedLessonIds.contains(lesson.id)
        
        let lessonContentVC = LessonContentViewController()
        lessonContentVC.courseId = course?.id ?? ""
        lessonContentVC.lesson = lesson
        lessonContentVC.lessonNumber = indexPath.row + 1
        lessonContentVC.isCompleted = isCompleted
        lessonContentVC.delegate = self
        
        navigationController?.pushViewController(lessonContentVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension CoursePlayerViewController: LessonContentDelegate {
    
    func didUpdateLessonCompletion(lessonId: String, isCompleted: Bool) {
        guard let enrollment = enrollment else { return }
        
        if isCompleted {
            completedLessonIds.insert(lessonId)
        } else {
            completedLessonIds.remove(lessonId)
        }
        
        let newProgress = lessons.isEmpty ? 0.0 : Double(completedLessonIds.count) / Double(lessons.count)
        
        FirebaseManager.shared.updateEnrollmentProgress(
            enrollmentId: enrollment.id,
            progress: newProgress,
            completedLessonIds: Array(completedLessonIds)
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.enrollment?.progress = newProgress
                self.enrollment?.completedLessonIds = Array(self.completedLessonIds)
                self.updateProgressUI()
                self.coursePlayerView.tableViewLessons.reloadData()
                
                if newProgress >= 1.0 {
                    self.showCompletionAlert()
                }
                
            case .failure(let error):
            }
        }
    }
}
