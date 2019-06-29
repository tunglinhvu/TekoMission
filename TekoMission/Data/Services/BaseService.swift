//
//  BaseService.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import Alamofire

typealias ResponseHandler = (_ data: AnyObject, _ responseType: TMResponseType) -> Void

enum TMResponseType: CustomStringConvertible {
    case undefined
    case success
    case serverError
    case requestFailed

    var description: String {
        switch self {
        case .undefined:
            return "Lỗi không xác định"
        case .success:
            return "Kết nối thành công"
        case .serverError:
            return "Lỗi kết nối đến server"
        case .requestFailed:
            return "Lỗi kết nối đến server"
        }
    }
}

enum TMCode: Int {
    case nemo = -1
    case success = 0
    case failed = 1
    case tokenRequired = 2
    case tokenExpired = 3
    case refreshToken = 4
    case unknownError = 5
    case missingParams = 6
    case validateFailed = 7

    init(code: Int) {
        switch code {
        case 0:
            self = .success
        case 1:
            self = .failed
        case 2:
            self = .tokenRequired
        case 3:
            self = .tokenExpired
        case 4:
            self = .refreshToken
        case 5:
            self = .unknownError
        case 6:
            self = .missingParams
        case 7:
            self = .validateFailed
        default:
            self = .nemo
        }
    }
}

struct TMResponseResult {
    var code: TMCode
    var description: String?
}

class BaseService: NSObject {

    /**
     make API call with HTTP Methods GET

     - returns:
     void

     - Parameters:
     + service: name of service
     + parameters: parameters of request
     + token: user's token
     + completion: block to handle response

     */
    func get(service: String, parameters: [String: Any], hasToken: Bool, completion: @escaping ResponseHandler) {
        let fullUrl = APIDefine.BaseUrlAPI + service
        var headers: [String: String]
        if hasToken {
            let token = ""
            headers = [
                "Accept": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        } else {
            headers = ["Accept": "application/json"]
        }

        Alamofire.request(fullUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            print(response.request ?? "")  // original URL request
            // print(response.response ?? "") // URL response
            // print(response.data ?? "")     // server data
            // print(response.result)   // result of response serialization

            if let data = response.result.value, let statusCode = response.response?.statusCode {
                if statusCode == 200 {
                    completion(data as AnyObject, .success)
                } else {
                    completion("" as AnyObject, .requestFailed)
                }
            } else {
                completion("" as AnyObject, .serverError)
            }
        }
    }
}
