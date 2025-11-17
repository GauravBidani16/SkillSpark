//
//  MyCoursesView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class MyCoursesView: UIView {

    var headerLabel: UILabel!
        var subtitleLabel: UILabel!
        var tableViewCourses: UITableView!
        var emptyStateLabel: UILabel!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            
            setupHeaderLabel()
            setupSubtitleLabel()
            setupTableView()
            setupEmptyStateLabel()
            
            initConstraints()
        }
        
        func setupHeaderLabel() {
            headerLabel = UILabel()
            headerLabel.text = "My Courses"
            headerLabel.font = UIFont.boldSystemFont(ofSize: 28)
            headerLabel.textColor = .black
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(headerLabel)
        }
        
        func setupSubtitleLabel() {
            subtitleLabel = UILabel()
            subtitleLabel.text = "Continue your learning journey"
            subtitleLabel.font = UIFont.systemFont(ofSize: 15)
            subtitleLabel.textColor = .gray
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subtitleLabel)
        }
        
        func setupTableView() {
            tableViewCourses = UITableView()
            tableViewCourses.register(EnrolledCourseCell.self, forCellReuseIdentifier: "EnrolledCourseCell")
            tableViewCourses.separatorStyle = .none
            tableViewCourses.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(tableViewCourses)
        }
        
        func setupEmptyStateLabel() {
            emptyStateLabel = UILabel()
            emptyStateLabel.text = "No courses enrolled yet.\nExplore courses from the Home tab!"
            emptyStateLabel.font = UIFont.systemFont(ofSize: 16)
            emptyStateLabel.textColor = .gray
            emptyStateLabel.textAlignment = .center
            emptyStateLabel.numberOfLines = 0
            emptyStateLabel.isHidden = true
            emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(emptyStateLabel)
        }
        
        func initConstraints() {
            NSLayoutConstraint.activate([
                headerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
                headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                
                subtitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 4),
                subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                
                tableViewCourses.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
                tableViewCourses.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                tableViewCourses.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tableViewCourses.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                
                emptyStateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                emptyStateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                emptyStateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
                emptyStateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
