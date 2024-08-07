//
//  EmptyWatchListView.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 13.07.24.
//

import UIKit

class EmptyWatchListView: UIView {
    
    private let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 12
        return sv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "emptyList")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLable: UILabel = {
        let label =  UILabel()
        label.text = "Your watchlist is empty"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .primarySurface
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        addSubview(verticalStackView)
        [imageView, titleLable].forEach(verticalStackView.addArrangedSubview)
        
        verticalStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(120)
        }
    }
}
