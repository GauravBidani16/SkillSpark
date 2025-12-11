//
//  HomeViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
    
    var allCourses: [Course] = []
    var filteredCourses: [Course] = []
    var currentFilter: String = "All"
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Explore Courses"
        
        homeView.tableViewCourses.delegate = self
        homeView.tableViewCourses.dataSource = self
        
        homeView.allButton.addTarget(self, action: #selector(onAllButtonTapped), for: .touchUpInside)
        homeView.freeButton.addTarget(self, action: #selector(onFreeButtonTapped), for: .touchUpInside)
        homeView.paidButton.addTarget(self, action: #selector(onPaidButtonTapped), for: .touchUpInside)
        
        homeView.searchBar.delegate = self
        
        fetchCourses()
    }
    
    func fetchCourses() {
        FirebaseManager.shared.fetchCourses { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let courses):
                self.allCourses = courses
                self.applyFilter()
                
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func applyFilter() {
        switch currentFilter {
        case "Free":
            filteredCourses = allCourses.filter { $0.isFree }
        case "Paid":
            filteredCourses = allCourses.filter { !$0.isFree }
        default:
            filteredCourses = allCourses
        }
        
        homeView.tableViewCourses.reloadData()
    }
    
    func updateFilterButtonStyles() {
        homeView.allButton.backgroundColor = UIColor.systemGray5
        homeView.allButton.setTitleColor(.darkGray, for: .normal)
        homeView.freeButton.backgroundColor = UIColor.systemGray5
        homeView.freeButton.setTitleColor(.darkGray, for: .normal)
        homeView.paidButton.backgroundColor = UIColor.systemGray5
        homeView.paidButton.setTitleColor(.darkGray, for: .normal)
        
        let activeColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        
        switch currentFilter {
        case "Free":
            homeView.freeButton.backgroundColor = activeColor
            homeView.freeButton.setTitleColor(.white, for: .normal)
        case "Paid":
            homeView.paidButton.backgroundColor = activeColor
            homeView.paidButton.setTitleColor(.white, for: .normal)
        default:
            homeView.allButton.backgroundColor = activeColor
            homeView.allButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc func onAllButtonTapped() {
        currentFilter = "All"
        updateFilterButtonStyles()
        applyFilter()
    }
    
    @objc func onFreeButtonTapped() {
        currentFilter = "Free"
        updateFilterButtonStyles()
        applyFilter()
    }
    
    @objc func onPaidButtonTapped() {
        currentFilter = "Paid"
        updateFilterButtonStyles()
        applyFilter()
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseTableViewCell
        
        let course = filteredCourses[indexPath.row]
        
        cell.titleLabel.text = course.title
        cell.descriptionLabel.text = course.description
        cell.instructorLabel.text = "By \(course.instructor)"
        cell.ratingLabel.text = "\(course.rating)"
        cell.studentsLabel.text = "\(course.studentCount) students"
        
        cell.courseImageView.image = UIImage(systemName: "book.fill")
        
        if course.isFree {
            cell.priceLabel.text = " FREE "
            cell.priceLabel.backgroundColor = .systemGreen
        } else {
            cell.priceLabel.text = " $\(course.price ?? 0) "
            cell.priceLabel.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCourse = filteredCourses[indexPath.row]
        
        let courseDetailVC = CourseDetailViewController()
        courseDetailVC.course = selectedCourse
        navigationController?.pushViewController(courseDetailVC, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            applyFilter()
        } else {
            filteredCourses = allCourses.filter { course in
                let matchesFilter: Bool
                switch currentFilter {
                case "Free":
                    matchesFilter = course.isFree
                case "Paid":
                    matchesFilter = !course.isFree
                default:
                    matchesFilter = true
                }
                
                let matchesSearch = course.title.lowercased().contains(searchText.lowercased()) ||
                                   course.instructor.lowercased().contains(searchText.lowercased())
                
                return matchesFilter && matchesSearch
            }
            homeView.tableViewCourses.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
