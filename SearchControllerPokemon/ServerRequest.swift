//
//  ServerRequest.swift
//  SuperHero App Zoho Assignment
//
//  Created by Dhruvil Patel on 02/03/21.
//  Copyright © 2021 Dhruvil Patel. All rights reserved.
//

import Foundation
import Alamofire

class ServerRequest: NSObject {
    
    class func postcall(url : URL, httpMethod : HTTPMethod, params : [String: Any]?,completion:@escaping (_ success: [String:Any]?,_ failure : Error?)->()) {
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json",
//            "Authorization":authorization
        ]
       
        Alamofire.request(url, method:httpMethod , parameters: params, encoding: JSONEncoding.default).responseJSON {response in
            if (response.result.error != nil) {
                completion(nil,response.result.error)
            }else{
                if let value = response.result.value {
                    if (response.response?.statusCode  == error.OkResponse.rawValue)
                    {
                        guard let jsonDict = value as? [String:Any] else {
                            completion(nil,error.unKnown)
                            return
                        }
                        completion(jsonDict,nil)
                    }else{
                        if response.response?.statusCode == error.Unauthorised.rawValue{
                            completion(nil,error.Unauthorised)
                        }else if response.response?.statusCode == error.Unavilable.rawValue{
                            completion(nil,error.Unavilable)
                        }else{
                            completion(nil,error.unKnown)
                        }
                    }
                }
            }
        }
    }
    enum error: Int, Error {
        case Unauthorised = 401
        case OkResponse = 200
        case Unavilable = 404
        case unKnown
    }
}
