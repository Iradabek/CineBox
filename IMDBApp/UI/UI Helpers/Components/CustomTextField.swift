//
//  CustomTextField.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 04.07.24.
//

import UIKit

class CustomTextField: UIView {
    
    var textDidChange: ((String) -> Void)?
    
    private let verticalStackView: UIStackView = {
        let verticalStackView =  UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4
        return verticalStackView
    }()
    
    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.font = .systemFont(ofSize: 14, weight: .medium)
        return headerLabel
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .primaryWhite
        containerView.layer.cornerRadius = 12
        return containerView
    }()
    
    private let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .equalSpacing
        return horizontalStackView
    }()
    
    private lazy var customTextField: UITextField = {
        let customTextField = UITextField()
        customTextField.delegate = self
        customTextField.autocapitalizationType = UITextAutocapitalizationType.none
        customTextField.font = .systemFont(ofSize: 14, weight: .regular)
        customTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return customTextField
    }()
    
    private lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.isHidden = true
        rightImageView.tintColor = .gray
        rightImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility))
        rightImageView.addGestureRecognizer(tapGesture)
        return rightImageView
    }()
    
    private let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.isHidden = true
        errorLabel.textColor = .red
        errorLabel.textAlignment = .left
        errorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        return errorLabel
    }()
    
    private var isPasswordVisible: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(verticalStackView)
        addSubview(errorLabel)
        
        [headerLabel, containerView].forEach(verticalStackView.addArrangedSubview)
        containerView.addSubview(horizontalStackView)
        
        [customTextField, rightImageView].forEach(horizontalStackView.addArrangedSubview)
        
        verticalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.width.equalTo(28)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(verticalStackView.snp.bottom).offset(4)
            make.trailing.leading.equalToSuperview().inset(8)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        textDidChange?(textField.text ?? "")
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        customTextField.isSecureTextEntry = !isPasswordVisible
        rightImageView.image = UIImage(systemName: isPasswordVisible ? "eye" : "eye.slash")
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.containerView.addBorder(width: 1, color: .lightGray)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.containerView.layer.borderWidth = 0
        }
    }
}

extension CustomTextField {
    struct Item {
        let headerTitle: String
        let placeholder: String
        let rightImageName: String?
        let isSecureText: Bool
        let errorText: String?
        let text: String?
    }
    
    func configure(_ item: Item) {
        headerLabel.text = item.headerTitle
        customTextField.placeholder = item.placeholder
        customTextField.isSecureTextEntry = item.isSecureText
        customTextField.text = item.text
        errorLabel.text = item.errorText
        errorLabel.isHidden = item.errorText == nil
        containerView.layer.borderColor = item.errorText == nil ? UIColor.lightGray.cgColor : UIColor.red.cgColor
        
        if let rightImageName = item.rightImageName {
            rightImageView.isHidden = false
            rightImageView.image = UIImage(systemName: rightImageName)
        }
    }
    
    func updateError(_ errorText: String?) {
        errorLabel.text = errorText
        errorLabel.isHidden = errorText == nil
        containerView.layer.borderColor = errorText == nil ? UIColor.lightGray.cgColor : UIColor.red.cgColor
    }
}

