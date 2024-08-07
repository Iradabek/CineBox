//
//  HomeSectionHeadersView.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit
import SnapKit

class HomeSectionHeaderView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .primaryBlack
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
        backgroundColor = .header
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
