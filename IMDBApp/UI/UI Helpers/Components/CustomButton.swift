//
//  CustomButton.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 04.07.24.
//

import UIKit

class CustomButton: UIView {
    
    
    let customButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        addSubview(customButton)
        
        customButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(48)
        }
    }
}

extension CustomButton {
    struct Item {
        let title: String
        let titleColor: UIColor?
        let backgroundColor: UIColor?
    }
    
    func configure(_ item: Item) {
        customButton.setTitle(item.title, for: .normal)
        customButton.setTitleColor(item.titleColor, for: .normal)
        customButton.backgroundColor = item.backgroundColor
    }
}
