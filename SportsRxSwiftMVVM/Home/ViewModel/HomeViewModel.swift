//
//  HomeViewController.swift
//  SportsRxSwiftMVVM
//
//  Created by Ahmad Khattab on 25/04/2021.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    var sportsRepo: SportsRepo?
    private var sportsPublisher = PublishSubject<[Sport]>()
    var sportsObservable: Observable<[Sport]>?
    
    private var errorPublisher = PublishSubject<String>()
    var errorObservable: Observable<String>?
    
    init(sportsRepo: SportsRepo) {
        self.sportsRepo = sportsRepo
        sportsObservable = sportsPublisher.asObservable()
       
    }
    
    func fetchAllSports() {
        
        sportsRepo?.fetchAllSports(onComplete: { [weak self] (sports) in
            self?.sportsPublisher.onNext(sports)
        }, onError: { [weak self] (error) in
            self?.errorPublisher.onNext(error)
        })
        
    }
    
    
    
    
}
