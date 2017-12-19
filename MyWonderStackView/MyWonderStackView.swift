//
//  MyWonderStackView.swift
//  MyWonderStackView
//
//  Created by Mykola Denysyuk on 12/19/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class MyWonderStackView: UIScrollView {
    private var contentArea = CGRect() {
        didSet {
            contentSize = contentArea.size
        }
    }
    private(set) var customSubviews = [UIView]()
    override var subviews: [UIView] {
        return customSubviews
    }
    
    func add(subview: UIView) {
        customSubviews.append(subview)
        
        let targetSize = CGSize(width: frame.width, height: 0)
        subview.frame.size = subview.systemLayoutSizeFitting(targetSize,
                                                             withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        subview.frame.origin.y = contentArea.height
        
        contentArea = contentArea.union(subview.frame)
        addSubview(subview)
        scrollRectToVisible(subview.frame, animated: false)
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        if let index = customSubviews.index(of: subview) {
            customSubviews.remove(at: index)
            contentArea = customSubviews.reduce(CGRect(), { (all, element) -> CGRect in
                return all.union(element.frame)
            })
        }
    }

}
