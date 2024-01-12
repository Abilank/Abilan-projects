//
//  pdfModel.swift
//  Hiddy
//
//  Created by Sathish on 11/01/24.
//  Copyright © 2024 HITASOFT. All rights reserved.
//

import Foundation
import SwiftyJSON


class result{
    var resultArr: [pdfValueModel]!
    
    init(json: JSON!){
        if json.isEmpty{
            return
        }
        resultArr = [pdfValueModel]()
        let resultArray = json.arrayValue
        for results in resultArray{
            let value = pdfValueModel(json: results)
            resultArr.append(value)
        }
    }
    
}

class pdfValueModel{
    
    var createdAt: String!
    var title: String!
    var url: String!
    var cover: String!
    var author : String!
    var ISBN: String!
    var id: String!
    var isdownloaded : Bool!
    var fileURL: URL!
    init(json: JSON) {
        if json.isEmpty{
            return
        }
        createdAt = json["createdAt"].stringValue
        title = json["title"].stringValue
        url = json["url"].stringValue
        cover = json["cover"].stringValue
        ISBN = json["ISBN"].stringValue
        author = json["author"].stringValue
        id = json["id"].stringValue
    }
}

