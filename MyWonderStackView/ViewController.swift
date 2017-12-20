//
//  ViewController.swift
//  MyWonderStackView
//
//  Created by Mykola Denysyuk on 12/19/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let colors: [UIColor] = [.red, .green, .yellow, .black, .blue]
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var width: UITextField!
    @IBOutlet weak var height: UITextField!
    
    @IBAction func addAction(_ sender: Any) {
//        let newView = SizedView(frame: .init(origin: .zero,
//                                             size: CGSize(width: width.intrinsicMetric,
//                                                          height: height.intrinsicMetric)))
//        newView.backgroundColor = colors[scrollView.subviews.count % colors.count]
//        scrollView.addSubview(newView)
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: height.intrinsicMetric).isActive = true
        view.widthAnchor.constraint(equalToConstant: width.intrinsicMetric).isActive = true
        view.backgroundColor = colors[scrollView.subviews.count % colors.count]
        scrollView.addSubview(view)
    }
    
    @IBAction func removeAction(_ sender: Any) {
        if let last = scrollView.subviews.last {
            last.removeFromSuperview()
        }
    }
    
}

final class SizedView: UIView {
    override var intrinsicContentSize: CGSize {
        return frame.size
    }
}

extension UITextField {
    var intrinsicMetric: CGFloat {
        guard
            let string = text,
            let number = NumberFormatter().number(from: string)
            else { return UIViewNoIntrinsicMetric }
        return CGFloat(truncating: number)
    }
}
