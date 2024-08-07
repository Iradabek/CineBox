//
//  AccountSettingsTableViewCell.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 03.07.24.
//

import UIKit

class AccountSettingsTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .primaryWhite
        return cv
    }()
       
    private let horizontalStackview: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        sv.distribution = .fillProportionally
        sv.alignment = .center
        return sv
    }()
    
    private let leftImageView: UIImageView = {
        let iv = UIImageView()
        iv.isHidden = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let rightImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private let customSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.1)
        return view
    }()
    
    private let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isHidden = true
        return switchControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        backgroundColor = .clear
    }
    
    func makeItTop() {
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 12
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func makeItBottom() {
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 12
        containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(horizontalStackview)
        [leftImageView, titleLabel, rightImageView, switchControl].forEach(horizontalStackview.addArrangedSubview)
        contentView.addSubview(customSeparator)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
        
        horizontalStackview.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.size.equalTo(42)
        }
        
        switchControl.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 51, height: 31))
        }
        
        customSeparator.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
            make.top.equalTo(containerView.snp.bottom)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var switchAction: ((Bool) -> Void)?
    
    @objc private func switchChanged(_ sender: UISwitch) {
        switchAction?(sender.isOn)
    }
    
    func configure(_ item: Item, switchAction: ((Bool) -> Void)? = nil) {
        titleLabel.text = item.titleText
        rightImageView.image = UIImage(named: item.rightImage ?? "")
        switchControl.isHidden = !(item.titleText == "App Mode")
        
        if item.titleText == "App Mode" {
            switchControl.isOn = traitCollection.userInterfaceStyle == .dark
            switchControl.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
            self.switchAction = switchAction
        }
        
        if item.leftImage != nil {
            leftImageView.isHidden = false
            leftImageView.image = UIImage(named: item.leftImage ?? "")
        }
        customSeparator.isHidden = item.isHideSeperator ?? false
        contentView.isUserInteractionEnabled = item.titleText == "App Mode" ? true : false
    }
}

extension AccountSettingsTableViewCell {
    struct Item {
        var titleText: String
        var rightImage: String?
        var leftImage: String?
        var isHideSeperator: Bool?
    }
}

