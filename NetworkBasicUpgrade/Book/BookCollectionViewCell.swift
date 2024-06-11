//
//  BookCollectionViewCell.swift
//  NetworkBasicUpgrade
//
//  Created by Jaka on 2024-06-11.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let id = "BookCollectionViewCell"
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
