//
//  CourseDetailView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class CourseDetailView: UIView {

    var scrollView: UIScrollView!
        var contentView: UIView!
        
        var bannerImageView: UIImageView!
        var titleLabel: UILabel!
        var instructorLabel: UILabel!
        var ratingLabel: UILabel!
        var studentsLabel: UILabel!
        var durationLabel: UILabel!
        var priceLabel: UILabel!
        
        var descriptionTitleLabel: UILabel!
        var descriptionLabel: UILabel!
        
        var whatYouLearnTitleLabel: UILabel!
        var whatYouLearnStack: UIStackView!
        
        var courseSyllabusTitleLabel: UILabel!
        var syllabusStack: UIStackView!
        
        var enrollButton: UIButton!
        var forumButton: UIButton!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            
            setupScrollView()
            setupBannerImageView()
            setupTitleLabel()
            setupInstructorLabel()
            setupRatingLabel()
            setupStudentsLabel()
            setupDurationLabel()
            setupPriceLabel()
            setupDescriptionSection()
            setupWhatYouLearnSection()
            setupSyllabusSection()
            setupEnrollButton()
            setupForumButton()
            
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
        
        func setupBannerImageView() {
            bannerImageView = UIImageView()
            bannerImageView.contentMode = .scaleAspectFill
            bannerImageView.clipsToBounds = true
            bannerImageView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.3)
            bannerImageView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(bannerImageView)
        }
        
        func setupTitleLabel() {
            titleLabel = UILabel()
            titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 0
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLabel)
        }
        
        func setupInstructorLabel() {
            instructorLabel = UILabel()
            instructorLabel.font = UIFont.systemFont(ofSize: 15)
            instructorLabel.textColor = .gray
            instructorLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(instructorLabel)
        }
        
        func setupRatingLabel() {
            ratingLabel = UILabel()
            ratingLabel.font = UIFont.systemFont(ofSize: 14)
            ratingLabel.textColor = .darkGray
            ratingLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(ratingLabel)
        }
        
        func setupStudentsLabel() {
            studentsLabel = UILabel()
            studentsLabel.font = UIFont.systemFont(ofSize: 14)
            studentsLabel.textColor = .darkGray
            studentsLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(studentsLabel)
        }
        
        func setupDurationLabel() {
            durationLabel = UILabel()
            durationLabel.font = UIFont.systemFont(ofSize: 14)
            durationLabel.textColor = .darkGray
            durationLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(durationLabel)
        }
        
        func setupPriceLabel() {
            priceLabel = UILabel()
            priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
            priceLabel.textColor = .white
            priceLabel.textAlignment = .center
            priceLabel.layer.cornerRadius = 14
            priceLabel.clipsToBounds = true
            priceLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(priceLabel)
        }
        
        func setupDescriptionSection() {
            descriptionTitleLabel = UILabel()
            descriptionTitleLabel.text = "About This Course"
            descriptionTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            descriptionTitleLabel.textColor = .black
            descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(descriptionTitleLabel)
            
            descriptionLabel = UILabel()
            descriptionLabel.font = UIFont.systemFont(ofSize: 15)
            descriptionLabel.textColor = .darkGray
            descriptionLabel.numberOfLines = 0
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(descriptionLabel)
        }
        
        func setupWhatYouLearnSection() {
            whatYouLearnTitleLabel = UILabel()
            whatYouLearnTitleLabel.text = "What You'll Learn"
            whatYouLearnTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            whatYouLearnTitleLabel.textColor = .black
            whatYouLearnTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(whatYouLearnTitleLabel)
            
            whatYouLearnStack = UIStackView()
            whatYouLearnStack.axis = .vertical
            whatYouLearnStack.spacing = 8
            whatYouLearnStack.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(whatYouLearnStack)
        }
        
        func setupSyllabusSection() {
            courseSyllabusTitleLabel = UILabel()
            courseSyllabusTitleLabel.text = "Course Content"
            courseSyllabusTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            courseSyllabusTitleLabel.textColor = .black
            courseSyllabusTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(courseSyllabusTitleLabel)
            
            syllabusStack = UIStackView()
            syllabusStack.axis = .vertical
            syllabusStack.spacing = 8
            syllabusStack.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(syllabusStack)
        }
        
        func setupEnrollButton() {
            enrollButton = UIButton(type: .system)
            enrollButton.setTitle("Enroll Now", for: .normal)
            enrollButton.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            enrollButton.setTitleColor(.white, for: .normal)
            enrollButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            enrollButton.layer.cornerRadius = 12
            enrollButton.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(enrollButton)
        }
        
        func setupForumButton() {
            forumButton = UIButton(type: .system)
            forumButton.setTitle("💬 Join Discussion Forum", for: .normal)
            forumButton.backgroundColor = .white
            forumButton.setTitleColor(UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0), for: .normal)
            forumButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            forumButton.layer.cornerRadius = 12
            forumButton.layer.borderWidth = 2
            forumButton.layer.borderColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0).cgColor
            forumButton.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(forumButton)
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
                
                bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bannerImageView.heightAnchor.constraint(equalToConstant: 200),
                
                titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8),
                
                priceLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16),
                priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 70),
                priceLabel.heightAnchor.constraint(equalToConstant: 28),
                
                instructorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                instructorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                instructorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                ratingLabel.topAnchor.constraint(equalTo: instructorLabel.bottomAnchor, constant: 12),
                ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                
                studentsLabel.topAnchor.constraint(equalTo: instructorLabel.bottomAnchor, constant: 12),
                studentsLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 16),
                
                durationLabel.topAnchor.constraint(equalTo: instructorLabel.bottomAnchor, constant: 12),
                durationLabel.leadingAnchor.constraint(equalTo: studentsLabel.trailingAnchor, constant: 16),
                
                descriptionTitleLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 24),
                descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                whatYouLearnTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
                whatYouLearnTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                whatYouLearnTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                whatYouLearnStack.topAnchor.constraint(equalTo: whatYouLearnTitleLabel.bottomAnchor, constant: 12),
                whatYouLearnStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                whatYouLearnStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                courseSyllabusTitleLabel.topAnchor.constraint(equalTo: whatYouLearnStack.bottomAnchor, constant: 24),
                courseSyllabusTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                courseSyllabusTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                syllabusStack.topAnchor.constraint(equalTo: courseSyllabusTitleLabel.bottomAnchor, constant: 12),
                syllabusStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                syllabusStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                enrollButton.topAnchor.constraint(equalTo: syllabusStack.bottomAnchor, constant: 32),
                enrollButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                enrollButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                enrollButton.heightAnchor.constraint(equalToConstant: 50),
                
                forumButton.topAnchor.constraint(equalTo: enrollButton.bottomAnchor, constant: 12),
                forumButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                forumButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                forumButton.heightAnchor.constraint(equalToConstant: 50),
                forumButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            ])
        }
        
        func addLearningPoint(_ text: String) {
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            let checkmark = UILabel()
            checkmark.text = "Done"
            checkmark.font = UIFont.boldSystemFont(ofSize: 16)
            checkmark.textColor = .systemGreen
            checkmark.translatesAutoresizingMaskIntoConstraints = false
            
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = .darkGray
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(checkmark)
            containerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                checkmark.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                checkmark.topAnchor.constraint(equalTo: containerView.topAnchor),
                checkmark.widthAnchor.constraint(equalToConstant: 20),
                
                label.leadingAnchor.constraint(equalTo: checkmark.trailingAnchor, constant: 8),
                label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                label.topAnchor.constraint(equalTo: containerView.topAnchor),
                label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])
            
            whatYouLearnStack.addArrangedSubview(containerView)
        }
        
        func addSyllabusSection(title: String, lessons: String) {
            let containerView = UIView()
            containerView.backgroundColor = UIColor.systemGray6
            containerView.layer.cornerRadius = 8
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
            titleLabel.textColor = .black
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let lessonsLabel = UILabel()
            lessonsLabel.text = lessons
            lessonsLabel.font = UIFont.systemFont(ofSize: 13)
            lessonsLabel.textColor = .gray
            lessonsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(titleLabel)
            containerView.addSubview(lessonsLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                
                lessonsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                lessonsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
                lessonsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                lessonsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
                
                containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            ])
            
            syllabusStack.addArrangedSubview(containerView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
