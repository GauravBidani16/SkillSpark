//
//  CoursePlayerView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/9/25.
//

import UIKit

class CoursePlayerView: UIView {
    
    var headerView: UIView!
    var courseImageView: UIImageView!
    var courseTitleLabel: UILabel!
    var instructorLabel: UILabel!
    var progressContainerView: UIView!
    var progressLabel: UILabel!
    var progressPercentLabel: UILabel!
    var progressBar: UIProgressView!
    
    var lessonsHeaderLabel: UILabel!
    var tableViewLessons: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupHeaderView()
        setupCourseImageView()
        setupCourseTitleLabel()
        setupInstructorLabel()
        setupProgressSection()
        setupLessonsSection()
        
        initConstraints()
    }
    
    func setupHeaderView() {
        headerView = UIView()
        headerView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerView)
    }
    
    func setupCourseImageView() {
        courseImageView = UIImageView()
        courseImageView.contentMode = .scaleAspectFit
        courseImageView.tintColor = .white
        courseImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(courseImageView)
    }
    
    func setupCourseTitleLabel() {
        courseTitleLabel = UILabel()
        courseTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        courseTitleLabel.textColor = .white
        courseTitleLabel.numberOfLines = 2
        courseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(courseTitleLabel)
    }
    
    func setupInstructorLabel() {
        instructorLabel = UILabel()
        instructorLabel.font = UIFont.systemFont(ofSize: 14)
        instructorLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        instructorLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(instructorLabel)
    }
    
    func setupProgressSection() {
        progressContainerView = UIView()
        progressContainerView.backgroundColor = UIColor.systemGray6
        progressContainerView.layer.cornerRadius = 12
        progressContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(progressContainerView)
        
        progressLabel = UILabel()
        progressLabel.text = "Your Progress"
        progressLabel.font = UIFont.boldSystemFont(ofSize: 14)
        progressLabel.textColor = .darkGray
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        progressContainerView.addSubview(progressLabel)
        
        progressPercentLabel = UILabel()
        progressPercentLabel.text = "0%"
        progressPercentLabel.font = UIFont.boldSystemFont(ofSize: 18)
        progressPercentLabel.textColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        progressPercentLabel.textAlignment = .right
        progressPercentLabel.translatesAutoresizingMaskIntoConstraints = false
        progressContainerView.addSubview(progressPercentLabel)
        
        progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.progressTintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        progressBar.trackTintColor = UIColor.systemGray4
        progressBar.layer.cornerRadius = 4
        progressBar.clipsToBounds = true
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressContainerView.addSubview(progressBar)
    }
    
    func setupLessonsSection() {
        lessonsHeaderLabel = UILabel()
        lessonsHeaderLabel.text = "LESSONS"
        lessonsHeaderLabel.font = UIFont.boldSystemFont(ofSize: 12)
        lessonsHeaderLabel.textColor = .gray
        lessonsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lessonsHeaderLabel)
        
        tableViewLessons = UITableView()
        tableViewLessons.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
        tableViewLessons.separatorStyle = .none
        tableViewLessons.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewLessons)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Header starts from top of view (not safe area) to cover the notch area with color
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            // Content inside header - pushed lower
            courseImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            courseImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -25),
            courseImageView.widthAnchor.constraint(equalToConstant: 50),
            courseImageView.heightAnchor.constraint(equalToConstant: 50),
            
            courseTitleLabel.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 16),
            courseTitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            courseTitleLabel.bottomAnchor.constraint(equalTo: instructorLabel.topAnchor, constant: -4),
            
            instructorLabel.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 16),
            instructorLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            instructorLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -25),
            
            progressContainerView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            progressContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            progressContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            progressLabel.topAnchor.constraint(equalTo: progressContainerView.topAnchor, constant: 12),
            progressLabel.leadingAnchor.constraint(equalTo: progressContainerView.leadingAnchor, constant: 16),
            
            progressPercentLabel.topAnchor.constraint(equalTo: progressContainerView.topAnchor, constant: 12),
            progressPercentLabel.trailingAnchor.constraint(equalTo: progressContainerView.trailingAnchor, constant: -16),
            
            progressBar.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: progressContainerView.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: progressContainerView.trailingAnchor, constant: -16),
            progressBar.heightAnchor.constraint(equalToConstant: 8),
            progressBar.bottomAnchor.constraint(equalTo: progressContainerView.bottomAnchor, constant: -12),
            
            lessonsHeaderLabel.topAnchor.constraint(equalTo: progressContainerView.bottomAnchor, constant: 24),
            lessonsHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            tableViewLessons.topAnchor.constraint(equalTo: lessonsHeaderLabel.bottomAnchor, constant: 12),
            tableViewLessons.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewLessons.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewLessons.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
