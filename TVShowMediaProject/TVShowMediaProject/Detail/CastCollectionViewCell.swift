//
//  CastCollectionViewCell.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 2/1/24.
//

import UIKit
import SnapKit

class CastCollectionViewCell: UICollectionViewCell {
    
    let profileImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    let nameLabel: UILabel = {
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
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
    }

    func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.width.height.equalTo(UIScreen.main.bounds.width / 4 - 8)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.height.equalTo(24)
            make.centerY.equalTo(contentView)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
    }
}
