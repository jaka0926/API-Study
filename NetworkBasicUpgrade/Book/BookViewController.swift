import UIKit
import Alamofire
import Kingfisher
import SnapKit
/*
 1. BookTableViewCell
 2. Kakao Developer Book Search -> Alamofire(responseString)
 */

/*
페이지네이션
1. 스크롤이 끝날 쯤에 다음 페이지를 요청(page += 1 후 callRequest)
2. 이전 내용은 어떻게 확인하지?
3. 다른 검색어를 입력할 때
*/

class BookViewController: UIViewController {

   
let searchBar = UISearchBar()
let tableView = UITableView()
   
var list = KakaoBook(documents: [], meta: Meta(is_end: false, pageable_count: 0, total_count: 0))
var page = 1
var isEnd = false
    
override func viewDidLoad() {
super.viewDidLoad()
     
    configureView()
  }
   
func configureView() {
    print(#function)
    view.backgroundColor = .white
    
    searchBar.delegate = self
    
    tableView.backgroundColor = .gray
    tableView.rowHeight = 120
    tableView.delegate = self
    tableView.dataSource = self
    tableView.prefetchDataSource = self
    tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.id)
     
    view.addSubview(searchBar)
    view.addSubview(tableView)
     
     
    searchBar.snp.makeConstraints { make in
      make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(44)
    }
     
    tableView.snp.makeConstraints { make in
      make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(searchBar.snp.bottom)
    }
  }
    func callRequestBook(query: String) {
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)&size=10"
        print(#function, url)
        
        let header: HTTPHeaders = ["Authorization": APIKey.kakao]
        
        AF.request(url, 
                   method: .get,
                   headers: header)
        .responseDecodable(of: KakaoBook.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS", self.list.documents.count)
                self.isEnd = self.list.meta.is_end
                
                if self.page == 1 {
                    self.list = value
                    
                }
                else {
                    self.list.documents.append(contentsOf: value.documents)
                }
                
                self.tableView.reloadData()
                
                if self.page == 1 {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
                
                
            case .failure(let error):
                print("FAILURE")
                dump(error)
            }
            
        }
    }
    
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.id, for: indexPath) as! BookTableViewCell
        
    let data = list.documents[indexPath.row]
    cell.titleLabel.text = data.title
    cell.overviewLabel.text = data.contents
    
    let url = URL(string: data.thumbnail)
    cell.thumbnailImageView.kf.setImage(with: url)
    cell.subTitleLabel.text = data.authors.joined(separator: ", ")
    return cell
    }
   
}

extension BookViewController: UISearchBarDelegate {
    //무조건 통신이 들어가지 않고,
    //빈칸, 촤소 1자 이상, 같은 글자 등에 대한 처리가 필요할 수 있음.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        page = 1
        callRequestBook(query: searchBar.text!)
    }
}

extension BookViewController: UITableViewDataSourcePrefetching {
    
    //cellForRowAt이 호출 되기 전에 미리 호출됨
    //즉, 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운받는 기능
    //호출 시점 애플이 알아서 결정!
    
   
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        print("Prefetch \(indexPaths)")
        
        for item in indexPaths {
            if list.documents.count - 2 == item.row && isEnd == false{
                page += 1
                callRequestBook(query: searchBar.text!)
            }
        }
        
    }
    // 취소 기능: 단, 직접 취소하는 기능을 구현해줘야 한다.
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Cancel Prefetch \(indexPaths)")
    }

}
