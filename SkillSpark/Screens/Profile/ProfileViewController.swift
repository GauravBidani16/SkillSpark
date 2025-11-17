//
//  ProfileViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileView = ProfileView()
        
        override func loadView() {
            view = profileView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Profile"
            
            setupProfileData()
            
            profileView.cameraButton.addTarget(self, action: #selector(onCameraButtonTapped), for: .touchUpInside)
            profileView.editProfileButton.addTarget(self, action: #selector(onEditProfileTapped), for: .touchUpInside)
            profileView.notificationsButton.addTarget(self, action: #selector(onNotificationsTapped), for: .touchUpInside)
            profileView.settingsButton.addTarget(self, action: #selector(onSettingsTapped), for: .touchUpInside)
            profileView.signOutButton.addTarget(self, action: #selector(onSignOutTapped), for: .touchUpInside)
        }
        
        func setupProfileData() {
            profileView.profileImageView.image = UIImage(systemName: "person.circle.fill")
            profileView.userNameLabel.text = "John Doe"
            profileView.userEmailLabel.text = "john.doe@email.com"
            
            profileView.coursesNumberLabel.text = "2"
            profileView.forumNumberLabel.text = "5"
        }
        
        @objc func onCameraButtonTapped() {
            let alert = UIAlertController(
                title: "Change Profile Picture",
                message: "Camera feature will allow you to take or upload a profile photo",
                preferredStyle: .actionSheet
            )
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default))
            alert.addAction(UIAlertAction(title: "Choose from Library", style: .default))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }
        
        @objc func onEditProfileTapped() {
            let alert = UIAlertController(
                title: "Edit Profile",
                message: "Edit your name, email, and other profile information",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        @objc func onNotificationsTapped() {
            let alert = UIAlertController(
                title: "Notifications",
                message: "Manage your notification preferences",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        @objc func onSettingsTapped() {
            let alert = UIAlertController(
                title: "Settings",
                message: "App settings and preferences",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        @objc func onSignOutTapped() {
            let alert = UIAlertController(
                title: "Sign Out",
                message: "Are you sure you want to sign out?",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive) { _ in
                self.showSignOutConfirmation()
            })
            present(alert, animated: true)
        }
        
        func showSignOutConfirmation() {
            let alert = UIAlertController(
                title: "Signed Out",
                message: "You have been signed out successfully",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }

}
