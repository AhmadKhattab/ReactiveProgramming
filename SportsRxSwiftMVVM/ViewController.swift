//
//  ViewController.swift
//  SportsRxSwiftMVVM
//
//  Created by Ahmad Khattab on 25/04/2021.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    let flowLayout = UICollectionViewFlowLayout()
    
    
    
    let size = UIScreen.main.bounds.width / 2 - 5
    
    
    // Variables
    var homeViewModel: HomeViewModel?
    var sportsObservable: Observable<[Sport]>? {
        didSet{
            setupSportsCollectionView()
        }
    }
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupDependencies()
        setupSportsCollectionView()
        setupAllObservation()
        setupCollectionViewCellSize()
        fetchAllSports()
        
    }
    
    
}


extension ViewController {
    
    
    func setupDependencies() {
        let remoteDataSource = RemoteDataSourceImp()
        let sportsRepo = SportsRepoImp(sportsDataSource: remoteDataSource)
        homeViewModel = HomeViewModel(sportsRepo: sportsRepo)
        
    }
    
    func setupSportsCollectionView() {
        
        sportsObservable?.bind(to: sportsCollectionView.rx.items(cellIdentifier: "sportCell")) { row, item, cell in
            
            (cell as! SportCell).sportName.text = item.strSport
            (cell as! SportCell).sportImage.sd_setImage(with: URL(string: item.strSportThumb), placeholderImage: UIImage(named: "placeholder.png"))
            
            
        }.disposed(by: disposeBag)
        
    }
    
    func setupCollectionViewCellSize() {
        
        flowLayout.itemSize = CGSize(width: size, height: 150)
        sportsCollectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    func setupAllObservation() {
        
        
        homeViewModel?.sportsObservable?.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background)).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (sports) in
            self?.sportsObservable = Observable<[Sport]>.of(sports)
        }).disposed(by: disposeBag)
        
        homeViewModel?.errorObservable?.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background)).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            
            self?.showAlert(error: error)
            
        }).disposed(by: disposeBag)
    }
    
    func fetchAllSports() {
        homeViewModel?.fetchAllSports()
    }
}


extension ViewController {
    
    func showAlert(error: String) {
        
        let alert = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
}

