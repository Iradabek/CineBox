//
//  CustomNavigationBar.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 13.07.24.
//

import UIKit

protocol CustomNavigationBarDelegate: AnyObject {
    func didTapBackButton()
}

class CustomNavigationBarView: UIView {
    
    weak var delegate: CustomNavigationBarDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    private let leftTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.isHidden = true
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)
        addSubview(titleLabel)
        [backButton, leftTitle, UIView()].forEach(stackView.addArrangedSubview)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomNavigationBarView {
    
    struct Item {
        let leftTitleText: String?
        let titleText: String?
        let isHideButton: Bool?
    }
    
    func configure(_ item: Item) {
        if item.leftTitleText != nil {
            leftTitle.text = item.leftTitleText
            leftTitle.isHidden = false
        }
        backButton.isHidden = item.isHideButton ?? true
        
        titleLabel.text = item.titleText
    }
    
    @objc
    func didTapBackButton() {
        delegate?.didTapBackButton()
    }
}
