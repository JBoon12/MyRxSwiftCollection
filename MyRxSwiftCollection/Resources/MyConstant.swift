//
//  MyConstant.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/18.
//

import Foundation

typealias MyCellType = MyConstant.MyCellType
typealias MyViewControllerType = MyConstant.MyViewControllerType

struct MyConstant{
    struct MyCellType {
        static let MAIN_CELL_IDENTIFIER = "MainTableViewCell"
        static let SEARCH_CELL_IDENTIFIER = "SearchTableViewCell"
        static let ANIMATED_CELL_IDENTIFIER = "AnimatedTableViewCell"
    }
    
    struct MyViewControllerType {
        static let SEARCH_VIEW_IDENTIFIER = "SearchViewController"
        static let ANIMATED_VIEW_IDENTIFIER = "AnimatedViewController"
    }
}
