//
//  File.swift
//  EG
//
//  Created by MACPRO-108 on 16/12/23.
//

import Foundation
import Alamofire
import SwiftyJSON
class baseserviceclass {
    
//let shared = baseserviceclass()
    
    func getdetails(url: String, onsucess success :@escaping(JSON) -> Void, onFailure failure: @escaping(_ error: Error?) -> Void) -> Void {
        let baseurl = URL(string: url)
//        AF.request(baseurl!, method: .get).response(completionHandler: {response in
//            let JSON = JSON(response)
//                switch response.result {
//                case .success:
//                    print("qwerty RESPONSE SUCCESS for \(String(describing: baseurl)): \(response)")
//                    success(JSON)
//                case .failure(let error):
//                    print("qwerty FAILURE RESPONSE for \(String(describing: baseurl)): \(error.localizedDescription)")
//                    if error._code == NSURLErrorTimedOut{
//                        failure(error)
//                    }else if error._code == NSURLErrorNotConnectedToInternet{
//                        failure(error)
//                    }else{
//                        failure(error)
//                    }
//                }
//            
//            
//        })
        
        AF.request(baseurl!,method: .get).responseJSON(completionHandler: {response in
//            let JSON = JSON(data: response.result)
                switch response.result {
                case .success(let value):
                            let json = JSON(value)

//                    print("qwerty RESPONSE SUCCESS for \(String(describing: baseurl)): \(json)")
                    success(json)
                case .failure(let error):
                    print("qwerty FAILURE RESPONSE for \(String(describing: baseurl)): \(error.localizedDescription)")
                    if error._code == NSURLErrorTimedOut{
                        failure(error)
                    }else if error._code == NSURLErrorNotConnectedToInternet{
                        failure(error)
                    }else{
                        failure(error)
                    }
                }
            
            
        })
        
        
        
        
    }
    
    
    
}
