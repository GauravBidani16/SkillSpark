//
//  ForumViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit
import FirebaseFirestore

class ForumViewController: UIViewController {

    let forumView = ForumView()
    
    var courseId: String = ""
    var courseTitle: String = ""
    var threads: [ForumThread] = []
    var filteredThreads: [ForumThread] = []
    var listener: ListenerRegistration?
    var showAllThreads: Bool = false
    
    var courseNames: [String: String] = [:]
    var groupedThreads: [(courseName: String, courseId: String, threads: [ForumThread])] = []
    var isSearching: Bool = false
    
    override func loadView() {
        view = forumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discussion Forum"
        
        if courseId.isEmpty {
            showAllThreads = true
            forumView.courseTitleLabel.text = "All Discussions"
        } else {
            forumView.courseTitleLabel.text = courseTitle
        }
        
        forumView.tableViewThreads.delegate = self
        forumView.tableViewThreads.dataSource = self
        forumView.searchBar.delegate = self
        forumView.newThreadButton.addTarget(self, action: #selector(onNewThreadButtonTapped), for: .touchUpInside)
        
        if showAllThreads {
            forumView.newThreadButton.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showAllThreads {
            fetchAllEnrolledCoursesThreads()
        } else {
            startListeningToThreads()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
    }
    
    func fetchAllEnrolledCoursesThreads() {
        FirebaseManager.shared.fetchEnrollments { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let enrollments):
                if enrollments.isEmpty {
                    self.threads = []
                    self.filteredThreads = []
                    self.groupedThreads = []
                    self.forumView.emptyStateLabel.text = "No discussions yet.\nEnroll in courses to see their forums!"
                    self.updateUI()
                } else {
                    let courseIds = enrollments.map { $0.courseId }
                    self.fetchCourseNames(courseIds: courseIds) {
                        self.fetchThreadsForCourses(courseIds: courseIds)
                    }
                }
                
            case .failure(let error):
            }
        }
    }
    
    func fetchCourseNames(courseIds: [String], completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        for courseId in courseIds {
            group.enter()
            FirebaseManager.shared.fetchCourse(courseId: courseId) { [weak self] result in
                if case .success(let course) = result {
                    self?.courseNames[courseId] = course.title
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func fetchThreadsForCourses(courseIds: [String]) {
        let limitedCourseIds = Array(courseIds.prefix(10))
        
        listener = Firestore.firestore().collection("forumThreads")
            .whereField("courseId", in: limitedCourseIds)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.threads = []
                    self.filteredThreads = []
                    self.groupedThreads = []
                    self.updateUI()
                    return
                }
                
                var threads: [ForumThread] = []
                for document in documents {
                    do {
                        var thread = try document.data(as: ForumThread.self)
                        thread.id = document.documentID
                        threads.append(thread)
                    } catch {
                        print("Error decoding thread: \(error)")
                    }
                }
                
                self.threads = threads
                self.filteredThreads = threads
                self.groupThreadsByCourse()
                self.updateUI()
            }
    }
    
    func groupThreadsByCourse() {
        var grouped: [String: [ForumThread]] = [:]
        
        for thread in filteredThreads {
            if grouped[thread.courseId] != nil {
                grouped[thread.courseId]?.append(thread)
            } else {
                grouped[thread.courseId] = [thread]
            }
        }
        
        groupedThreads = grouped.map { (courseId, threads) in
            let courseName = courseNames[courseId] ?? "Unknown Course"
            return (courseName: courseName, courseId: courseId, threads: threads)
        }.sorted { $0.courseName < $1.courseName }
    }
    
    func startListeningToThreads() {
        guard !courseId.isEmpty else {
            return
        }
        
        listener = FirebaseManager.shared.listenToForumThreads(courseId: courseId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let threads):
                self.threads = threads
                self.filteredThreads = threads
                self.updateUI()
                
            case .failure(let error):
            }
        }
    }
    
    func updateUI() {
        let hasThreads: Bool
        if showAllThreads && !isSearching {
            hasThreads = !groupedThreads.isEmpty
        } else {
            hasThreads = !filteredThreads.isEmpty
        }
        
        forumView.emptyStateLabel.isHidden = hasThreads
        forumView.tableViewThreads.isHidden = !hasThreads
        forumView.tableViewThreads.reloadData()
    }
    
    @objc func onNewThreadButtonTapped() {
        let alert = UIAlertController(
            title: "New Discussion",
            message: "Start a new discussion thread",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "Title"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "What's on your mind?"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Post", style: .default) { _ in
            guard let title = alert.textFields?[0].text, !title.isEmpty,
                  let content = alert.textFields?[1].text, !content.isEmpty else {
                self.showErrorAlert(message: "Please fill in both fields")
                return
            }
            
            self.createThread(title: title, content: content)
        })
        
        present(alert, animated: true)
    }
    
