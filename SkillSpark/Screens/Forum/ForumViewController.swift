//
//  ForumViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class ForumViewController: UIViewController {

    let forumView = ForumView()
        
        let threads = [
            ("John Doe", "Having trouble with Auto Layout constraints", "Can someone explain how to center a view using constraints?", "8 replies", "2 hours ago"),
            ("Sarah M", "Best practices for organizing Swift code?", "What's your preferred project structure for medium-sized apps?", "15 replies", "5 hours ago"),
            ("Mike Chen", "Xcode simulator keeps crashing", "Anyone else experiencing this issue with Xcode 15?", "3 replies", "1 day ago"),
        ]
        
        override func loadView() {
            view = forumView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Discussion Forum"
            
            forumView.tableViewThreads.delegate = self
            forumView.tableViewThreads.dataSource = self
            
            forumView.newThreadButton.addTarget(self, action: #selector(onNewThreadButtonTapped), for: .touchUpInside)
        }
        
        @objc func onNewThreadButtonTapped() {
            let alert = UIAlertController(
                title: "New Discussion",
                message: "Create a new discussion thread (feature coming soon)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    extension ForumViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let count = threads.count
            
            forumView.emptyStateLabel.isHidden = (count > 0)
            forumView.tableViewThreads.isHidden = (count == 0)
            
            return count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForumThreadCell", for: indexPath) as! ForumThreadCell
            
            let thread = threads[indexPath.row]
            cell.userNameLabel.text = thread.0
            cell.titleLabel.text = thread.1
            cell.previewLabel.text = thread.2
            cell.replyCountLabel.text = "\(thread.3)  •  \(thread.4)"
            cell.timestampLabel.text = thread.4
            cell.userImageView.image = UIImage(systemName: "person.circle.fill")
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let forumThreadVC = ForumThreadViewController()
            navigationController?.pushViewController(forumThreadVC, animated: true)
        }
}
