//
//  RegisterViewController.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/10/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        registerView.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
        registerView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func onRegisterButtonTapped() {
        registerView.hideError()
        
        guard let name = registerView.nameTextField.text, !name.isEmpty else {
            registerView.showError("Please enter your name")
            return
        }
        
        guard let email = registerView.emailTextField.text, !email.isEmpty else {
            registerView.showError("Please enter your email")
            return
        }
        
        guard isValidEmail(email) else {
            registerView.showError("Please enter a valid email")
            return
        }
        
        guard let password = registerView.passwordTextField.text, !password.isEmpty else {
            registerView.showError("Please enter a password")
            return
        }
        
        guard password.count >= 6 else {
            registerView.showError("Password must be at least 6 characters")
            return
        }
        
        guard let confirmPassword = registerView.confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            registerView.showError("Please confirm your password")
            return
        }
        
        guard password == confirmPassword else {
            registerView.showError("Passwords do not match")
            return
        }
        
        registerView.registerButton.isEnabled = false
        registerView.registerButton.setTitle("Creating account...", for: .normal)
        
        FirebaseManager.shared.registerUser(name: name, email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            self.registerView.registerButton.isEnabled = true
            self.registerView.registerButton.setTitle("Register", for: .normal)
            
            switch result {
            case .success(let user):
                self.navigateToMainApp()
                
            case .failure(let error):
                self.registerView.showError(error.localizedDescription)
            }
        }
    }
    
    @objc func onLoginButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
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
