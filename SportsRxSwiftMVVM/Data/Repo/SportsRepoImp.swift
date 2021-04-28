//
//  SportsRepoImp.swift
//  SportsRxSwiftMVVM
//
//  Created by Ahmad Khattab on 25/04/2021.
//

import Foundation
class SportsRepoImp: SportsRepo {
    
    var sportsDataSource: RemoteDataSource?
    
    init(sportsDataSource: RemoteDataSource) {
        self.sportsDataSource = sportsDataSource
    }
    
    func fetchAllSports(onComplete: @escaping ([Sport]) -> Void, onError: @escaping (String) -> Void) {
        
        sportsDataSource?.fetchAllSports(onComplete: onComplete, onError: onError)
    }
    
    
}
