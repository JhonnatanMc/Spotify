//
//  HTTPServices.swift
//  Spotify
//
//  Created by Jhonnatan Macias on 7/11/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Alamofire
import Foundation

open class HTTPService {
    
    class func search(_ textSearch : String, successCallback : @escaping (Data?, Int) -> Void) -> Void {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json",
            "Authorization": "Bearer BQAoMgqHJkmonpfWFQ83tmglD9f2SqBfrlQ3OIIROb8cWVTlIAvu4yYlm511VnjQWP6dIrR-XOO4a2ghy0FNAQPyJYa2MCAXfU7bfxVIexOSFts4IVs_DOZ3F2DRq8BdMI3DCRS50sgqryKR3ms5t7k-8Q"
        ]
        
        Alamofire.request(Environment.BASE_SEARCH_URL + textSearch + "&type=artist&offset=0", method: .get, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            if response.response?.statusCode == nil{
                successCallback(nil, 0)
            }else{
                if response.response?.statusCode == 200 && response.data != nil{
                    successCallback(response.data!, 200)
                } else {
                    if response.data != nil{
                        successCallback(response.data!, response.response!.statusCode)
                    } else {
                        if response.response?.statusCode == 404 && response.data != nil{
                            successCallback(nil, response.response!.statusCode)
                        }
                    }
                }
            }
        }
    }
    
}
