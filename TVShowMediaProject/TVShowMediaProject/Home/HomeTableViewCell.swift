//
//  HomeTableViewCell.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/30/24.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {

    let divisionLabel = UILabel()
    let posterCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: configureCollectionViewLayout()
    )

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(divisionLabel)
        contentView.addSubview(posterCollectionView)
    }
    
    func configureLayout() {
        divisionLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.horizontalEdges.top.equalTo(contentView)
        }
        
        posterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(divisionLabel.snp.bottom)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(8)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        
        divisionLabel.text = ""
        divisionLabel.textColor = .white
        divisionLabel.textAlignment = .left
        divisionLabel.font = .boldSystemFont(ofSize: 16)
        
        posterCollectionView.backgroundColor = .clear
        posterCollectionView.isPagingEnabled = true
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width / 2 - 20,
            height: UIScreen.main.bounds.height / 3 - 40
        )
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        layout.scrollDirection = .horizontal
        return layout
    }
}
