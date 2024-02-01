//
//  RecommendCollectionViewCell.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 2/1/24.
//

import UIKit
import SnapKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    let posterImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImage)
    }

    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
        posterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.bottom.equalTo(titleLabel.snp.top)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
    }
}
