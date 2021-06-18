//
//  BaseViewController.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/18.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindingData()
        bindingAction()
    }
    
    func setUI() { }

    func bindingData() { }
    
    func bindingAction() { }

}
