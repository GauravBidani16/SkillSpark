//
//  ProfileViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//


import UIKit
import FirebaseFirestore

class ProfileViewController: UIViewController {

    let profileView = ProfileView()
    
    var currentUser: User?
    var enrollmentCount: Int = 0
    var forumPostCount: Int = 0
    var imagePickerManager: ImagePickerManager?
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        profileView.cameraButton.addTarget(self, action: #selector(onCameraButtonTapped), for: .touchUpInside)
        profileView.editProfileButton.addTarget(self, action: #selector(onEditProfileTapped), for: .touchUpInside)
        profileView.notificationsButton.addTarget(self, action: #selector(onNotificationsTapped), for: .touchUpInside)
        profileView.settingsButton.addTarget(self, action: #selector(onSettingsTapped), for: .touchUpInside)
        profileView.signOutButton.addTarget(self, action: #selector(onSignOutTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUserData()
        fetchStats()
    }
    
    func fetchUserData() {
        FirebaseManager.shared.fetchCurrentUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print("✅ Got user: \(user.name)")
                self.currentUser = user
                self.updateProfileUI()
                
            case .failure(let error):
                print("❌ Error fetching user: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchStats() {
        FirebaseManager.shared.fetchEnrollments { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let enrollments):
                self.enrollmentCount = enrollments.count
                self.updateStatsUI()
                
            case .failure(let error):
                print("❌ Error fetching enrollments: \(error.localizedDescription)")
            }
        }
        
        fetchForumPostCount()
    }
    
    func fetchForumPostCount() {
        let userId = FirebaseManager.shared.currentUserId
        var totalPosts = 0
        let group = DispatchGroup()
        
        group.enter()
        Firestore.firestore().collection("forumThreads")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let docs = snapshot?.documents {
                    totalPosts += docs.count
                }
                group.leave()
            }
        
        group.enter()
        Firestore.firestore().collection("forumReplies")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let docs = snapshot?.documents {
                    totalPosts += docs.count
                }
                group.leave()
            }
        
        group.notify(queue: .main) {
            self.forumPostCount = totalPosts
            self.updateStatsUI()
        }
    }
    
    func updateProfileUI() {
        guard let user = currentUser else { return }
        
        profileView.userNameLabel.text = user.name
        profileView.userEmailLabel.text = user.email
        
        if let imageURLString = user.profileImageURL, !imageURLString.isEmpty,
           let imageURL = URL(string: imageURLString) {
            loadImage(from: imageURL) { [weak self] image in
                if let image = image {
                    self?.profileView.profileImageView.image = image
                }
            }
        } else {
            profileView.profileImageView.image = UIImage(systemName: "person.circle.fill")
        }
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func updateStatsUI() {
        profileView.coursesNumberLabel.text = "\(enrollmentCount)"
        profileView.forumNumberLabel.text = "\(forumPostCount)"
    }
    
    @objc func onCameraButtonTapped() {
        imagePickerManager = ImagePickerManager(presentingViewController: self)
        imagePickerManager?.delegate = self
        imagePickerManager?.showImagePickerOptions()
    }
    
    @objc func onEditProfileTapped() {
        showEditProfileAlert()
    }
    
    func showEditProfileAlert() {
        let alert = UIAlertController(
            title: "Edit Profile",
            message: "Update your display name",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
            textField.text = self.currentUser?.name
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            guard let newName = alert.textFields?[0].text, !newName.isEmpty else { return }
            self.updateUserName(newName)
        })
        
        present(alert, animated: true)
    }
    
    func updateUserName(_ newName: String) {
        guard var user = currentUser else { return }
        user.name = newName
        
        FirebaseManager.shared.updateUser(user: user) { [weak self] result in
            switch result {
            case .success:
                print("✅ Name updated to: \(newName)")
                self?.currentUser?.name = newName
                self?.updateProfileUI()
                
            case .failure(let error):
                print("❌ Error updating name: \(error.localizedDescription)")
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    @objc func onNotificationsTapped() {
        let alert = UIAlertController(
            title: "Notifications",
            message: "Notification settings coming soon!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func onSettingsTapped() {
        let alert = UIAlertController(
            title: "Settings",
            message: "App settings coming soon!",
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
            // Will implement proper sign out in Phase 9 (Authentication)
            self.showSignOutConfirmation()
        })
        
        present(alert, animated: true)
    }
    
    func showSignOutConfirmation() {
        FirebaseManager.shared.signOut { [weak self] result in
            switch result {
            case .success:
                print("✅ Signed out successfully")
                self?.navigateToLogin()
                
            case .failure(let error):
                print("❌ Sign out error: \(error.localizedDescription)")
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func navigateToLogin() {
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = navController
            window.makeKeyAndVisible()
            
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }
    
    func showComingSoonAlert() {
        let alert = UIAlertController(
            title: "Coming Soon",
            message: "Camera functionality will be available in Phase 10!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - ImagePickerDelegate
extension ProfileViewController: ImagePickerDelegate {
    
    func didSelectImage(_ image: UIImage) {
        profileView.profileImageView.alpha = 0.5
        
        let userId = FirebaseManager.shared.currentUserId
        
        FirebaseManager.shared.uploadProfileImage(image: image, userId: userId) { [weak self] result in
            guard let self = self else { return }
            
            self.profileView.profileImageView.alpha = 1.0
            
            switch result {
            case .success(let imageURL):
                print("✅ Profile image uploaded: \(imageURL)")
                self.profileView.profileImageView.image = image
                self.currentUser?.profileImageURL = imageURL
                self.showSuccessAlert(message: "Profile photo updated!")
                
            case .failure(let error):
                print("❌ Error uploading image: \(error.localizedDescription)")
                self.showErrorAlert(message: "Failed to upload image: \(error.localizedDescription)")
            }
        }
    }
    
    func didCancelImagePicker() {
        print("Image picker cancelled")
    }
    
    func showSuccessAlert(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
