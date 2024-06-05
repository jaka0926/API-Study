//
//  MarketTableViewCell.swift
//  NetworkBasicUpgrade
//
//  Created by Jaka on 2024-06-05.
//

import UIKit

class MarketTableViewCell: UITableViewCell {
    
    static let identifier = "MarketTableViewCell"
    
    let nameLabel = UILabel()
    
    //NIB == XIB >>> XIB가 없다면 잉 코드는 실행 안됨
    //그릇을 세팅해주는 초기화 구문
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        nameLabel.textColor = .brown
        nameLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
