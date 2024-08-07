//
//  UIView + Ext.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 02.07.24.
//

import UIKit

extension UIView {
    func addBorder(width: CGFloat, color: UIColor?) {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
    }
}
