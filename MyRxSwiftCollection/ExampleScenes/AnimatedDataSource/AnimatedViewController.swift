//
//  AnimatedViewController.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class AnimatedViewController: BaseViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    var items: [String] = {
        return ["가나다", "나다라", "다라마", "라마바",
                "마바사", "바사아", "사아자", "아자차",
                "자차카", "차카타", "카타파", "타파하",
                "파하가", "하가나"]
    }()
    
    var reverseItems: [String] = {
        return ["하파타", "파타카", "타카차", "카차자",
                "차자아", "자아사", "아사바", "사바마",
                "바마라", "마라다", "라다나", "다나가",
                "가하파", "나가하"]
    }()
    
    var categories = ["normal", "reverse"]
    
    lazy var cellData = {
        return items.compactMap { Example2CellData(category: categories[0], value: NSMutableAttributedString(string: $0)) } +
            reverseItems.compactMap{ Example2CellData(category: categories[1], value: NSMutableAttributedString(string: $0)) }
    }()
    
    
    
    var datasource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, AnimatedCellData>>(
        configureCell:{ dataSource, tableView, indexPath, element in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCellType.ANIMATED_CELL_IDENTIFIER) as? AnimatedTableViewCell
            else { return UITableViewCell() }
            
            cell.title = element.data.value
            if dataSource[indexPath.section].model == "normal",
               let value = dataSource[indexPath.section].items.first(where: { $0.data.value.string == "가나다" })
            {
                print(value.identity + "  " + value.data.value.string + ":  " + dataSource[indexPath.section].identity)
            }
            
            return cell
        },
        titleForHeaderInSection:{ dataSource, section in
            return dataSource[section].model + " (" + String(dataSource[section].items.count) + ")" //도대체 어떻게해야 headerTitle이 reload될까
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Rx로 Animated Cell"
    }
    
    override func setUI() {
        
        searchTableView.register(AnimatedTableViewCell.self,
                                 forCellReuseIdentifier: MyCellType.ANIMATED_CELL_IDENTIFIER)
        searchTableView.tableFooterView = UIView(frame: .zero)
        searchTableView.keyboardDismissMode = .onDrag
    }
    
    override func bindingData() {
        searchTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .compactMap{[weak self] text -> [Example2CellData]? in
                self?.cellData.filter{$0.value.string.contains(text)}
                    .compactMap{ item -> Example2CellData? in
                        item.value.addAttribute(.foregroundColor,
                                                value: UIColor.black,
                                                range: (NSString(string: item.value.string).range(of: item.value.string)))
                        item.value.addAttribute(.foregroundColor,
                                                value: UIColor.blue,
                                                range: (NSString(string: item.value.string).range(of: text)))
                        return item
                    }
            }
            .compactMap {[weak self] items -> [AnimatableSectionModel<String, AnimatedCellData>]? in
                guard let self = self else { return nil }
                if items.count == 0 {
                    return self.categories.compactMap{AnimatableSectionModel<String, AnimatedCellData>(model: $0,
                                                                                                       items: [AnimatedCellData]())}
                }
                
                return self.categories
                    .compactMap { category in
                        AnimatableSectionModel<String, AnimatedCellData>(model: category,
                                                                         items: items.filter{$0.category == category}
                                                                            .compactMap{AnimatedCellData(id: Int.random(in: 0..<1000),
                                                                                                         data: $0)})
                    }
            }
            .bind(to: searchTableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
    override func bindingAction() {
        Observable.zip(
            searchTableView.rx.itemSelected,
            searchTableView.rx.modelSelected(AnimatedCellData.self)
        )
        .subscribe(onNext:{[weak self] indexPath, title in
            self?.searchTableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposeBag)
    }
}
