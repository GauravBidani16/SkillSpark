//
//  CourseTableViewCell.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class CourseTableViewCell: UITableViewCell {
    
    var wrapperView: UIView!
        var courseImageView: UIImageView!
        var titleLabel: UILabel!
        var descriptionLabel: UILabel!
        var instructorLabel: UILabel!
        var priceLabel: UILabel!
        var ratingLabel: UILabel!
        var studentsLabel: UILabel!
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupWrapperView()
            setupCourseImageView()
            setupTitleLabel()
            setupDescriptionLabel()
            setupInstructorLabel()
            setupPriceLabel()
            setupRatingLabel()
            setupStudentsLabel()
            
            initConstraints()
        }
        
        func setupWrapperView() {
            wrapperView = UIView()
            wrapperView.backgroundColor = .white
            wrapperView.layer.cornerRadius = 12
            wrapperView.layer.shadowColor = UIColor.gray.cgColor
            wrapperView.layer.shadowOffset = CGSize(width: 0, height: 2)
            wrapperView.layer.shadowRadius = 4.0
            wrapperView.layer.shadowOpacity = 0.2
            wrapperView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(wrapperView)
        }
        
        func setupCourseImageView() {
            courseImageView = UIImageView()
            courseImageView.contentMode = .scaleAspectFit
            courseImageView.clipsToBounds = true
            courseImageView.layer.cornerRadius = 8
            courseImageView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.1)
            courseImageView.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            courseImageView.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(courseImageView)
        }
        
        func setupTitleLabel() {
            titleLabel = UILabel()
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            titleLabel.textColor = .black
            titleLabel.numberOfLines = 2
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(titleLabel)
        }
        
        func setupDescriptionLabel() {
            descriptionLabel = UILabel()
            descriptionLabel.font = UIFont.systemFont(ofSize: 14)
            descriptionLabel.textColor = .darkGray
            descriptionLabel.numberOfLines = 2
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(descriptionLabel)
        }
        
        func setupInstructorLabel() {
            instructorLabel = UILabel()
            instructorLabel.font = UIFont.systemFont(ofSize: 13)
            instructorLabel.textColor = .gray
            instructorLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(instructorLabel)
        }
        
        func setupPriceLabel() {
            priceLabel = UILabel()
            priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
            priceLabel.textColor = .white
            priceLabel.textAlignment = .center
            priceLabel.layer.cornerRadius = 12
            priceLabel.clipsToBounds = true
            priceLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(priceLabel)
        }
        
        func setupRatingLabel() {
            ratingLabel = UILabel()
            ratingLabel.font = UIFont.systemFont(ofSize: 12)
            ratingLabel.textColor = .gray
            ratingLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(ratingLabel)
        }
        
        func setupStudentsLabel() {
            studentsLabel = UILabel()
            studentsLabel.font = UIFont.systemFont(ofSize: 12)
            studentsLabel.textColor = .gray
            studentsLabel.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(studentsLabel)
        }
        
        func initConstraints() {
            NSLayoutConstraint.activate([
                wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
                wrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                wrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
                
                courseImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 12),
                courseImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 12),
                courseImageView.widthAnchor.constraint(equalToConstant: 70),
                courseImageView.heightAnchor.constraint(equalToConstant: 70),
                
                priceLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 12),
                priceLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
                priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
                priceLabel.heightAnchor.constraint(equalToConstant: 24),
                
                titleLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 12),
                titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8),
                
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                descriptionLabel.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 12),
                descriptionLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -12),
                
                instructorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
                instructorLabel.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 12),
                
                ratingLabel.topAnchor.constraint(equalTo: instructorLabel.bottomAnchor, constant: 4),
                ratingLabel.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 12),
                ratingLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -12),
                
                studentsLabel.topAnchor.constraint(equalTo: instructorLabel.bottomAnchor, constant: 4),
                studentsLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 12),
                studentsLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -12),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
