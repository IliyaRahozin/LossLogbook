//
//  ViewController.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 22.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var coordinator: BaseCoordinatorFlow?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = collectionView.layoutMargins.left
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: (view.frame.width / 2) + 50, height: view.frame.height / 2)
        collectionView.collectionViewLayout = layout
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        NetworkManager().fetchEquiment { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.description)
            }
        }
    }
    
    private func setup() {
        title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.delegate   = self
        collectionView.dataSource = self
    }
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGray5
        cell.layer.cornerRadius = 10

        return cell
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let _ = scrollView as? UICollectionView else { return }
        let x = targetContentOffset.pointee.x
        let calculate = round(x / ((view.frame.width / 2) + 50 + 15))
        let newX = calculate * ((view.frame.width / 2) + 50 + 15)
        targetContentOffset.pointee.x = newX
    }

}
