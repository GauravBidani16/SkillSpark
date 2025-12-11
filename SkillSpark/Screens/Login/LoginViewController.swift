//
//  LoginViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/10/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        loginView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func onLoginButtonTapped() {
        loginView.hideError()
        
        guard let email = loginView.emailTextField.text, !email.isEmpty else {
            loginView.showError("Please enter your email")
            return
        }
        
        guard let password = loginView.passwordTextField.text, !password.isEmpty else {
            loginView.showError("Please enter your password")
            return
        }
        
        loginView.loginButton.isEnabled = false
        loginView.loginButton.setTitle("Logging in...", for: .normal)
        
        FirebaseManager.shared.loginUser(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            self.loginView.loginButton.isEnabled = true
            self.loginView.loginButton.setTitle("Login", for: .normal)
            
            switch result {
            case .success(let user):
                self.navigateToMainApp()
                
            case .failure(let error):
                self.loginView.showError(error.localizedDescription)
            }
        }
    }
    
    @objc func onRegisterButtonTapped() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func navigateToMainApp() {
        let mainTabBar = MainTabBarController()
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = mainTabBar
            window.makeKeyAndVisible()
            
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }
}
