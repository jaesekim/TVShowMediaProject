//
//  HomeCollectionViewCell.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/30/24.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    let tvShowTitle = UILabel()
    let posterImage = UIImageView()

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
        contentView.addSubview(tvShowTitle)
        contentView.addSubview(posterImage)
    }

    func configureLayout() {
        tvShowTitle.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(32)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        posterImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(4)
            make.top.equalTo(contentView).inset(4)
            make.bottom.equalTo(tvShowTitle.snp.top)
        }
    }

    func configureView() {
        backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true

        tvShowTitle.text = ""
        tvShowTitle.textColor = .black
        tvShowTitle.textAlignment = .center
        tvShowTitle.font = .boldSystemFont(ofSize: 12)
        tvShowTitle.numberOfLines = 2
        
        posterImage.backgroundColor = .clear
        posterImage.layer.cornerRadius = 8
        posterImage.clipsToBounds = true
        posterImage.contentMode = .scaleToFill
    }
}
