//
//  ForumThreadViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class ForumThreadViewController: UIViewController {

    let forumThreadView = ForumThreadView()
        
        let replies = [
            ("Sarah M", "1 hour ago", "You need to make sure you're setting `translatesAutoresizingMaskIntoConstraints = false` on your label. That's likely why it's not respecting your constraints!", false),
            ("Mike Chen", "45 min ago", "Also, here's how I usually center views. This works perfectly for me.", true),
            ("John Doe", "30 min ago", "Thank you both! That fixed it. I was missing the translatesAutoresizing... line. ", false),
        ]
        
        override func loadView() {
            view = forumThreadView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Discussion"
            
            setupOriginalPost()
            
            forumThreadView.tableViewReplies.delegate = self
            forumThreadView.tableViewReplies.dataSource = self
            
            forumThreadView.cameraButton.addTarget(self, action: #selector(onCameraButtonTapped), for: .touchUpInside)
            forumThreadView.sendButton.addTarget(self, action: #selector(onSendButtonTapped), for: .touchUpInside)
        }
        
        func setupOriginalPost() {
            forumThreadView.opUserImageView.image = UIImage(systemName: "person.circle.fill")
            forumThreadView.opUserNameLabel.text = "John Doe"
            forumThreadView.opTimestampLabel.text = "2 hours ago"
            forumThreadView.opTitleLabel.text = "Having trouble with Auto Layout constraints"
            forumThreadView.opContentLabel.text = "I'm trying to center a UILabel in my view controller, but the constraints don't seem to work as expected. The label appears in the top-left corner instead of the center. Can someone explain what I might be doing wrong?"
            
            forumThreadView.opAttachedImageView.isHidden = false
            forumThreadView.opAttachedImageView.backgroundColor = UIColor.systemGray4
            
            forumThreadView.opContentLabel.bottomAnchor.constraint(equalTo: forumThreadView.opAttachedImageView.topAnchor, constant: -12).isActive = false
        }
        
        @objc func onCameraButtonTapped() {
            let alert = UIAlertController(
                title: "Attach Image",
                message: "Camera feature will allow you to attach screenshots or photos to your reply",
                preferredStyle: .actionSheet
            )
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default))
            alert.addAction(UIAlertAction(title: "Choose from Library", style: .default))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }
        
        @objc func onSendButtonTapped() {
            guard let replyText = forumThreadView.replyTextField.text, !replyText.isEmpty else {
                return
            }
            
            let alert = UIAlertController(
                title: "Reply Posted",
                message: "Your reply has been added to the discussion",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.forumThreadView.replyTextField.text = ""
                self.forumThreadView.replyTextField.resignFirstResponder()
            })
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
        cell.userNameLabel.text = reply.0
        cell.timestampLabel.text = reply.1
        cell.replyLabel.text = reply.2
        cell.userImageView.image = UIImage(systemName: "person.circle.fill")
        
        // Configure with or without image
        let hasImage = reply.3
        cell.configureWithImage(hasImage)
        
        if hasImage {
            cell.attachedImageView.backgroundColor = UIColor.systemGray4
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
