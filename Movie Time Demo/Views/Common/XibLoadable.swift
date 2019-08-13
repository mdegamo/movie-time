//
//  XibLoadable.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 13/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

protocol XibLoadable {
    func initContentView(fromNibNamed nibName: String) -> UIView
    func loadViewFromNib(_ nibName: String) -> UIView
}

extension XibLoadable where Self: UIView {
    func initContentView(fromNibNamed nibName: String) -> UIView {
        let view = loadViewFromNib(nibName)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
    
    func loadViewFromNib(_ nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
