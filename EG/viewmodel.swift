//
//  viewmodel.swift
//  EG
//
//  Created by MACPRO-108 on 16/12/23.
//

import Foundation
import SwiftyJSON

class viewmodelcontroller {
    
    let service = baseserviceclass()
    var status = Bool()
    
    func getmodelconstrutions(url : String, onsucess success : @escaping(result) -> Void, onfailure failure : @escaping(String) -> Void) -> Void {
        
        service.getdetails(url: url, onsucess: { sucess in
            print("qwerty sucess",sucess)
            let value = JSON(sucess)
            let rootclass = result(json: value)
            success(rootclass)
        }, onFailure: { error in
            failure(error.debugDescription)
        })
        
    }
    
    
}


