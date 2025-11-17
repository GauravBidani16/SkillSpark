//
//  MyCoursesViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class MyCoursesViewController: UIViewController {

    let myCoursesView = MyCoursesView()
        
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
            myCoursesView.tableViewCourses.reloadData()
        }
    }

    extension MyCoursesViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let count = 2  //Static Data for now
            
            myCoursesView.emptyStateLabel.isHidden = (count > 0)
            myCoursesView.tableViewCourses.isHidden = (count == 0)
            
            return count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnrolledCourseCell", for: indexPath) as! EnrolledCourseCell
            
            if indexPath.row == 0 {
                cell.titleLabel.text = "iOS Development Basics"
                cell.instructorLabel.text = "By Sarah Johnson"
                cell.statusLabel.text = "Continue learning"
                cell.progressLabel.text = "35%"
                cell.progressBar.progress = 0.35
                cell.courseImageView.image = UIImage(systemName: "swift")
            } else {
                cell.titleLabel.text = "Data Structures in Swift"
                cell.instructorLabel.text = "By Emily Rodriguez"
                cell.statusLabel.text = "Just started"
                cell.progressLabel.text = "5%"
                cell.progressBar.progress = 0.05
                cell.courseImageView.image = UIImage(systemName: "cpu")
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
//            let coursePlayerVC = CoursePlayerViewController()
//            navigationController?.pushViewController(coursePlayerVC, animated: true)
        }

}
