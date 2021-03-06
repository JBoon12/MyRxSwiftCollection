//
//  MainTableViewCell.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/18.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
        
    var coordinatorType: CoordinatorViewType? {
        didSet{
            titleLabel.text = coordinatorType?.cellTitle
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints{
            $0.top.bottom.left.right.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
