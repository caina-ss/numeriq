//
//  HomeViewController.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwinjectStoryboard

class HomeViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Dependencies

    var viewModel: HomeViewModelType?

    // MARK: - Private

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        viewModel?.fetchArticles(query: "bitcoin", from: Date())
    }

}

// MARK: - Private

private extension HomeViewController {

    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.register(ArticleCell.self)

        viewModel?
            .articles
            .subscribe(onNext: { _ in
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.articles.value.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.defaultReuseIdentifier,
                                                      for: indexPath) as! ArticleCell

        guard let article = viewModel?.articles.value[indexPath.row] else {
            return .init()
        }

        cell.configure(article: article)

        return cell
    }

}
