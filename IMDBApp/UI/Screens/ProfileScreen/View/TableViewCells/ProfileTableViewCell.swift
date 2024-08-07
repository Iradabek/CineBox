//
//  ProfileTableViewCell.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 03.07.24.
//

import UIKit
import FirebaseAuth

class ProfileTableViewCell: UITableViewCell {
    
    private let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .primarySurface
        return view
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image =  UIImage(named: "profilePhoto")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 50
        iv.addBorder(width: 1, color: .lightGray)
        return iv
    }()
    
    private let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        sv.alignment = .center
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .title
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(profileView)
        profileView.addSubview(profileImageView)
        profileView.addSubview(verticalStackView)
        [fullNameLabel, emailLabel].forEach(verticalStackView.addArrangedSubview)
        
        
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.top).offset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualTo(profileView.snp.bottom).offset(-16)
        }
    }
    
    func configure(with username: String, email: String, profileImageName: String) {
        fullNameLabel.text = username
        emailLabel.text = email
        profileImageView.image = UIImage(named: profileImageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

