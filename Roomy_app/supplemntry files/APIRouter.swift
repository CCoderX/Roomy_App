//
//  APIRouter.swift
//  Roomy_app
//
//  Created by user on 7/25/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getAllRooms([String: String])
    case signIn([String: Any])
    case signUp([String: Any])
    case addRoom([String: Any])
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getAllRooms:
                return .get
            case .signIn,.signUp,.addRoom:
                return .post
            }
        }
        
        let parameters: ([String: Any]?) = {
            switch self {
            case .signIn(let headers),.signUp(let headers),.addRoom(let headers):
                return (headers)
            case .getAllRooms( _):
                return nil           
            }
        }()
        let headers: (HTTPHeaders?) = {
            switch self{
            case .getAllRooms(let headers):
                return HTTPHeaders(headers)
            default:
                return nil
            }
        }()
        let url: URL = {
            
            let URLstring : String = {
                switch self {
                case .addRoom( _):
                    return URLs.AddRoomURL
                case .signIn( _):
                    return URLs.loginURL
                case .signUp( _):
                    return URLs.SignUpURL
                case .getAllRooms:
                    return URLs.GetImagesURL
                    
                }
            }()
            
            return URL(string: URLstring)!
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
    
        urlRequest.headers = headers ?? urlRequest.headers
        
        let encoding: ParameterEncoding = {
            switch self {
            case .getAllRooms(let params):
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
            //return JSONEncoding.default
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
