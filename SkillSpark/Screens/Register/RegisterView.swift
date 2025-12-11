//
//  RegisterView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/10/25.
//

import UIKit

class RegisterView: UIView {
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var confirmPasswordTextField: UITextField!
    
    var registerButton: UIButton!
    var loginButton: UIButton!
    
    var errorLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupTitleLabel()
        setupSubtitleLabel()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupErrorLabel()
        setupRegisterButton()
        setupLoginButton()
        
        initConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Create Account"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupSubtitleLabel() {
        subtitleLabel = UILabel()
        subtitleLabel.text = "Join SkillSpark and start learning"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subtitleLabel)
    }
    
    func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Full Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.autocapitalizationType = .words
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameTextField)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailTextField)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password (min 6 characters)"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
    }
    
    func setupConfirmPasswordTextField() {
        confirmPasswordTextField = UITextField()
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(confirmPasswordTextField)
    }
    
    func setupErrorLabel() {
        errorLabel = UILabel()
        errorLabel.text = ""
        errorLabel.font = UIFont.systemFont(ofSize: 14)
        errorLabel.textColor = .systemRed
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(errorLabel)
    }
    
    func setupRegisterButton() {
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        registerButton.layer.cornerRadius = 12
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Already have an account? Login", for: .normal)
        loginButton.setTitleColor(UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0), for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 16),
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            registerButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 24),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func hideError() {
        errorLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
