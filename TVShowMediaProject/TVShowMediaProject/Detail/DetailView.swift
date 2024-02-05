//
//  DetailView.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 2/1/24.
//

import UIKit
import SnapKit

class DetailView: BaseView {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()

    let overviewLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()

    let posterImage = UIImageView(frame: .zero)
    
    let castCollectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: castCollectionViewLayout()
        )
        view.register(
            CastCollectionViewCell.self,
            forCellWithReuseIdentifier: "CastCollectionViewCell"
        )
        view.isPagingEnabled = true
        view.backgroundColor = .clear
        return view
    }()
    let recommendCollectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: recommendCollectionViewLayout()
        )
        view.register(
            RecommendCollectionViewCell.self,
            forCellWithReuseIdentifier: "RecommendCollectionViewCell"
        )
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(posterImage)
        addSubview(titleLabel)
        addSubview(overviewLabel)
        addSubview(castCollectionView)
        addSubview(recommendCollectionView)
    }
    
    override func configureLayout() {
        posterImage.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(140)
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImage.snp.trailing).offset(8)
            make.trailing.top.equalTo(safeAreaLayoutGuide).inset(12)
            make.height.equalTo(24)
        }
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(4)
            make.leading.equalTo(posterImage.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(posterImage.snp.bottom)
        }
        castCollectionView.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.width / 4 + 8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(castCollectionView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
    }

    static func castCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.width / 4
        )
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        layout.scrollDirection = .horizontal
        return layout
    }
    
    static func recommendCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width / 3 - 32,
            height: UIScreen.main.bounds.height / 4
        )
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
}
