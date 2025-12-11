//
//  LessonContentView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/10/25.
//

import UIKit

class LessonContentView: UIView {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var headerView: UIView!
    var lessonNumberLabel: UILabel!
    var lessonTitleLabel: UILabel!
    var durationLabel: UILabel!
    
    var sectionsStackView: UIStackView!
    
    var bottomContainerView: UIView!
    var markCompleteButton: UIButton!
    
    var loadingIndicator: UIActivityIndicatorView!
    var emptyStateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupScrollView()
        setupHeaderView()
        setupSectionsStackView()
        setupBottomContainer()
        setupLoadingIndicator()
        setupEmptyStateLabel()
        
        initConstraints()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    func setupHeaderView() {
        headerView = UIView()
        headerView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerView)
        
        lessonNumberLabel = UILabel()
        lessonNumberLabel.font = UIFont.boldSystemFont(ofSize: 16)
        lessonNumberLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        lessonNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(lessonNumberLabel)
        
        lessonTitleLabel = UILabel()
        lessonTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        lessonTitleLabel.textColor = .white
        lessonTitleLabel.numberOfLines = 0
        lessonTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(lessonTitleLabel)
        
        durationLabel = UILabel()
        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(durationLabel)
    }
    
    func setupSectionsStackView() {
        sectionsStackView = UIStackView()
        sectionsStackView.axis = .vertical
        sectionsStackView.spacing = 24
        sectionsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sectionsStackView)
    }
    
    func setupBottomContainer() {
        bottomContainerView = UIView()
        bottomContainerView.backgroundColor = .white
        bottomContainerView.layer.shadowColor = UIColor.black.cgColor
        bottomContainerView.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomContainerView.layer.shadowRadius = 4
        bottomContainerView.layer.shadowOpacity = 0.1
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomContainerView)
        
        markCompleteButton = UIButton(type: .system)
        markCompleteButton.setTitle("Mark as Complete", for: .normal)
        markCompleteButton.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        markCompleteButton.setTitleColor(.white, for: .normal)
        markCompleteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        markCompleteButton.layer.cornerRadius = 12
        markCompleteButton.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.addSubview(markCompleteButton)
    }
    
    func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loadingIndicator)
    }
    
    func setupEmptyStateLabel() {
        emptyStateLabel = UILabel()
        emptyStateLabel.text = "No content available for this lesson yet."
        emptyStateLabel.font = UIFont.systemFont(ofSize: 16)
        emptyStateLabel.textColor = .gray
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.isHidden = true
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptyStateLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220),
            
            lessonNumberLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            lessonNumberLabel.bottomAnchor.constraint(equalTo: lessonTitleLabel.topAnchor, constant: -6),
            
            lessonTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            lessonTitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            lessonTitleLabel.bottomAnchor.constraint(equalTo: durationLabel.topAnchor, constant: -8),
            
            durationLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            durationLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            sectionsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            sectionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sectionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            sectionsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            bottomContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomContainerView.heightAnchor.constraint(equalToConstant: 100),
            
            markCompleteButton.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 16),
            markCompleteButton.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 20),
            markCompleteButton.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -20),
            markCompleteButton.heightAnchor.constraint(equalToConstant: 50),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            emptyStateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
        ])
    }
    
    func addSection(heading: String, paragraphs: [String]) {
        let sectionView = createSectionView(heading: heading, paragraphs: paragraphs)
        sectionsStackView.addArrangedSubview(sectionView)
    }
    
    func createSectionView(heading: String, paragraphs: [String]) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headingLabel = UILabel()
        headingLabel.text = heading
        headingLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headingLabel.textColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        headingLabel.numberOfLines = 0
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(headingLabel)
        
        let paragraphsStack = UIStackView()
        paragraphsStack.axis = .vertical
        paragraphsStack.spacing = 12
        paragraphsStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(paragraphsStack)
        
        for paragraph in paragraphs {
            let paragraphLabel = UILabel()
            paragraphLabel.text = paragraph
            paragraphLabel.font = UIFont.systemFont(ofSize: 16)
            paragraphLabel.textColor = .darkGray
            paragraphLabel.numberOfLines = 0
            paragraphsStack.addArrangedSubview(paragraphLabel)
        }
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            headingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            paragraphsStack.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 12),
            paragraphsStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            paragraphsStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            paragraphsStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
        return containerView
    }
    
    func clearSections() {
        sectionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func updateButtonForCompletion(isCompleted: Bool) {
        if isCompleted {
            markCompleteButton.setTitle("✓ Completed - Tap to Mark Incomplete", for: .normal)
            markCompleteButton.backgroundColor = .systemGreen
        } else {
            markCompleteButton.setTitle("Mark as Complete", for: .normal)
            markCompleteButton.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
