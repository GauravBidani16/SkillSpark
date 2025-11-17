//
//  ForumView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class ForumView: UIView {

    var headerView: UIView!
        var courseTitleLabel: UILabel!
        var searchBar: UISearchBar!
        var tableViewThreads: UITableView!
        var newThreadButton: UIButton!
        var emptyStateLabel: UILabel!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            
            setupHeaderView()
            setupCourseTitleLabel()
            setupSearchBar()
            setupTableView()
            setupNewThreadButton()
            setupEmptyStateLabel()
            
            initConstraints()
        }
        
        func setupHeaderView() {
            headerView = UIView()
            headerView.backgroundColor = .white
            headerView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(headerView)
        }
        
        func setupCourseTitleLabel() {
            courseTitleLabel = UILabel()
            courseTitleLabel.text = "iOS Development Basics"
            courseTitleLabel.font = UIFont.systemFont(ofSize: 14)
            courseTitleLabel.textColor = .gray
            courseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(courseTitleLabel)
        }
        
        func setupSearchBar() {
            searchBar = UISearchBar()
            searchBar.placeholder = "Search discussions..."
            searchBar.searchBarStyle = .minimal
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(searchBar)
        }
        
        func setupTableView() {
            tableViewThreads = UITableView()
            tableViewThreads.register(ForumThreadCell.self, forCellReuseIdentifier: "ForumThreadCell")
            tableViewThreads.separatorStyle = .none
            tableViewThreads.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(tableViewThreads)
        }
        
        func setupNewThreadButton() {
            newThreadButton = UIButton(type: .system)
            newThreadButton.setTitle("New Discussion Thread", for: .normal)
            newThreadButton.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            newThreadButton.setTitleColor(.white, for: .normal)
            newThreadButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            newThreadButton.layer.cornerRadius = 12
            newThreadButton.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(newThreadButton)
        }
        
        func setupEmptyStateLabel() {
            emptyStateLabel = UILabel()
            emptyStateLabel.text = "No discussions yet.\nBe the first to start a conversation!"
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
                headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                
                courseTitleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
                courseTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                courseTitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                
                searchBar.topAnchor.constraint(equalTo: courseTitleLabel.bottomAnchor, constant: 4),
                searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                searchBar.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
                
                tableViewThreads.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
                tableViewThreads.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                tableViewThreads.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tableViewThreads.bottomAnchor.constraint(equalTo: newThreadButton.topAnchor, constant: -8),
                
                newThreadButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                newThreadButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                newThreadButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                newThreadButton.heightAnchor.constraint(equalToConstant: 50),
                
                emptyStateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                emptyStateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                emptyStateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
                emptyStateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
