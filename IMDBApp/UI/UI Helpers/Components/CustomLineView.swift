//
//  CustomLineView.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 04.07.24.
//

import UIKit

class CustomLineView: UIView {
    
    private let lineView: UIView = {
        let lv = UIView()
        lv.backgroundColor = .primaryYellow
        return lv
    }()
    
    private let containerView: UIView = {
        let lv = UIView()
        lv.backgroundColor = .primarySurface
        return lv
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp() {
        addSubview(lineView)
        addSubview(containerView)
        containerView.addSubview(textLabel)
        
        lineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(lineView)
            make.centerY.equalTo(lineView)
            make.height.equalTo(40)
            make.width.greaterThanOrEqualTo(50)
        }
        
        textLabel.snp.makeConstraints { make in
            make.edges.equalTo(containerView).inset(12)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomLineView {
    struct Item {
        let text: String
    }
    
    func configure(_ item: Item) {
        textLabel.text = item.text
    }
}
