//
//  LoginView.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/10/25.
//

import UIKit

class LoginView: UIView {
    
    var logoImageView: UIImageView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    var loginButton: UIButton!
    var registerButton: UIButton!
    
    var errorLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupLogoImageView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupErrorLabel()
        setupLoginButton()
        setupRegisterButton()
        
        initConstraints()
    }
    
    func setupLogoImageView() {
        logoImageView = UIImageView()
        logoImageView.image = UIImage(systemName: "sparkles")
        logoImageView.tintColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoImageView)
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "SkillSpark"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupSubtitleLabel() {
        subtitleLabel = UILabel()
        subtitleLabel.text = "Learn Together, Grow Together"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subtitleLabel)
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
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
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
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 12
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }
    
    func setupRegisterButton() {
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Don't have an account? Register", for: .normal)
        registerButton.setTitleColor(UIColor(red: 102/255, green: 126/255, blue: 234/255, alpha: 1.0), for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 48),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            loginButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
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
