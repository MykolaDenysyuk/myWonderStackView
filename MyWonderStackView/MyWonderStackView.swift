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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if customSubviews.count > 0 {
            let targetSize = CGSize(width: frame.width, height: 0)
            
            contentArea = customSubviews.reduce(CGRect(), { (all, element) -> CGRect in
                element.frame.size = element.systemLayoutSizeFitting(targetSize,
                                                                     withHorizontalFittingPriority: .defaultHigh,
                                                                     verticalFittingPriority: .defaultHigh)
                element.frame.origin.y = all.maxY
                return all.union(element.frame)
            })
        }
        else {
            contentArea = .zero
        }
    }
}
