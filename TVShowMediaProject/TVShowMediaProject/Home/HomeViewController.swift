//
//  HomeViewController.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class HomeViewController: UIViewController {
    
    let homeTableView = UITableView()
    
    let divisionList = ["Trend", "Top Rated", "Popular"]
    
    var trendTVShowList: [TVTrendingResults] = []
    var topRatedTVShowList: [TVTopRatedResults] = []
    var popularTVShowList: [TVPopularResults] = []
    
    let group = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()

        // API Data Fetching
//        APIManager.shared.fetchWeekTrendTVShow {
//            self.trendTVShowList = $0
//            self.homeTableView.reloadData()
//        }
        
        group.enter()
        TMDBSessionManager.shared.fetchTVForHome(type: TVTrending.self, api: .trend) { trend, error in
            if error == nil {
                guard let trend = trend else {
                    return
                }
                self.trendTVShowList = trend.results
            } else {
                switch error {
                case .failedRequest:
                    print("failedRequest")
                case .noData:
                    print("no data")
                case .invalidResponse:
                    print("invalid response")
                case .invalidData:
                    print("invalid data")
                default:
                    print("unrevealed error")
                }
            }
            self.group.leave()
        }
        // top rated
        group.enter()
        TMDBSessionManager.shared.fetchTVForHome(type: TVTopRated.self, api: .top) { top, error in
            if error == nil {
                guard let top = top else {
                    return
                }
                self.topRatedTVShowList = top.results
            } else {
                switch error {
                case .failedRequest:
                    print("failedRequest")
                case .noData:
                    print("no data")
                case .invalidResponse:
                    print("invalid response")
                case .invalidData:
                    print("invalid data")
                default:
                    print("unrevealed error")
                }
            }
            self.group.leave()
        }
        // popular
        group.enter()
        TMDBSessionManager.shared.fetchTVForHome(type: TVPopular.self, api: .popular) { popular, error in
            if error == nil {
                guard let popular = popular else {
                    return
                }
                self.popularTVShowList = popular.results
            } else {
                switch error {
                case .failedRequest:
                    print("failedRequest")
                case .noData:
                    print("no data")
                case .invalidResponse:
                    print("invalid response")
                case .invalidData:
                    print("invalid data")
                default:
                    print("unrevealed error")
                }
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            self.homeTableView.reloadData()
        }
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(homeTableView)
    }
    
    func configureLayout() {
        homeTableView.snp.makeConstraints { make in
            make.size.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        // Connect TableView
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.backgroundColor = .clear
        homeTableView.rowHeight = UIScreen.main.bounds.height / 3
        homeTableView.register(
            HomeTableViewCell.self,
            forCellReuseIdentifier: "HomeTableViewCell"
        )
    }

}

extension HomeViewController: 
    UITableViewDelegate,
    UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return divisionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "HomeTableViewCell", 
            for: indexPath
        ) as! HomeTableViewCell
        
        // division label 달아주기
        cell.divisionLabel.text = divisionList[indexPath.row]
        
        // 개별 CollectionView 관리
        cell.posterCollectionView.delegate = self
        cell.posterCollectionView.dataSource = self
        cell.posterCollectionView.register(
            HomeCollectionViewCell.self,
            forCellWithReuseIdentifier: "HomeCollectionViewCell"
        )
        // collection view 구분을 위해 tag 지정
        cell.posterCollectionView.tag = indexPath.row
        cell.posterCollectionView.reloadData()
        return cell
    }
}

extension HomeViewController: 
    UICollectionViewDelegate,
    UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return trendTVShowList.count
        } else if collectionView.tag == 1 {
            return topRatedTVShowList.count
        } else {
            return popularTVShowList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeCollectionViewCell",
            for: indexPath
        ) as! HomeCollectionViewCell

        let currentDivision = collectionView.tag
        if currentDivision == 0 {
            let currentItem = trendTVShowList[indexPath.item]
            let urlString = "\(APIUrl.tmdbImg)\(currentItem.poster)"
            let url = URL(string: urlString)
            cell.posterImage.kf.setImage(with: url, placeholder: UIImage(systemName: "xmark"))
            cell.tvShowTitle.text = currentItem.name
            return cell
        } else if currentDivision == 1 {
            let currentItem = topRatedTVShowList[indexPath.item]
            let urlString = "\(APIUrl.tmdbImg)\(currentItem.poster)"
            let url = URL(string: urlString)
            cell.posterImage.kf.setImage(with: url, placeholder: UIImage(systemName: "xmark"))
            cell.tvShowTitle.text = currentItem.name
            return cell
        } else {
            let currentItem = popularTVShowList[indexPath.item]
            let urlString = "\(APIUrl.tmdbImg)\(currentItem.poster ?? "")"
            let url = URL(string: urlString)
            cell.posterImage.kf.setImage(with: url)
            cell.tvShowTitle.text = currentItem.name
            return cell
        }
    }
    
    
}
