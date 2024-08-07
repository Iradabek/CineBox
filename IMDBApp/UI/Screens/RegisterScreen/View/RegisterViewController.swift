//
//  RegisterViewController.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 04.07.24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let vm = RegisterViewModel()
    let activityIndicatorView = ActivityIndicatorView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.text = "Sign Up"
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 32
        return sv
    }()
    
    private let usernameTextField = CustomTextField()
    private let emailTextField = CustomTextField()
    private let passwordTextField = CustomTextField()
    private let confirmPasswordTextField = CustomTextField()
    
    private func configureUsernameTextField() {
        usernameTextField.configure(.init(headerTitle: "Username", placeholder: "Username", rightImageName: nil, isSecureText: false, errorText: vm.usernameError, text: vm.usernameText))
        usernameTextField.textDidChange = { [weak self] text in
            self?.vm.usernameText = text
        }
    }
    
    private func configureEmailTextField() {
        emailTextField.configure(.init(headerTitle: "Email", placeholder: "Email", rightImageName: nil, isSecureText: false, errorText: vm.emailError, text: vm.emailText))
        emailTextField.textDidChange = { [weak self] text in
            self?.vm.emailText = text
        }
    }
    
    private func configurePasswordTextField() {
        passwordTextField.configure(.init(headerTitle: "Password", placeholder: "Password", rightImageName: "eye.slash", isSecureText: true, errorText: vm.passwordError, text: vm.passwordText))
        passwordTextField.textDidChange = { [weak self] text in
            self?.vm.passwordText = text
        }
    }
    
    private func configureConfirmPasswordTextField() {
        confirmPasswordTextField.configure(.init(headerTitle: "Confirm Password", placeholder: "Confirm Password", rightImageName: "eye.slash", isSecureText: true, errorText: vm.confirmPasswordError, text: vm.confirmPasswordText))
        confirmPasswordTextField.textDidChange = { [weak self] text in
            self?.vm.confirmPasswordText = text
        }
    }
    
    private let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 32
        return sv
    }()
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton()
        button.configure(.init(title: "Create Account", titleColor: .black, backgroundColor: .primaryYellow))
        button.customButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private let seperatorLineView: CustomLineView = {
        let lineView = CustomLineView()
        lineView.configure(.init(text: "Already have an Account?"))
        return lineView
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton()
        button.configure(.init(title: "Login", titleColor: .primaryWhite, backgroundColor: .primaryBlack))
        button.customButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primarySurface
        navigationController?.isNavigationBarHidden = true
        setupUI()
        handleRegisterError()
    }
    
    private func setupUI() {
        configureUsernameTextField()
        configureEmailTextField()
        configurePasswordTextField()
        configureConfirmPasswordTextField()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(activityIndicatorView)
        
        [titleLabel, verticalStackView, buttonStackView].forEach(contentView.addSubview)
     
        [usernameTextField, emailTextField, passwordTextField, confirmPasswordTextField].forEach(verticalStackView.addArrangedSubview)
        
        [registerButton, seperatorLineView, loginButton].forEach(buttonStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.trailing.leading.equalToSuperview().inset(20)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(verticalStackView.snp.bottom).offset(32)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.trailing.leading.equalToSuperview().inset(20)
        }
        
        activityIndicatorView.snp.makeConstraints { make in
              make.edges.equalToSuperview()
          }
          activityIndicatorView.hide()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func handleRegisterError() {
        vm.onUsernameErrorChange = { [weak self] error in
            self?.activityIndicatorView.hide()
            self?.usernameTextField.updateError(error)
        }
        
        vm.onEmailErrorChange = { [weak self] error in
            self?.activityIndicatorView.hide()
            self?.emailTextField.updateError(error)
        }
        
        vm.onPasswordErrorChange = { [weak self] error in
            self?.activityIndicatorView.hide()
            self?.passwordTextField.updateError(error)
        }
        
        vm.onConfirmPasswordErrorChange = { [weak self] error in
            self?.activityIndicatorView.hide()
            self?.confirmPasswordTextField.updateError(error)
        }
        
        vm.onRegistrationSuccess = { [weak self] in
             self?.activityIndicatorView.hide()
             let tabBarVC = TabBarController()
             self?.navigationController?.setViewControllers([tabBarVC], animated: true)
         }
         
         vm.onRegistrationFailure = { [weak self] error in
             self?.activityIndicatorView.hide()
             self?.showAlert(title: "Error occurred", message: error)
         }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func didTapRegisterButton() {
        self.activityIndicatorView.show()
        vm.registerUser()
    }
    
    @objc
    private func didTapLoginButton() {
        navigationController?.popViewController(animated: true)
    }
}
