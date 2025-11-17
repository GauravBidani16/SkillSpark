//
//  ForumThreadCell.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class ForumThreadCell: UITableViewCell {

    var wrapperView: UIView!
        var userImageView: UIImageView!
        var userNameLabel: UILabel!
        var timestampLabel: UILabel!
        var titleLabel: UILabel!
        var previewLabel: UILabel!
        var replyCountLabel: UILabel!
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupWrapperView()
            setupUserImageView()
            setupUserNameLabel()
            setupTimestampLabel()
            setupTitleLabel()
            setupPreviewLabel()
            setupReplyCountLabel()
            
            initConstraints()
        }
        
        func setupWrapperView() {
            wrapperView = UIView()
            wrapperView.backgroundColor = .white
            wrapperView.layer.cornerRadius = 12
            wrapperView.layer.borderWidth = 1
            wrapperView.layer.borderColor = UIColor.systemGray5.cgColor
            wrapperView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(wrapperView)
        }
        
        func setupUserImageView() {
            userImageView = UIImageView()
            userImageView.contentMode = .scaleAspectFill
            userImageView.clipsToBounds = true
            userImageView.layer.cornerRadius = 20
            userImageView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.2)
            userImageView.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            userImageView.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(userImageView)
        }
        
        func setupUserNameLabel() {
            userNameLabel = UILabel()
            userNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
            userNameLabel.textColor = .black
            userNameLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(userNameLabel)
        }
        
        func setupTimestampLabel() {
            timestampLabel = UILabel()
            timestampLabel.font = UIFont.systemFont(ofSize: 12)
            timestampLabel.textColor = .gray
            timestampLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(timestampLabel)
        }
        
        func setupTitleLabel() {
            titleLabel = UILabel()
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 2
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(titleLabel)
        }
        
        func setupPreviewLabel() {
            previewLabel = UILabel()
            previewLabel.font = UIFont.systemFont(ofSize: 14)
            previewLabel.textColor = .darkGray
            previewLabel.numberOfLines = 2
            previewLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(previewLabel)
        }
        
        func setupReplyCountLabel() {
            replyCountLabel = UILabel()
            replyCountLabel.font = UIFont.systemFont(ofSize: 13)
            replyCountLabel.textColor = .gray
            replyCountLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(replyCountLabel)
        }
        
        func initConstraints() {
            NSLayoutConstraint.activate([
                wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
                wrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                wrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
                
                userImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
                userImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 12),
                userImageView.widthAnchor.constraint(equalToConstant: 40),
                userImageView.heightAnchor.constraint(equalToConstant: 40),
                
                userNameLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 12),
                userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
                
                timestampLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 2),
                timestampLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
                
                titleLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
                titleLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
                
                previewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
                previewLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
                previewLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
                
                replyCountLabel.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 8),
                replyCountLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
                replyCountLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
                replyCountLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -12),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
