//
//  ProfileSectionHeadersView.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 03.07.24.
//

import UIKit
import SnapKit

class ProfileSectionHeadersView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .title
        label.textAlignment = .left
        return label
    }()
    
    init(title: String?) {
        super.init(frame: .zero)
        setupUI()
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        backgroundColor = .clear
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
}
