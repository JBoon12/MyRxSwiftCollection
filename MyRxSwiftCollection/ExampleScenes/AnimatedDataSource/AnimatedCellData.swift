//
//  AnimatedCellData.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/19.
//

import Foundation
import RxDataSources

struct Example2CellData {
    var category: String
    var value: NSMutableAttributedString
}


struct AnimatedCellData: IdentifiableType {
    var identity: String
    var data: Example2CellData
    
    init(id: Int, data: Example2CellData) {
        self.identity = String(id) + data.category
        self.data = data
    }
}

extension AnimatedCellData: Equatable {
    public static func == (lhs: AnimatedCellData, rhs: AnimatedCellData) -> Bool {
        return lhs.identity == rhs.identity
    }
}
