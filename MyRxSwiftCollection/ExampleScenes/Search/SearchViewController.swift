//
//  SearchViewController.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/18.
//

import UIKit
import RxSwift
import RxCocoa


class SearchViewController: BaseViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    var items: [String] = {
        return ["가나다", "나다라", "다라마", "라마바",
                "마바사", "바사아", "사아자", "아자차",
                "자차카", "차카타", "카타파", "타파하",
                "파하가", "하가나", "abcde", "bcdef",
                "cdefg", "defgh", "efghi", "fghij",
                "ghijk", "hijkl", "ijklm", "jklmn",
                "klmno", "lmnop", "mnopq", "nopqr",
                "opqrs", "pqrst", "qrstu", "rstuv",
                "stuvw", "tuvwx", "uvwxy", "vwxyz",
                "wxyza", "xyzab", "yzabc", "zabcd"
        ]
    }()
    
    lazy var dataSource = PublishRelay<[NSAttributedString]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Rx로 검색"
    }

    override func setUI() {
        searchTableView.register(SearchTableViewCell.self,
                               forCellReuseIdentifier: MyCellType.SEARCH_CELL_IDENTIFIER)
        searchTableView.tableFooterView = UIView(frame: .zero)
        searchTableView.keyboardDismissMode = .onDrag
    }
    
    override func bindingData() {
        dataSource
            .bind(to: searchTableView.rx.items)
            { tableView, index, element -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCellType.SEARCH_CELL_IDENTIFIER) as? SearchTableViewCell
                else {
                    return UITableViewCell()
                }
                
                cell.title = element
                
                return cell
            }
            .disposed(by: disposeBag)
        
        searchTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .compactMap{[weak self] text -> [NSAttributedString]? in
                self?.items.filter{$0.contains(text)}
                    .compactMap{ item -> NSMutableAttributedString? in
                        let attStr = NSMutableAttributedString(string: item)
                        attStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (NSString(string: item).range(of: text)))
                        return attStr
                    }
            }
            .bind(to: dataSource)
            .disposed(by: disposeBag)
    }
    
    override func bindingAction() {
        Observable.zip(
            searchTableView.rx.itemSelected,
            searchTableView.rx.modelSelected(NSAttributedString.self)
        )
        .subscribe(onNext:{[weak self] indexPath, title in
            self?.searchTableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposeBag)
    }
}
