//
//  HomeView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class HomeView: UIView {

    var searchBar: UISearchBar!
        var filterButtonsStack: UIStackView!
        var allButton: UIButton!
        var freeButton: UIButton!
        var paidButton: UIButton!
        var tableViewCourses: UITableView!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            
            setupSearchBar()
            setupFilterButtons()
            setupTableView()
            initConstraints()
        }
        
        func setupSearchBar() {
            searchBar = UISearchBar()
            searchBar.placeholder = "Search courses..."
            searchBar.searchBarStyle = .minimal
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(searchBar)
        }
        
        func setupFilterButtons() {
            // All Button
            allButton = UIButton(type: .system)
            allButton.setTitle("All", for: .normal)
            allButton.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            allButton.setTitleColor(.white, for: .normal)
            allButton.layer.cornerRadius = 16
            allButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            allButton.translatesAutoresizingMaskIntoConstraints = false
            
            freeButton = UIButton(type: .system)
            freeButton.setTitle("Free", for: .normal)
            freeButton.backgroundColor = UIColor.systemGray5
            freeButton.setTitleColor(.darkGray, for: .normal)
            freeButton.layer.cornerRadius = 16
            freeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            freeButton.translatesAutoresizingMaskIntoConstraints = false
            
            paidButton = UIButton(type: .system)
            paidButton.setTitle("Paid", for: .normal)
            paidButton.backgroundColor = UIColor.systemGray5
            paidButton.setTitleColor(.darkGray, for: .normal)
            paidButton.layer.cornerRadius = 16
            paidButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            paidButton.translatesAutoresizingMaskIntoConstraints = false
            
            filterButtonsStack = UIStackView(arrangedSubviews: [allButton, freeButton, paidButton])
            filterButtonsStack.axis = .horizontal
            filterButtonsStack.spacing = 10
            filterButtonsStack.distribution = .fillEqually
            filterButtonsStack.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(filterButtonsStack)
        }
        
        func setupTableView() {
            tableViewCourses = UITableView()
            tableViewCourses.register(CourseTableViewCell.self, forCellReuseIdentifier: "CourseCell")
            tableViewCourses.separatorStyle = .none
            tableViewCourses.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(tableViewCourses)
        }
        
        func initConstraints() {
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                
                filterButtonsStack.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
                filterButtonsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                filterButtonsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                filterButtonsStack.heightAnchor.constraint(equalToConstant: 36),
                
                tableViewCourses.topAnchor.constraint(equalTo: filterButtonsStack.bottomAnchor, constant: 12),
                tableViewCourses.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                tableViewCourses.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tableViewCourses.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
