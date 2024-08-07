//
//  ActivityIndicatorView.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 19.07.24.
//

import UIKit

class ActivityIndicatorView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .black.withAlphaComponent(0.3)
        addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func show() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hide() {
        isHidden = true
        activityIndicator.stopAnimating()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return !isHidden && super.point(inside: point, with: event)
    }
}

