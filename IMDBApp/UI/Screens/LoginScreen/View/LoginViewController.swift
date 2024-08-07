//
//  LoginViewController.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 04.07.24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let vm = LoginViewModel()
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
        label.text = "Sign in"
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 32
        return sv
    }()
    
    private let emailTextField = CustomTextField()
    private let passwordTextField = CustomTextField()
    
    private func configureEmailTextField() {
        emailTextField.configure(.init(headerTitle: "Email", placeholder: "Email", rightImageName: nil, isSecureText: false, errorText: vm.emailError, text: vm.emailText))
        
        emailTextField.textDidChange = { [weak self] text in
            self?.vm.emailText = text
            self?.emailTextField.updateError(self?.vm.emailError)
        }
    }
    
    private func configurePasswordTextField() {
        passwordTextField.configure(.init(headerTitle: "Password", placeholder: "Password", rightImageName: "eye.slash", isSecureText: true, errorText: vm.passwordError, text: vm.passwordText))
        
        passwordTextField.textDidChange = { [weak self] text in
            self?.vm.passwordText = text
            self?.passwordTextField.updateError(self?.vm.passwordError)
        }
    }
    
    private let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 32
        return sv
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton()
        button.configure(.init(title: "Login", titleColor: .black, backgroundColor: .primaryYellow))
        button.customButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private let seperatorLineView: CustomLineView = {
        let lineView = CustomLineView()
        lineView.configure(.init(text: "New to IMDb?"))
        return lineView
    }()
    
    private lazy var createAccountButton: CustomButton = {
        let button = CustomButton()
        button.configure(.init(title: "Create Account", titleColor: .primaryWhite, backgroundColor: .primaryBlack))
        button.customButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primarySurface
        navigationController?.isNavigationBarHidden = true
        setupUI()
        handleLoginError()
    }
    
    private func setupUI() {
        configureEmailTextField()
        configurePasswordTextField()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(buttonStackView)
        view.addSubview(activityIndicatorView)
        
        [emailTextField,
         passwordTextField
        ].forEach(verticalStackView.addArrangedSubview)
        
        [loginButton,
         seperatorLineView,
         createAccountButton
        ].forEach(buttonStackView.addArrangedSubview)
        
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
            make.top.equalTo(verticalStackView.snp.bottom).offset(48)
            make.trailing.leading.equalToSuperview().inset(20)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(24)
        }
        
        activityIndicatorView.snp.makeConstraints { make in
              make.edges.equalToSuperview()
          }
          activityIndicatorView.hide()
      
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func handleLoginError() {
        vm.onEmailErrorChange = { [weak self] error in
            self?.activityIndicatorView.hide()
            self?.emailTextField.updateError(error)
        }
        
        vm.onPasswordErrorChange = { [weak self] error in
            self?.activityIndicatorView.hide()
            self?.passwordTextField.updateError(error)
        }
        
        vm.onLoginSuccess = { [weak self] in
             self?.activityIndicatorView.hide()
             let tabBarVC = TabBarController()
             self?.navigationController?.setViewControllers([tabBarVC], animated: true)
         }
         
         vm.onLoginFailure = { [weak self] error in
             self?.activityIndicatorView.hide()
             self?.showAlert(title: "Error occurred", message: error)
         }
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func didTapLoginButton() {
        activityIndicatorView.show()
        vm.loginUser()
    }

    @objc
    private func didTapRegisterButton() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
