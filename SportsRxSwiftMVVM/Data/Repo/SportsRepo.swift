//
//  SportsRepo.swift
//  SportsRxSwiftMVVM
//
//  Created by Ahmad Khattab on 25/04/2021.
//

import Foundation
protocol SportsRepo {
    func fetchAllSports(onComplete: @escaping ([Sport]) -> Void, onError: @escaping (String) -> Void)

}
