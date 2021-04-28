//
//  RemoteDataSourceImp.swift
//  SportsRxSwiftMVVM
//
//  Created by Ahmad Khattab on 25/04/2021.
//

import Foundation
import Alamofire
class RemoteDataSourceImp : RemoteDataSource {
    

  
    private let sportsUrl = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
   
    func fetchAllSports(onComplete: @escaping ([Sport]) -> Void, onError: @escaping (String) -> Void) {
        
        let request = AF.request(sportsUrl)
        request.responseDecodable(of: SportsHolder.self) { (response) in
            
            guard let sportsHolder = response.value else {
                
                onError("There's something went wrong, please try again!")
                return
                
            }
            
            onComplete(sportsHolder.sports)
        }
    }
}
