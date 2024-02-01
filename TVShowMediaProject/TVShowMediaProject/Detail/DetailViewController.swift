//
//  DetailViewController.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/31/24.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    let mainView = DetailView()
    
    var showDetail: TVDetails = TVDetails(
        id: 96462,
        name: "", 
        overview: "",
        poster: ""
    )
    var showCasts: [TVCastingsCasts] = []
    var showRecommendations: [TVRecommendResults] = []

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.castCollectionView.delegate = self
        mainView.castCollectionView.dataSource = self
        
        mainView.recommendCollectionView.delegate = self
        mainView.recommendCollectionView.delegate = self
        
        // Network 통신
        let group = DispatchGroup()
        
        group.enter()
        APIManager.shared.fetchDetailTVShow(api: .detail(movieId: 96462)) { detail in
            self.mainView.titleLabel.text = detail.name
            self.mainView.overviewLabel.text = detail.overview
            if let poster = detail.poster {
                let url = URL(string: "\(APIUrl.tmdbImg)\(poster)")
                self.mainView.posterImage.kf.setImage(with: url)
            } else {
                self.mainView.posterImage.image = UIImage(systemName: "xmark")
            }
            group.leave()
        }
        
        group.enter()
        APIManager.shared.fetchCastsTVShow(api: .casts(movieId: 96462)) {
            self.showCasts = $0
            group.leave()
        }
        
        group.enter()
        APIManager.shared.fetchRecommendTVShow(api: .recommend(movieId: 96462)) {
            self.showRecommendations = $0
            print(self.showRecommendations)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.castCollectionView.reloadData()
            self.mainView.recommendCollectionView.reloadData()
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.castCollectionView {
            return showCasts.count
        } else {
            print("showRecommendations.count", showRecommendations.count)
            return showRecommendations.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.castCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CastCollectionViewCell",
                for: indexPath) as! CastCollectionViewCell
            let item = showCasts[indexPath.item]
            
            if let profile = item.profile {
                let url = URL(string: "\(APIUrl.tmdbImg)\(profile)")
                cell.profileImage.kf.setImage(with: url)
            } else {
                cell.profileImage.image = UIImage(systemName: "xmark")
            }
            cell.nameLabel.text = item.name
            
            return cell
        } else {
            print("cell Item")
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecommendCollectionViewCell",
                for: indexPath
            ) as! RecommendCollectionViewCell
            let item = showRecommendations[indexPath.item]
            
            if let poster = item.poster {
                let url = URL(string: "\(APIUrl.tmdbImg)\(poster)")
                cell.posterImage.kf.setImage(with: url)
            } else {
                cell.posterImage.image = UIImage(systemName: "xmark")
            }
            cell.titleLabel.text = item.name
            collectionView.reloadData()
    
            return cell
        }
    }
}
