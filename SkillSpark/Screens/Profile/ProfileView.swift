//
//  ProfileView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class ProfileView: UIView {

    var scrollView: UIScrollView!
        var contentView: UIView!
        
        var profileImageContainer: UIView!
        var profileImageView: UIImageView!
        var cameraButton: UIButton!
        
        var userNameLabel: UILabel!
        var userEmailLabel: UILabel!
        
        var statsContainer: UIView!
        var statsLabel: UILabel!
        var statsStackView: UIStackView!
        var coursesStatView: UIView!
        var coursesNumberLabel: UILabel!
        var coursesTextLabel: UILabel!
        var forumStatView: UIView!
        var forumNumberLabel: UILabel!
        var forumTextLabel: UILabel!
        
        var optionsLabel: UILabel!
        var editProfileButton: UIButton!
        var notificationsButton: UIButton!
        var settingsButton: UIButton!
        var signOutButton: UIButton!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            
            setupScrollView()
            setupProfileSection()
            setupStatsSection()
            setupOptionsSection()
            
            initConstraints()
        }
        
        func setupScrollView() {
            scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(scrollView)
            
            contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
        }
        
        func setupProfileSection() {
            profileImageContainer = UIView()
            profileImageContainer.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(profileImageContainer)
            
            profileImageView = UIImageView()
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.clipsToBounds = true
            profileImageView.layer.cornerRadius = 60
            profileImageView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.2)
            profileImageView.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            profileImageView.layer.borderWidth = 4
            profileImageView.layer.borderColor = UIColor.white.cgColor
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageContainer.addSubview(profileImageView)
            
            cameraButton = UIButton(type: .system)
            cameraButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
            cameraButton.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            cameraButton.tintColor = .white
            cameraButton.layer.cornerRadius = 18
            cameraButton.clipsToBounds = true
            cameraButton.translatesAutoresizingMaskIntoConstraints = false
            profileImageContainer.addSubview(cameraButton)
            
            userNameLabel = UILabel()
            userNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
            userNameLabel.textColor = .black
            userNameLabel.textAlignment = .center
            userNameLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(userNameLabel)
            
            userEmailLabel = UILabel()
            userEmailLabel.font = UIFont.systemFont(ofSize: 16)
            userEmailLabel.textColor = .gray
            userEmailLabel.textAlignment = .center
            userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(userEmailLabel)
        }
        
        func setupStatsSection() {
            statsContainer = UIView()
            statsContainer.backgroundColor = UIColor.systemGray6
            statsContainer.layer.cornerRadius = 12
            statsContainer.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(statsContainer)
            
            statsLabel = UILabel()
            statsLabel.text = "LEARNING STATS"
            statsLabel.font = UIFont.boldSystemFont(ofSize: 12)
            statsLabel.textColor = .gray
            statsLabel.translatesAutoresizingMaskIntoConstraints = false
            statsContainer.addSubview(statsLabel)
            
            coursesStatView = UIView()
            coursesStatView.translatesAutoresizingMaskIntoConstraints = false
            
            coursesNumberLabel = UILabel()
            coursesNumberLabel.font = UIFont.boldSystemFont(ofSize: 32)
            coursesNumberLabel.textColor = .black
            coursesNumberLabel.textAlignment = .center
            coursesNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            
            coursesTextLabel = UILabel()
            coursesTextLabel.text = "Courses Enrolled"
            coursesTextLabel.font = UIFont.systemFont(ofSize: 13)
            coursesTextLabel.textColor = .darkGray
            coursesTextLabel.textAlignment = .center
            coursesTextLabel.translatesAutoresizingMaskIntoConstraints = false
            
            coursesStatView.addSubview(coursesNumberLabel)
            coursesStatView.addSubview(coursesTextLabel)
            
            forumStatView = UIView()
            forumStatView.translatesAutoresizingMaskIntoConstraints = false
            
            forumNumberLabel = UILabel()
            forumNumberLabel.font = UIFont.boldSystemFont(ofSize: 32)
            forumNumberLabel.textColor = .black
            forumNumberLabel.textAlignment = .center
            forumNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            
            forumTextLabel = UILabel()
            forumTextLabel.text = "Forum Posts"
            forumTextLabel.font = UIFont.systemFont(ofSize: 13)
            forumTextLabel.textColor = .darkGray
            forumTextLabel.textAlignment = .center
            forumTextLabel.translatesAutoresizingMaskIntoConstraints = false
            
            forumStatView.addSubview(forumNumberLabel)
            forumStatView.addSubview(forumTextLabel)
            
            statsStackView = UIStackView(arrangedSubviews: [coursesStatView, forumStatView])
            statsStackView.axis = .horizontal
            statsStackView.distribution = .fillEqually
            statsStackView.spacing = 20
            statsStackView.translatesAutoresizingMaskIntoConstraints = false
            statsContainer.addSubview(statsStackView)
        }
        
        func setupOptionsSection() {
            optionsLabel = UILabel()
            optionsLabel.text = "SETTINGS"
            optionsLabel.font = UIFont.boldSystemFont(ofSize: 12)
            optionsLabel.textColor = .gray
            optionsLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(optionsLabel)
            
            editProfileButton = createOptionButton(title: "Edit Profile", iconName: "person.circle")
            contentView.addSubview(editProfileButton)
            
            notificationsButton = createOptionButton(title: "Notifications", iconName: "bell")
            contentView.addSubview(notificationsButton)
            
            settingsButton = createOptionButton(title: "Settings", iconName: "gear")
            contentView.addSubview(settingsButton)
            
            signOutButton = createOptionButton(title: "Sign Out", iconName: "arrow.right.square")
            signOutButton.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
            signOutButton.setTitleColor(.systemRed, for: .normal)
            signOutButton.tintColor = .systemRed
            contentView.addSubview(signOutButton)
        }
        
        func createOptionButton(title: String, iconName: String) -> UIButton {
            let button = UIButton(type: .system)
            
            button.backgroundColor = UIColor.systemGray6
            button.layer.cornerRadius = 12
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            
            let icon = UIImageView(image: UIImage(systemName: iconName))
            icon.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            icon.contentMode = .scaleAspectFit
            icon.translatesAutoresizingMaskIntoConstraints = false
            
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false

            let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
            chevron.tintColor = .gray
            chevron.contentMode = .scaleAspectFit
            chevron.translatesAutoresizingMaskIntoConstraints = false
            
            button.addSubview(icon)
            button.addSubview(label)
            button.addSubview(chevron)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                icon.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
                icon.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                icon.widthAnchor.constraint(equalToConstant: 24),
                icon.heightAnchor.constraint(equalToConstant: 24),
                
                label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
                label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                
                chevron.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16),
                chevron.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                chevron.widthAnchor.constraint(equalToConstant: 12),
                chevron.heightAnchor.constraint(equalToConstant: 20),
            ])
            
            return button
        }
        
        func initConstraints() {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                
                profileImageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
                profileImageContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                profileImageContainer.widthAnchor.constraint(equalToConstant: 120),
                profileImageContainer.heightAnchor.constraint(equalToConstant: 120),
                
                profileImageView.centerXAnchor.constraint(equalTo: profileImageContainer.centerXAnchor),
                profileImageView.centerYAnchor.constraint(equalTo: profileImageContainer.centerYAnchor),
                profileImageView.widthAnchor.constraint(equalToConstant: 120),
                profileImageView.heightAnchor.constraint(equalToConstant: 120),
                
                cameraButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 4),
                cameraButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4),
                cameraButton.widthAnchor.constraint(equalToConstant: 36),
                cameraButton.heightAnchor.constraint(equalToConstant: 36),
                
                userNameLabel.topAnchor.constraint(equalTo: profileImageContainer.bottomAnchor, constant: 16),
                userNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                userNameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 32),
                userNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -32),
                
                userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
                userEmailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                userEmailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 32),
                userEmailLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -32),
                
                statsContainer.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 32),
                statsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                statsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                statsLabel.topAnchor.constraint(equalTo: statsContainer.topAnchor, constant: 16),
                statsLabel.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 16),
                
                statsStackView.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 16),
                statsStackView.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 16),
                statsStackView.trailingAnchor.constraint(equalTo: statsContainer.trailingAnchor, constant: -16),
                statsStackView.bottomAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: -16),
                
                coursesNumberLabel.topAnchor.constraint(equalTo: coursesStatView.topAnchor),
                coursesNumberLabel.centerXAnchor.constraint(equalTo: coursesStatView.centerXAnchor),
                
                coursesTextLabel.topAnchor.constraint(equalTo: coursesNumberLabel.bottomAnchor, constant: 4),
                coursesTextLabel.centerXAnchor.constraint(equalTo: coursesStatView.centerXAnchor),
                coursesTextLabel.bottomAnchor.constraint(equalTo: coursesStatView.bottomAnchor),
                
                forumNumberLabel.topAnchor.constraint(equalTo: forumStatView.topAnchor),
                forumNumberLabel.centerXAnchor.constraint(equalTo: forumStatView.centerXAnchor),
                
                forumTextLabel.topAnchor.constraint(equalTo: forumNumberLabel.bottomAnchor, constant: 4),
                forumTextLabel.centerXAnchor.constraint(equalTo: forumStatView.centerXAnchor),
                forumTextLabel.bottomAnchor.constraint(equalTo: forumStatView.bottomAnchor),
                
                optionsLabel.topAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: 32),
                optionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                
                editProfileButton.topAnchor.constraint(equalTo: optionsLabel.bottomAnchor, constant: 12),
                editProfileButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                editProfileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                editProfileButton.heightAnchor.constraint(equalToConstant: 56),
                
                notificationsButton.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 12),
                notificationsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                notificationsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                notificationsButton.heightAnchor.constraint(equalToConstant: 56),
                
                settingsButton.topAnchor.constraint(equalTo: notificationsButton.bottomAnchor, constant: 12),
                settingsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                settingsButton.heightAnchor.constraint(equalToConstant: 56),
                
                signOutButton.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 12),
                signOutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                signOutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                signOutButton.heightAnchor.constraint(equalToConstant: 56),
                signOutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
