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
    
    var items: [CoordinatorViewType] = {
        return [.searchViewController,
                .animatedViewController]
    }()
    
    lazy var dataSource = BehaviorRelay<[CoordinatorViewType]>(value: items)
    
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
                
                cell.coordinatorType = element
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    override func bindingAction() {
        Observable.zip(
            mainTableView.rx.itemSelected,
            mainTableView.rx.modelSelected(CoordinatorViewType.self)
        )
        .subscribe(onNext:{[weak self] indexPath, title in
            self?.mainTableView.deselectRow(at: indexPath, animated: true)
            let cell = self?.mainTableView.cellForRow(at: indexPath) as? MainTableViewCell
            cell?.coordinatorType?.go()
        })
        .disposed(by: disposeBag)
    }

}

