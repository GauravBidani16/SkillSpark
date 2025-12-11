//
//  MyCoursesViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class MyCoursesViewController: UIViewController {

    let myCoursesView = MyCoursesView()
    
    var enrollments: [Enrollment] = []
    var courses: [String: Course] = [:]
    var isLoading: Bool = false
    
    override func loadView() {
        view = myCoursesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCoursesView.tableViewCourses.delegate = self
        myCoursesView.tableViewCourses.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchEnrollments()
    }
    
    func fetchEnrollments() {
        guard !isLoading else { return }
        isLoading = true
        
        FirebaseManager.shared.fetchEnrollments { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let enrollments):
                self.enrollments = enrollments
                
                if enrollments.isEmpty {
                    self.isLoading = false
                    self.updateUI()
                } else {
                    self.fetchCoursesForEnrollments()
                }
                
            case .failure(let error):
                self.isLoading = false
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func fetchCoursesForEnrollments() {
        let group = DispatchGroup()
        
        for enrollment in enrollments {
            group.enter()
            
            FirebaseManager.shared.fetchCourse(courseId: enrollment.courseId) { [weak self] result in
                guard let self = self else {
                    group.leave()
                    return
                }
                
                switch result {
                case .success(let course):
                    self.courses[course.id] = course
                    
                case .failure(let error):
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
            self.updateUI()
        }
    }
    
    func updateUI() {
        let hasEnrollments = !enrollments.isEmpty
        
        myCoursesView.emptyStateLabel.isHidden = hasEnrollments
        myCoursesView.tableViewCourses.isHidden = !hasEnrollments
        
        myCoursesView.tableViewCourses.reloadData()
    }
    
    func getStatusText(progress: Double) -> String {
        if progress == 0 {
            return "Not started"
        } else if progress < 0.5 {
            return "Just started"
        } else if progress < 1.0 {
            return "In progress"
        } else {
            return "Completed!"
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension MyCoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enrollments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnrolledCourseCell", for: indexPath) as! EnrolledCourseCell
        
        let enrollment = enrollments[indexPath.row]
        let course = courses[enrollment.courseId]
        
        cell.titleLabel.text = course?.title ?? "Loading..."
        cell.instructorLabel.text = "By \(course?.instructor ?? "...")"
        
        let progressPercent = Int(enrollment.progress * 100)
        cell.progressLabel.text = "\(progressPercent)%"
        cell.progressBar.progress = Float(enrollment.progress)
        
        cell.statusLabel.text = getStatusText(progress: enrollment.progress)
        
        if let title = course?.title {
            if title.contains("iOS") {
                cell.courseImageView.image = UIImage(systemName: "swift")
            } else if title.contains("Swift") {
                cell.courseImageView.image = UIImage(systemName: "chevron.left.forwardslash.chevron.right")
            } else if title.contains("Data") {
                cell.courseImageView.image = UIImage(systemName: "cpu")
            } else if title.contains("SwiftUI") {
                cell.courseImageView.image = UIImage(systemName: "rectangle.stack")
            } else {
                cell.courseImageView.image = UIImage(systemName: "book.fill")
            }
        } else {
            cell.courseImageView.image = UIImage(systemName: "book.fill")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let enrollment = enrollments[indexPath.row]
        guard let course = courses[enrollment.courseId] else { return }
        
        let coursePlayerVC = CoursePlayerViewController()
        coursePlayerVC.course = course
        coursePlayerVC.enrollment = enrollment
        navigationController?.pushViewController(coursePlayerVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Unenroll") { [weak self] (action, view, completion) in
            self?.confirmUnenroll(at: indexPath)
            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func confirmUnenroll(at indexPath: IndexPath) {
        let enrollment = enrollments[indexPath.row]
        let course = courses[enrollment.courseId]
        
        let alert = UIAlertController(
            title: "Unenroll?",
            message: "Are you sure you want to unenroll from '\(course?.title ?? "this course")'? Your progress will be lost.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Unenroll", style: .destructive) { _ in
            self.unenrollFromCourse(at: indexPath)
        })
        
        present(alert, animated: true)
    }

    func unenrollFromCourse(at indexPath: IndexPath) {
        let enrollment = enrollments[indexPath.row]
        
        FirebaseManager.shared.unenrollFromCourse(enrollmentId: enrollment.id, courseId: enrollment.courseId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.enrollments.remove(at: indexPath.row)
                self.courses.removeValue(forKey: enrollment.courseId)
                self.myCoursesView.tableViewCourses.deleteRows(at: [indexPath], with: .fade)
                self.updateUI()
                
            case .failure(let error):
                self.showErrorAlert(message: "Failed to unenroll: \(error.localizedDescription)")
            }
        }
    }
}
