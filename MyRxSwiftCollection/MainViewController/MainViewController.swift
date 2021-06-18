//
//  MainViewController.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/18.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {
    @IBOutlet weak var mainTableView: UITableView!
    
    var items: [String] = {
        return ["Rx로 검색 구현"]
    }()
    
    lazy var dataSource = BehaviorRelay<[String]>(value: items)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUI(){
        mainTableView.register(MainTableViewCell.self,
                               forCellReuseIdentifier: MyCellType.MAIN_CELL_IDENTIFIER)
        mainTableView.tableFooterView = UIView(frame: .zero)
    }

    override func bindingData() {
        dataSource
            .bind(to: mainTableView.rx.items)
            { tableView, index, element -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCellType.MAIN_CELL_IDENTIFIER) as? MainTableViewCell
                else {
                    return UITableViewCell()
                }
                
                cell.title = element
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    override func bindingAction() {
        Observable.zip(
            mainTableView.rx.itemSelected,
            mainTableView.rx.modelSelected(String.self)
        )
        .subscribe(onNext:{[weak self] indexPath, title in
            self?.mainTableView.deselectRow(at: indexPath, animated: true)
            MainCoordinator.searchViewStart()
        })
        .disposed(by: disposeBag)
    }

}

