//
//  Models.swift
//  SportsRxSwiftMVVM
//
//  Created by Ahmad Khattab on 25/04/2021.
//

import Foundation

struct SportsHolder: Codable {
    let sports: [Sport]
}

// MARK: - Sport
struct Sport: Codable {
    let idSport, strSport: String
    let strFormat: StrFormat
    let strSportThumb, strSportThumbGreen: String
    let strSportDescription: String
}

enum StrFormat: String, Codable {
    case eventSport = "EventSport"
    case teamvsTeam = "TeamvsTeam"
}

// MARK: - League
struct League: Codable {
    var countrys: [Country]?
}


struct Country: Codable {
    
    var dateFirstEvent: String?
    var idAPIfootball: String?
    var idCup: String?
    var idLeague: String?
    var idSoccerXML: String?
    var intFormedYear: String?
    var strBadge: String?
    var strBanner: String?
    var strComplete: String?
    var strCountry: String?
    var strCurrentSeason: String?
    var strDescriptionCN: String?
    var strDescriptionDE: String?
    var strDescriptionEN: String?
    var strDescriptionES: String?
    var strDescriptionFR: String?
    var strDescriptionHU: String?
    var strDescriptionIL: String?
    var strDescriptionIT: String?
    var strDescriptionJP: String?
    var strDescriptionNL: String?
    var strDescriptionNO: String?
    var strDescriptionPL: String?
    var strDescriptionPT: String?
    var strDescriptionRU: String?
    var strDescriptionSE: String?
    var strDivision: String?
    var strFacebook: String?
    var strFanart1: String?
    var strFanart2: String?
    var strFanart3: String?
    var strFanart4: String?
    var strGender: String?
    var strLeague: String?
    var strLeagueAlternate: String?
    var strLocked: String?
    var strLogo: String?
    var strNaming: String?
    var strPoster: String?
    var strRSS: String?
    var strSport: String?
    var strTrophy: String?
    var strTwitter: String?
    var strWebsite: String?
    var strYoutube: String?
    
    
}
