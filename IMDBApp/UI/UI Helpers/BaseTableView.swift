//
//  BaseTableView.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 04.07.24.
//

import UIKit

class BaseTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
