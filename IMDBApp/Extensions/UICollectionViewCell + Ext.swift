//
//  UICollectionViewCell + Ext.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    func addShadow() {
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
    }
}
