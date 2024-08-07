//
//  SearchEmptyTableViewCell.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 03.07.24.
//

import UIKit

class SearchEmptyTableViewCell: UITableViewCell {
    
    private let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 12
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let centerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "searchEmpty")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .primarySurface
        contentView.addSubview(verticalStackView)
        [titleLabel, centerImageView].forEach(verticalStackView.addArrangedSubview)
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        centerImageView.snp.makeConstraints { make in
            make.size.equalTo(160)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchEmptyTableViewCell {
    struct Item {
        let title: String
    }
    
    func configure(_ item: Item) {
        self.titleLabel.text = item.title
    }
}
