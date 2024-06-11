//
//  ViewController.swift
//  NetworkBasicUpgrade
//
//  Created by Jaka on 2024-06-05.
//

import UIKit
import Alamofire
import SnapKit

struct Lotto: Decodable {
    let drwNoDate: String
    let totSellamnt: Int
}

class ViewController: UIViewController {
    
    let numberTextField = UITextField()
    let checkButton = UIButton()
    let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureUI()
    }

    func configureHierarchy() {
        view.addSubview(numberTextField)
        view.addSubview(checkButton)
        view.addSubview(resultLabel)
    }
    func configureLayout() {
        numberTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        checkButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(checkButton.snp.bottom).offset(20)
        }
            
        
    }
    func configureUI() {
        view.backgroundColor = .white
        numberTextField.backgroundColor = .gray
        
        checkButton.backgroundColor = .blue
        checkButton.setTitle("로또 당첨 번호 확인", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        
        resultLabel.numberOfLines = 0
        resultLabel.backgroundColor = .orange
    }

    //Swift.DecodingError.keyNotFound
    //1. URL
    //2.responseString 확인
    //3. nil
    @objc func checkButtonClicked() {
        
        let url = "\(APIURL.lottoURL)\(numberTextField.text!)"
        
        AF.request(url).responseDecodable(of: Lotto.self) {
            response in
            switch response.result {
            case .success(let value):
                self.resultLabel.text = "\(value.drwNoDate)\n1등 당첨금액: \(value.totSellamnt.formatted())원"
            case .failure(let error):
                print(error)
                self.resultLabel.text = "올바른 값을 입력해주세요"
            }
        }
    }
}

