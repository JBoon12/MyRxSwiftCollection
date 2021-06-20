//
//  CarouselCollectionViewCell.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/20.
//

import UIKit
import SnapKit

class CarouselCollectionViewCell: UICollectionViewCell {

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    func setUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

