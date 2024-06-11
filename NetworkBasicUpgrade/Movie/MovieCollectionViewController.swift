//
//  MovieCollectionViewController.swift
//  NetworkBasicUpgrade
//
//  Created by Jaka on 2024-06-12.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class MovieCollectionViewController: UIViewController {

    var list = Movie(results: [])
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let searchField = UISearchTextField()
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/3, height: width/3*1.33)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "영화 검색"
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        
        view.addSubview(collectionView)
        view.addSubview(searchField)
        searchField.addTarget(self, action: #selector(searchFieldReturnClicked), for: .editingDidEndOnExit)
        
        searchField.textColor = .white
        searchField.attributedPlaceholder = NSAttributedString(string: "영화 제목을 검색해보세요", attributes: [.foregroundColor: UIColor.white])
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        searchField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(35)
        }
        
    }
    
    @objc func searchFieldReturnClicked() {
        callRequest(searchField.text ?? "")
    }
    
    func callRequest(_ searchWord: String) {
        
        let url = "https://api.themoviedb.org/3/search/movie?query=\(searchWord)"
        let header: HTTPHeaders = ["Authorization": APIKey.movieKey]
        
        print(#function)
        print("List count: \(list.results.count)")
        
        AF.request(url,
                   method: .get,
                   headers: header)
        .responseDecodable(of: Movie.self) { response in
            switch response.result {
                        
                    case .success(let value):
                print("SUCCESS")
                self.list.results = value.results
                self.collectionView.reloadData()
                print(self.list.results)
                    case .failure(let error):
                        print("FAILURE", error)
                    }
                }
    }
}

extension MovieCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(list.results.count)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        
        let data = list.results[indexPath.row]
        
        let url = URL(string:"https://image.tmdb.org/t/p/original\(data.poster_path ?? "")")
        cell.posterImage.kf.setImage(with: url)
        
        return cell
    }

}
