//
//  ForumReplyCell.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class ForumReplyCell: UITableViewCell {

    var containerView: UIView!
        var userImageView: UIImageView!
        var userNameLabel: UILabel!
        var timestampLabel: UILabel!
        var replyLabel: UILabel!
        var attachedImageView: UIImageView!
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupContainerView()
            setupUserImageView()
            setupUserNameLabel()
            setupTimestampLabel()
            setupReplyLabel()
            setupAttachedImageView()
            
            initConstraints()
        }
        
        func setupContainerView() {
            containerView = UIView()
            containerView.backgroundColor = .white
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor.systemGray5.cgColor
            containerView.layer.cornerRadius = 10
            containerView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(containerView)
        }
        
        func setupUserImageView() {
            userImageView = UIImageView()
            userImageView.contentMode = .scaleAspectFill
            userImageView.clipsToBounds = true
            userImageView.layer.cornerRadius = 16
            userImageView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.2)
            userImageView.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            userImageView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(userImageView)
        }
        
        func setupUserNameLabel() {
            userNameLabel = UILabel()
            userNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
            userNameLabel.textColor = .black
            userNameLabel.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(userNameLabel)
        }
        
        func setupTimestampLabel() {
            timestampLabel = UILabel()
            timestampLabel.font = UIFont.systemFont(ofSize: 12)
            timestampLabel.textColor = .gray
            timestampLabel.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(timestampLabel)
        }
        
        func setupReplyLabel() {
            replyLabel = UILabel()
            replyLabel.font = UIFont.systemFont(ofSize: 15)
            replyLabel.textColor = .darkGray
            replyLabel.numberOfLines = 0
            replyLabel.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(replyLabel)
        }
        
        func setupAttachedImageView() {
            attachedImageView = UIImageView()
            attachedImageView.contentMode = .scaleAspectFill
            attachedImageView.clipsToBounds = true
            attachedImageView.layer.cornerRadius = 8
            attachedImageView.backgroundColor = UIColor.systemGray6
            attachedImageView.isHidden = true  // Hidden by default
            attachedImageView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(attachedImageView)
        }
        
        func initConstraints() {
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
                containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),

                userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
                userImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                userImageView.widthAnchor.constraint(equalToConstant: 32),
                userImageView.heightAnchor.constraint(equalToConstant: 32),
                
                userNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
                
                timestampLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                timestampLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 8),
                timestampLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -12),
                
                replyLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
                replyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
                replyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                
                attachedImageView.topAnchor.constraint(equalTo: replyLabel.bottomAnchor, constant: 8),
                attachedImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
                attachedImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                attachedImageView.heightAnchor.constraint(equalToConstant: 120),
                attachedImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -12),
            ])
        }
        
        func configureWithImage(_ hasImage: Bool) {
            if hasImage {
                attachedImageView.isHidden = false
                attachedImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
            } else {
                attachedImageView.isHidden = true
                replyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
