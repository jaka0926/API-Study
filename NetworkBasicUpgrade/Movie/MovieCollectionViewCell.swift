//
//  MovieCollectionViewCell.swift
//  NetworkBasicUpgrade
//
//  Created by Jaka on 2024-06-12.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let id = "MovieCollectionViewCell"
    let posterImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemTeal
        
        contentView.addSubview(posterImage)
        
        posterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
