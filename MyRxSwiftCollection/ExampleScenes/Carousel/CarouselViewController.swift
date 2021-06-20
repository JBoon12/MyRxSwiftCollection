//
//  CarouselViewController.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/20.
//

import UIKit

class CarouselViewController: BaseViewController {
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    let cellSize:CGSize = {
        let width = UIScreen.main.bounds.size.width*2/3
        let height = UIScreen.main.bounds.size.height/3
        return CGSize(width: width, height: height)
    }()
    var minItemSpacing: CGFloat = 20
    let cellCount = 8
    var previousIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUI() {
        carouselCollectionView.contentInsetAdjustmentBehavior = .never
        let cellWidth: CGFloat = floor(cellSize.width)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 10, height: cellSize.height)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        carouselCollectionView.collectionViewLayout = flowLayout
        carouselCollectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        carouselCollectionView.decelerationRate = .fast
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.register(CarouselCollectionViewCell.self,
                                        forCellWithReuseIdentifier: "CarouselCollectionViewCell")
    }
}

extension CarouselViewController {
    func animateZoomforCell(zoomCell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            zoomCell.transform = .identity
        }
    }

    func animateZoomforCellremove(zoomCell: UICollectionViewCell) {
        UIView.animate( withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            zoomCell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
    }
}

extension CarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell",
                                           for: indexPath) as? CarouselCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.title = "TESTESTTESTTEST"
        return cell
    }
    
}

extension CarouselViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex: CGFloat = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left,
                         y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
        let offsetX = carouselCollectionView.contentOffset.x
        let index = (offsetX + carouselCollectionView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex = round(index)
        let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
        if let cell = carouselCollectionView.cellForItem(at: indexPath) {
            animateZoomforCell(zoomCell: cell)
        }
        if Int(roundedIndex) != previousIndex {
            let preIndexPath = IndexPath(item: previousIndex, section: 0)
            if let preCell = carouselCollectionView.cellForItem(at: preIndexPath) {
                animateZoomforCellremove(zoomCell: preCell)
            }
            previousIndex = indexPath.item
        }
    }
}

extension CarouselViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}
