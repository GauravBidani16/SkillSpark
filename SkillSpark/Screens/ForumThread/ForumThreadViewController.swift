//
//  ForumThreadViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit
import FirebaseFirestore

class ForumThreadViewController: UIViewController {

    let forumThreadView = ForumThreadView()
    
    var thread: ForumThread?
    var replies: [ForumReply] = []
    var listener: ListenerRegistration?
    
    var imagePickerManager: ImagePickerManager?
    var selectedImage: UIImage?
    var previewImageView: UIImageView?
    
    override func loadView() {
        view = forumThreadView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discussion"
        
        forumThreadView.tableViewReplies.delegate = self
        forumThreadView.tableViewReplies.dataSource = self
        
        forumThreadView.cameraButton.addTarget(self, action: #selector(onCameraButtonTapped), for: .touchUpInside)
        forumThreadView.sendButton.addTarget(self, action: #selector(onSendButtonTapped), for: .touchUpInside)
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        footerView.backgroundColor = .clear
        forumThreadView.tableViewReplies.tableFooterView = footerView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        setupOriginalPost()
        startListeningToReplies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
    }
    
    func setupOriginalPost() {
        guard let thread = thread else { return }
        
        forumThreadView.opUserImageView.image = UIImage(systemName: "person.circle.fill")
        forumThreadView.opUserNameLabel.text = thread.userName
        forumThreadView.opTimestampLabel.text = formatTimestamp(thread.timestamp)
        forumThreadView.opTitleLabel.text = thread.title
        forumThreadView.opContentLabel.text = thread.content
        
        if let imageURL = thread.imageURL, !imageURL.isEmpty {
            forumThreadView.opAttachedImageView.isHidden = false
        } else {
            forumThreadView.opAttachedImageView.isHidden = true
        }
    }
    
    func startListeningToReplies() {
        guard let threadId = thread?.id else { return }
        
        listener = FirebaseManager.shared.listenToForumReplies(threadId: threadId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let replies):
                self.replies = replies
                self.forumThreadView.tableViewReplies.reloadData()
                self.updateTableViewHeight()
                
            case .failure(let error):
            }
        }
    }
    
