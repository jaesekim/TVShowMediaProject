//
//  BaseView.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 2/1/24.
//

import UIKit
import SnapKit
import Kingfisher

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
}
