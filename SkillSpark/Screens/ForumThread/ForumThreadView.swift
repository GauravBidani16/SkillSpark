//
//  ForumThreadView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class ForumThreadView: UIView {

    var scrollView: UIScrollView!
        var contentView: UIView!
        
        var originalPostContainer: UIView!
        var opUserImageView: UIImageView!
        var opUserNameLabel: UILabel!
        var opTimestampLabel: UILabel!
        var opTitleLabel: UILabel!
        var opContentLabel: UILabel!
        var opAttachedImageView: UIImageView!
        
        var repliesTitleLabel: UILabel!
        var tableViewReplies: UITableView!
        
        var replyInputContainer: UIView!
        var cameraButton: UIButton!
        var replyTextField: UITextField!
        var sendButton: UIButton!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            
            setupScrollView()
            setupOriginalPost()
            setupRepliesSection()
            setupReplyInput()
            
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
        
        func setupOriginalPost() {
            originalPostContainer = UIView()
            originalPostContainer.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.05)
            originalPostContainer.layer.cornerRadius = 12
            originalPostContainer.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(originalPostContainer)
            
            opUserImageView = UIImageView()
            opUserImageView.contentMode = .scaleAspectFill
            opUserImageView.clipsToBounds = true
            opUserImageView.layer.cornerRadius = 20
            opUserImageView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.2)
            opUserImageView.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            opUserImageView.translatesAutoresizingMaskIntoConstraints = false
            originalPostContainer.addSubview(opUserImageView)
            
            opUserNameLabel = UILabel()
            opUserNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
            opUserNameLabel.textColor = .black
            opUserNameLabel.translatesAutoresizingMaskIntoConstraints = false
            originalPostContainer.addSubview(opUserNameLabel)
            
            opTimestampLabel = UILabel()
            opTimestampLabel.font = UIFont.systemFont(ofSize: 13)
            opTimestampLabel.textColor = .gray
            opTimestampLabel.translatesAutoresizingMaskIntoConstraints = false
            originalPostContainer.addSubview(opTimestampLabel)
            
            opTitleLabel = UILabel()
            opTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            opTitleLabel.textColor = .black
            opTitleLabel.numberOfLines = 0
            opTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            originalPostContainer.addSubview(opTitleLabel)
            
            opContentLabel = UILabel()
            opContentLabel.font = UIFont.systemFont(ofSize: 15)
            opContentLabel.textColor = .darkGray
            opContentLabel.numberOfLines = 0
            opContentLabel.translatesAutoresizingMaskIntoConstraints = false
            originalPostContainer.addSubview(opContentLabel)
            
            opAttachedImageView = UIImageView()
            opAttachedImageView.contentMode = .scaleAspectFill
            opAttachedImageView.clipsToBounds = true
            opAttachedImageView.layer.cornerRadius = 8
            opAttachedImageView.backgroundColor = UIColor.systemGray5
            opAttachedImageView.isHidden = true
            opAttachedImageView.translatesAutoresizingMaskIntoConstraints = false
            originalPostContainer.addSubview(opAttachedImageView)
        }
        
        func setupRepliesSection() {
            repliesTitleLabel = UILabel()
            repliesTitleLabel.text = "Replies"
            repliesTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            repliesTitleLabel.textColor = .black
            repliesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(repliesTitleLabel)
            
            tableViewReplies = UITableView()
            tableViewReplies.register(ForumReplyCell.self, forCellReuseIdentifier: "ForumReplyCell")
            tableViewReplies.separatorStyle = .none
            tableViewReplies.isScrollEnabled = false
            tableViewReplies.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(tableViewReplies)
        }
        
        func setupReplyInput() {
            replyInputContainer = UIView()
            replyInputContainer.backgroundColor = .white
            replyInputContainer.layer.borderWidth = 1
            replyInputContainer.layer.borderColor = UIColor.systemGray5.cgColor
            replyInputContainer.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(replyInputContainer)
            
            cameraButton = UIButton(type: .system)
            cameraButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
            cameraButton.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            cameraButton.translatesAutoresizingMaskIntoConstraints = false
            replyInputContainer.addSubview(cameraButton)
            
            replyTextField = UITextField()
            replyTextField.placeholder = "Write a reply..."
            replyTextField.font = UIFont.systemFont(ofSize: 15)
            replyTextField.borderStyle = .roundedRect
            replyTextField.translatesAutoresizingMaskIntoConstraints = false
            replyInputContainer.addSubview(replyTextField)
            
            sendButton = UIButton(type: .system)
            sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
            sendButton.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            sendButton.translatesAutoresizingMaskIntoConstraints = false
            replyInputContainer.addSubview(sendButton)
        }
        
        func initConstraints() {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: replyInputContainer.topAnchor),
                
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                
                originalPostContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                originalPostContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                originalPostContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                opUserImageView.leadingAnchor.constraint(equalTo: originalPostContainer.leadingAnchor, constant: 12),
                opUserImageView.topAnchor.constraint(equalTo: originalPostContainer.topAnchor, constant: 12),
                opUserImageView.widthAnchor.constraint(equalToConstant: 40),
                opUserImageView.heightAnchor.constraint(equalToConstant: 40),
                
                opUserNameLabel.topAnchor.constraint(equalTo: originalPostContainer.topAnchor, constant: 12),
                opUserNameLabel.leadingAnchor.constraint(equalTo: opUserImageView.trailingAnchor, constant: 12),
                
                opTimestampLabel.topAnchor.constraint(equalTo: opUserNameLabel.bottomAnchor, constant: 2),
                opTimestampLabel.leadingAnchor.constraint(equalTo: opUserImageView.trailingAnchor, constant: 12),
                
                opTitleLabel.topAnchor.constraint(equalTo: opUserImageView.bottomAnchor, constant: 12),
                opTitleLabel.leadingAnchor.constraint(equalTo: originalPostContainer.leadingAnchor, constant: 12),
                opTitleLabel.trailingAnchor.constraint(equalTo: originalPostContainer.trailingAnchor, constant: -12),
                
                opContentLabel.topAnchor.constraint(equalTo: opTitleLabel.bottomAnchor, constant: 8),
                opContentLabel.leadingAnchor.constraint(equalTo: originalPostContainer.leadingAnchor, constant: 12),
                opContentLabel.trailingAnchor.constraint(equalTo: originalPostContainer.trailingAnchor, constant: -12),
                
                opAttachedImageView.topAnchor.constraint(equalTo: opContentLabel.bottomAnchor, constant: 12),
                opAttachedImageView.leadingAnchor.constraint(equalTo: originalPostContainer.leadingAnchor, constant: 12),
                opAttachedImageView.trailingAnchor.constraint(equalTo: originalPostContainer.trailingAnchor, constant: -12),
                opAttachedImageView.heightAnchor.constraint(equalToConstant: 150),
                opAttachedImageView.bottomAnchor.constraint(equalTo: originalPostContainer.bottomAnchor, constant: -12),
                
                repliesTitleLabel.topAnchor.constraint(equalTo: originalPostContainer.bottomAnchor, constant: 24),
                repliesTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                repliesTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                tableViewReplies.topAnchor.constraint(equalTo: repliesTitleLabel.bottomAnchor, constant: 12),
                tableViewReplies.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                tableViewReplies.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                tableViewReplies.heightAnchor.constraint(equalToConstant: 300), // Will adjust dynamically
                tableViewReplies.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                
                replyInputContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                replyInputContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                replyInputContainer.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                replyInputContainer.heightAnchor.constraint(equalToConstant: 60),
                
                cameraButton.leadingAnchor.constraint(equalTo: replyInputContainer.leadingAnchor, constant: 12),
                cameraButton.centerYAnchor.constraint(equalTo: replyInputContainer.centerYAnchor),
                cameraButton.widthAnchor.constraint(equalToConstant: 40),
                cameraButton.heightAnchor.constraint(equalToConstant: 40),
                
                replyTextField.leadingAnchor.constraint(equalTo: cameraButton.trailingAnchor, constant: 8),
                replyTextField.centerYAnchor.constraint(equalTo: replyInputContainer.centerYAnchor),
                replyTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
                replyTextField.heightAnchor.constraint(equalToConstant: 40),
                
                sendButton.trailingAnchor.constraint(equalTo: replyInputContainer.trailingAnchor, constant: -12),
                sendButton.centerYAnchor.constraint(equalTo: replyInputContainer.centerYAnchor),
                sendButton.widthAnchor.constraint(equalToConstant: 40),
                sendButton.heightAnchor.constraint(equalToConstant: 40),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
