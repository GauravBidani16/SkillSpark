//
//  HomeViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
        
        override func loadView() {
            view = homeView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Explore Courses"
            
            homeView.tableViewCourses.delegate = self
            homeView.tableViewCourses.dataSource = self
        }
    }

    extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5  // Statis Data for now
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseTableViewCell
            
            cell.titleLabel.text = "Sample Course Title \(indexPath.row + 1)"
            cell.descriptionLabel.text = "This is a sample course description that shows what the course is about"
            cell.instructorLabel.text = "By Instructor Name"
            cell.courseImageView.image = UIImage(systemName: "book.fill")
            cell.ratingLabel.text = "4.8"
            cell.studentsLabel.text = "2.5k students"
            
            if indexPath.row % 2 == 0 {
                cell.priceLabel.text = "FREE"
                cell.priceLabel.backgroundColor = .systemGreen
            } else {
                cell.priceLabel.text = "$29.99"
                cell.priceLabel.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
    
            let courseDetailVC = CourseDetailViewController()
            navigationController?.pushViewController(courseDetailVC, animated: true)
        }
}