    func updateTableViewHeight() {
        forumThreadView.tableViewReplies.layoutIfNeeded()
        
        var totalHeight: CGFloat = 0
        for i in 0..<replies.count {
            let reply = replies[i]
            if let imageURL = reply.imageURL, !imageURL.isEmpty {
                totalHeight += 250
            } else {
                totalHeight += 100
            }
        }
        totalHeight += 20
        
        forumThreadView.tableViewReplies.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = max(totalHeight, 100)
            }
        }
        
        forumThreadView.layoutIfNeeded()
    }
    
    @objc func onSendButtonTapped() {
        guard let replyText = forumThreadView.replyTextField.text, !replyText.isEmpty else {
            if selectedImage == nil {
                return
            }
            return
        }
        
        guard let threadId = thread?.id else { return }
        
        forumThreadView.sendButton.isEnabled = false
        
        if let image = selectedImage {
            FirebaseManager.shared.uploadForumImage(image: image) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let imageURL):
                    self.postReply(threadId: threadId, content: replyText, imageURL: imageURL)
                    
                case .failure(let error):
                    self.forumThreadView.sendButton.isEnabled = true
                    self.showErrorAlert(message: "Failed to upload image")
                }
            }
        } else {
            postReply(threadId: threadId, content: replyText, imageURL: nil)
        }
    }

    func postReply(threadId: String, content: String, imageURL: String?) {
        FirebaseManager.shared.addForumReply(threadId: threadId, content: content, imageURL: imageURL) { [weak self] result in
            guard let self = self else { return }
            
            self.forumThreadView.sendButton.isEnabled = true
            
            switch result {
            case .success:
                self.forumThreadView.replyTextField.text = ""
                self.forumThreadView.replyTextField.resignFirstResponder()
                self.clearSelectedImage()
                
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    @objc func onCameraButtonTapped() {
        imagePickerManager = ImagePickerManager(presentingViewController: self)
        imagePickerManager?.delegate = self
        imagePickerManager?.showImagePickerOptions()
    }
    
    func showComingSoonAlert() {
        let alert = UIAlertController(
            title: "Coming Soon",
            message: "Image attachments will be available in Phase 10!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func formatTimestamp(_ timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        let now = Date()
        let diff = now.timeIntervalSince(date)
        
        if diff < 60 {
            return "Just now"
        } else if diff < 3600 {
            let mins = Int(diff / 60)
            return "\(mins) min ago"
        } else if diff < 86400 {
            let hours = Int(diff / 3600)
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        } else {
            let days = Int(diff / 86400)
            return "\(days) day\(days == 1 ? "" : "s") ago"
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ForumThreadViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForumReplyCell", for: indexPath) as! ForumReplyCell
        
        let reply = replies[indexPath.row]
        
        cell.delegate = self
        cell.userNameLabel.text = reply.userName
        cell.timestampLabel.text = formatTimestamp(reply.timestamp)
        cell.replyLabel.text = reply.content
        cell.userImageView.image = UIImage(systemName: "person.circle.fill")
        
        if let imageURL = reply.imageURL, !imageURL.isEmpty {
            cell.loadImage(from: imageURL)
        } else {
            cell.configure(hasImage: false)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let reply = replies[indexPath.row]
        if let imageURL = reply.imageURL, !imageURL.isEmpty {
            return 250
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ForumThreadViewController: ImagePickerDelegate {
    
    func didSelectImage(_ image: UIImage) {
        selectedImage = image
        showImagePreview(image)
    }
    
    func didCancelImagePicker() {
        print("Image picker cancelled")
    }
    
    func showImagePreview(_ image: UIImage) {
        previewImageView?.removeFromSuperview()
        
        previewImageView = UIImageView(image: image)
        previewImageView?.contentMode = .scaleAspectFill
        previewImageView?.clipsToBounds = true
        previewImageView?.layer.cornerRadius = 8
        previewImageView?.translatesAutoresizingMaskIntoConstraints = false
        
        let removeButton = UIButton(type: .close)
        removeButton.addTarget(self, action: #selector(removeImagePreview), for: .touchUpInside)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        guard let preview = previewImageView else { return }
        
        forumThreadView.replyInputContainer.addSubview(preview)
        preview.addSubview(removeButton)
        
        NSLayoutConstraint.activate([
            preview.leadingAnchor.constraint(equalTo: forumThreadView.cameraButton.trailingAnchor, constant: 8),
            preview.centerYAnchor.constraint(equalTo: forumThreadView.replyInputContainer.centerYAnchor),
            preview.widthAnchor.constraint(equalToConstant: 40),
            preview.heightAnchor.constraint(equalToConstant: 40),
            
            removeButton.topAnchor.constraint(equalTo: preview.topAnchor, constant: -5),
            removeButton.trailingAnchor.constraint(equalTo: preview.trailingAnchor, constant: 5),
            removeButton.widthAnchor.constraint(equalToConstant: 20),
            removeButton.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        forumThreadView.replyTextField.leadingAnchor.constraint(equalTo: preview.trailingAnchor, constant: 8).isActive = true
    }
    
    @objc func removeImagePreview() {
        clearSelectedImage()
    }
    
    func clearSelectedImage() {
        selectedImage = nil
        previewImageView?.removeFromSuperview()
        previewImageView = nil
    }
}

extension ForumThreadViewController: ForumReplyCellDelegate {
    func didTapImage(_ image: UIImage?) {
        guard let image = image else { return }
        
        let imageViewer = ImageViewerViewController()
        imageViewer.image = image
        imageViewer.modalPresentationStyle = .fullScreen
        present(imageViewer, animated: true)
    }
}
