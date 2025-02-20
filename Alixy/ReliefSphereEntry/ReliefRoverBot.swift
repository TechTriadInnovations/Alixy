//
//  ReliefRoverBot.swift
//  Alixy
//
//  Created by Alixy on 2024/12/23.
//

import HandyJSON

struct ReliefRoverBot: HandyJSON {
    var botName: String = ""
    var botBio: String = ""
    var botPic: String = ""
    var botId: String = ""
    var botCreater: String = ""
    var botCreaterId: String = ""
    var trackerContent: String = ""
    var botCreaterBio: String = ""
    var trackerPics: [String] = []
    var createNumber = Int.random(in: 100_000_000...999_999_999)
    
    var trackerGender = "--"
    var trackerBirthday = "--"
    
    var botSeeCount = Int.random(in: 80..<120)
    var botCollectCount = Int.random(in: 5..<10)
    
    var botOrbs = 0
    
    var trackerNumber = 1
    var trackerFavorite = Int.random(in: 0..<10)
    var trackerFavoriteMe = Int.random(in: 0..<10)
    
    var traclerCacheImaeg:UIImage?
}


struct OrdsParams:HandyJSON {
    var ordsIDAly = ""
    var ordsQuantityAly = ""
    var ordsAmountAly = ""
}
