//
//  LessonCell.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/9/25.
//

import UIKit

class LessonCell: UITableViewCell {
    
    var wrapperView: UIView!
    var lessonNumberLabel: UILabel!
    var titleLabel: UILabel!
    var durationLabel: UILabel!
    var checkmarkImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupWrapperView()
        setupLessonNumberLabel()
        setupTitleLabel()
        setupDurationLabel()
        setupCheckmarkImageView()
        
        initConstraints()
    }
    
    func setupWrapperView() {
        wrapperView = UIView()
        wrapperView.backgroundColor = .white
        wrapperView.layer.cornerRadius = 12
        wrapperView.layer.borderWidth = 1
        wrapperView.layer.borderColor = UIColor.systemGray5.cgColor
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wrapperView)
    }
    
    func setupLessonNumberLabel() {
        lessonNumberLabel = UILabel()
        lessonNumberLabel.font = UIFont.boldSystemFont(ofSize: 16)
        lessonNumberLabel.textColor = .white
        lessonNumberLabel.textAlignment = .center
        lessonNumberLabel.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        lessonNumberLabel.layer.cornerRadius = 16
        lessonNumberLabel.clipsToBounds = true
        lessonNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(lessonNumberLabel)
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(titleLabel)
    }
    
    func setupDurationLabel() {
        durationLabel = UILabel()
        durationLabel.font = UIFont.systemFont(ofSize: 13)
        durationLabel.textColor = .gray
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(durationLabel)
    }
    
    func setupCheckmarkImageView() {
        checkmarkImageView = UIImageView()
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.tintColor = .systemGreen
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(checkmarkImageView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            lessonNumberLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
            lessonNumberLabel.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            lessonNumberLabel.widthAnchor.constraint(equalToConstant: 32),
            lessonNumberLabel.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.leadingAnchor.constraint(equalTo: lessonNumberLabel.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: checkmarkImageView.leadingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 14),
            
            durationLabel.leadingAnchor.constraint(equalTo: lessonNumberLabel.trailingAnchor, constant: 12),
            durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            durationLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -14),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            checkmarkImageView.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 28),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    // MARK: - Configure Cell
    func configure(lessonNumber: Int, title: String, duration: String, isCompleted: Bool) {
        lessonNumberLabel.text = "\(lessonNumber)"
        titleLabel.text = title
        durationLabel.text = "\(duration)"
        
        if isCompleted {
            checkmarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
            checkmarkImageView.tintColor = .systemGreen
            wrapperView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.05)
            wrapperView.layer.borderColor = UIColor.systemGreen.withAlphaComponent(0.3).cgColor
            lessonNumberLabel.backgroundColor = .systemGreen
        } else {
            checkmarkImageView.image = UIImage(systemName: "circle")
            checkmarkImageView.tintColor = .systemGray3
            wrapperView.backgroundColor = .white
            wrapperView.layer.borderColor = UIColor.systemGray5.cgColor
            lessonNumberLabel.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