    func createThread(title: String, content: String) {
        FirebaseManager.shared.createForumThread(courseId: courseId, title: title, content: content) { [weak self] result in
            switch result {
            case .success(let threadId):
                self?.listener?.remove()
                self?.startListeningToThreads()
                
            case .failure(let error):
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func formatTimestamp(_ timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        let now = Date()
        let diff = now.timeIntervalSince(date)
        
        if diff < 60 {
            return "Just now"
        } else if diff < 3600 {
            let mins = Int(diff / 60)
            return "\(mins) min ago"
        } else if diff < 86400 {
            let hours = Int(diff / 3600)
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        } else {
            let days = Int(diff / 86400)
            return "\(days) day\(days == 1 ? "" : "s") ago"
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ForumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if showAllThreads && !isSearching {
            return groupedThreads.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if showAllThreads && !isSearching {
            let group = groupedThreads[section]
            return "\(group.courseName) (\(group.threads.count))"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if showAllThreads && !isSearching {
            return 44
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if showAllThreads && !isSearching {
            let headerView = UIView()
            headerView.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 0.1)
            
            let label = UILabel()
            label.text = "\(groupedThreads[section].courseName)"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(label)
            
            let countLabel = UILabel()
            countLabel.text = "\(groupedThreads[section].threads.count) threads"
            countLabel.font = UIFont.systemFont(ofSize: 13)
            countLabel.textColor = .gray
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(countLabel)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                
                countLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                countLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            ])
            
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showAllThreads && !isSearching {
            return groupedThreads[section].threads.count
        }
        return filteredThreads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForumThreadCell", for: indexPath) as! ForumThreadCell
        
        let thread: ForumThread
        if showAllThreads && !isSearching {
            thread = groupedThreads[indexPath.section].threads[indexPath.row]
        } else {
            thread = filteredThreads[indexPath.row]
        }
        
        cell.userNameLabel.text = thread.userName
        cell.titleLabel.text = thread.title
        cell.previewLabel.text = thread.content
        cell.timestampLabel.text = formatTimestamp(thread.timestamp)
        cell.replyCountLabel.text = "\(thread.replyCount) replies"
        cell.userImageView.image = UIImage(systemName: "person.circle.fill")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let thread: ForumThread
        if showAllThreads && !isSearching {
            thread = groupedThreads[indexPath.section].threads[indexPath.row]
        } else {
            thread = filteredThreads[indexPath.row]
        }
        
        let forumThreadVC = ForumThreadViewController()
        forumThreadVC.thread = thread
        navigationController?.pushViewController(forumThreadVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension ForumViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredThreads = threads
            if showAllThreads {
                groupThreadsByCourse()
            }
        } else {
            isSearching = true
            filteredThreads = threads.filter { thread in
                thread.title.lowercased().contains(searchText.lowercased()) ||
                thread.content.lowercased().contains(searchText.lowercased()) ||
                thread.userName.lowercased().contains(searchText.lowercased())
            }
        }
        updateUI()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredThreads = threads
        if showAllThreads {
            groupThreadsByCourse()
        }
        updateUI()
        searchBar.resignFirstResponder()
    }
}
