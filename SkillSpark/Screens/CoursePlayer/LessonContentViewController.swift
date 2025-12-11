//
//  LessonContentViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/10/25.
//

import UIKit

protocol LessonContentDelegate: AnyObject {
    func didUpdateLessonCompletion(lessonId: String, isCompleted: Bool)
}

class LessonContentViewController: UIViewController {
    
    let lessonContentView = LessonContentView()
    
    var courseId: String = ""
    var lesson: Lesson?
    var lessonNumber: Int = 1
    var sections: [LessonSection] = []
    var isCompleted: Bool = false
    
    weak var delegate: LessonContentDelegate?
    
    override func loadView() {
        view = lessonContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        
        lessonContentView.markCompleteButton.addTarget(self, action: #selector(onMarkCompleteButtonTapped), for: .touchUpInside)
        
        setupLessonHeader()
        updateCompletionButton()
        fetchLessonContent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    func setupLessonHeader() {
        guard let lesson = lesson else { return }
        
        lessonContentView.lessonNumberLabel.text = "LESSON \(lessonNumber)"
        lessonContentView.lessonTitleLabel.text = lesson.title
        lessonContentView.durationLabel.text = "\(lesson.duration)"
    }

    func fetchLessonContent() {
        guard let lessonId = lesson?.id else { return }
        
        lessonContentView.loadingIndicator.startAnimating()
        lessonContentView.emptyStateLabel.isHidden = true
        
        FirebaseManager.shared.fetchLessonSections(courseId: courseId, lessonId: lessonId) { [weak self] result in
            guard let self = self else { return }
            
            self.lessonContentView.loadingIndicator.stopAnimating()
            
            switch result {
            case .success(let sections):
                print("✅ Got \(sections.count) sections")
                self.sections = sections
                self.displaySections()
                
            case .failure(let error):
                print("❌ Error fetching sections: \(error.localizedDescription)")
                self.lessonContentView.emptyStateLabel.isHidden = false
            }
        }
    }
    
    func displaySections() {
        lessonContentView.clearSections()
        
        if sections.isEmpty {
            lessonContentView.emptyStateLabel.isHidden = false
            return
        }
        
        lessonContentView.emptyStateLabel.isHidden = true
        
        for section in sections {
            lessonContentView.addSection(heading: section.heading, paragraphs: section.paragraphs)
        }
    }
    
    func updateCompletionButton() {
        lessonContentView.updateButtonForCompletion(isCompleted: isCompleted)
    }
    
    @objc func onMarkCompleteButtonTapped() {
        guard let lessonId = lesson?.id else { return }
        
        isCompleted.toggle()
        updateCompletionButton()
        
        delegate?.didUpdateLessonCompletion(lessonId: lessonId, isCompleted: isCompleted)
        
        let message = isCompleted ? "Lesson marked as complete!" : "Lesson marked as incomplete"
        showToast(message: message)
    }
    
    func showToast(message: String) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toastLabel)
        
        NSLayoutConstraint.activate([
            toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastLabel.bottomAnchor.constraint(equalTo: lessonContentView.bottomContainerView.topAnchor, constant: -20),
            toastLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            toastLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        toastLabel.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        UIView.animate(withDuration: 0.3, delay: 1.5, options: .curveEaseOut) {
            toastLabel.alpha = 0
        } completion: { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
