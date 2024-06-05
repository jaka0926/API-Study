//
//  MarketViewController.swift
//  NetworkBasicUpgrade
//
//  Created by Jaka on 2024-06-05.
//

import UIKit
import Alamofire
import SnapKit

struct Market: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
}

class MarketViewController: UIViewController {
    
    let tableView = UITableView()
    let list: [Market] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        print(#function, "1111")
        callRequest()
        tableView.reloadData()
        print(#function, "2222")
        
    }
    
    func configureTableView() {
        
        tableView.backgroundColor = .lightGray
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.identifier)
    }
    
    func callRequest() {
        print(#function, "33333")
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function, list.count)
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        
        cell.nameLabel.text = "Example"
        return cell
    }
    
}
