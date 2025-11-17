//
//  MainTabBarController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 11/17/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
            setupTabs()
            customizeTabBar()
        }
        
        func setupTabs() {
            let homeVC = HomeViewController()
            let homeNav = UINavigationController(rootViewController: homeVC)
            homeNav.tabBarItem = UITabBarItem(
                title: "Home",
                image: UIImage(systemName: "house"),
                selectedImage: UIImage(systemName: "house.fill")
            )
            
            let myCoursesVC = MyCoursesViewController()
            let myCoursesNav = UINavigationController(rootViewController: myCoursesVC)
            myCoursesNav.tabBarItem = UITabBarItem(
                title: "My Courses",
                image: UIImage(systemName: "book"),
                selectedImage: UIImage(systemName: "book.fill")
            )
            
            let forumVC = ForumViewController()
            let forumNav = UINavigationController(rootViewController: forumVC)
            forumNav.tabBarItem = UITabBarItem(
                title: "Forums",
                image: UIImage(systemName: "message"),
                selectedImage: UIImage(systemName: "message.fill")
            )
            
            let profileVC = ProfileViewController()
            let profileNav = UINavigationController(rootViewController: profileVC)
            profileNav.tabBarItem = UITabBarItem(
                title: "Profile",
                image: UIImage(systemName: "person"),
                selectedImage: UIImage(systemName: "person.fill")
            )
            
            viewControllers = [homeNav, myCoursesNav, forumNav, profileNav]
        }
        
        func customizeTabBar() {
            tabBar.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
            tabBar.backgroundColor = .white
            tabBar.isTranslucent = false
        }
}
