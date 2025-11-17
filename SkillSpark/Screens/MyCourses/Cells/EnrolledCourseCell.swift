//
//  EnrolledCourseCell.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class EnrolledCourseCell: UITableViewCell {

    var wrapperView: UIView!
        var courseImageView: UIImageView!
        var titleLabel: UILabel!
        var instructorLabel: UILabel!
        var statusLabel: UILabel!
        var progressLabel: UILabel!
        var progressBar: UIProgressView!
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupWrapperView()
            setupCourseImageView()
            setupTitleLabel()
            setupInstructorLabel()
            setupStatusLabel()
            setupProgressLabel()
            setupProgressBar()
            
            initConstraints()
        }
        
        func setupWrapperView() {
            wrapperView = UIView()
            wrapperView.backgroundColor = .white
            wrapperView.layer.cornerRadius = 12
            wrapperView.layer.shadowColor = UIColor.gray.cgColor
            wrapperView.layer.shadowOffset = CGSize(width: 0, height: 2)
            wrapperView.layer.shadowRadius = 4.0
            wrapperView.layer.shadowOpacity = 0.2
            wrapperView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(wrapperView)
        }
        
        func setupCourseImageView() {
            courseImageView = UIImageView()
            courseImageView.contentMode = .scaleAspectFit
            courseImageView.clipsToBounds = true
            courseImageView.layer.cornerRadius = 8
            courseImageView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.1)
            courseImageView.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            courseImageView.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(courseImageView)
        }
        
        func setupTitleLabel() {
            titleLabel = UILabel()
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 2
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(titleLabel)
        }
        
        func setupInstructorLabel() {
            instructorLabel = UILabel()
            instructorLabel.font = UIFont.systemFont(ofSize: 14)
            instructorLabel.textColor = .gray
            instructorLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(instructorLabel)
        }
        
        func setupStatusLabel() {
            statusLabel = UILabel()
            statusLabel.font = UIFont.systemFont(ofSize: 14)
            statusLabel.textColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            statusLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(statusLabel)
        }
        
        func setupProgressLabel() {
            progressLabel = UILabel()
            progressLabel.font = UIFont.boldSystemFont(ofSize: 13)
            progressLabel.textColor = .darkGray
            progressLabel.textAlignment = .right
            progressLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(progressLabel)
        }
        
        func setupProgressBar() {
            progressBar = UIProgressView(progressViewStyle: .default)
            progressBar.progressTintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            progressBar.trackTintColor = UIColor.systemGray5
            progressBar.layer.cornerRadius = 4
            progressBar.clipsToBounds = true
            progressBar.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(progressBar)
        }
        
        func initConstraints() {
            NSLayoutConstraint.activate([
                wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
                wrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                wrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
                
                courseImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
                courseImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 12),
                courseImageView.widthAnchor.constraint(equalToConstant: 70),
                courseImageView.heightAnchor.constraint(equalToConstant: 70),
                
                titleLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 12),
                titleLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
                
                instructorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                instructorLabel.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 12),
                instructorLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
                
                statusLabel.topAnchor.constraint(equalTo: instructorLabel.bottomAnchor, constant: 8),
                statusLabel.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 12),
                
                progressLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
                progressLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
                
                progressBar.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 6),
                progressBar.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 12),
                progressBar.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
                progressBar.heightAnchor.constraint(equalToConstant: 8),
                progressBar.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -12),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
