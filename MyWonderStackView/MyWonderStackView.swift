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
    private var initializing = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialized()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialized()
    }
    
    private func initialized() {
        DispatchQueue.main.async {
            self.initializing = false
        }
    }
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        guard !initializing else { return }
        
        customSubviews.append(view)
        
        let targetSize = CGSize(width: frame.width, height: 0)
        view.frame.size = view.systemLayoutSizeFitting(targetSize,
                                                       withHorizontalFittingPriority: .defaultHigh,
                                                       verticalFittingPriority: .defaultHigh)
        view.frame.origin.y = contentArea.height
        
        contentArea = contentArea.union(view.frame)        
        scrollRectToVisible(view.frame, animated: false)
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
