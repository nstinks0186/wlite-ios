//
//  FolderRouter.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Alamofire

public enum FolderRouter: URLRequestConvertible {
    static var OAuthToken: String?
    
    case ReadFolders()
    case ReadFolderRevisions()
    case ReadFolder(String)
    case UpdateFolder(String)
    case DeleteFolder(String)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadFolders:
            return .GET
        case .ReadFolderRevisions:
            return .GET
        case .ReadFolder:
            return .GET
        case .UpdateFolder:
            return .PATCH
        case .DeleteFolder:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .ReadFolders():
            return "/folders"
        case .ReadFolderRevisions():
            return "/folder_revisions"
        case .ReadFolder(let folderid):
            return "/folders/\(folderid)"
        case .UpdateFolder(let folderid):
            return "/folders/\(folderid)"
        case .DeleteFolder(let folderid):
            return "/folders/\(folderid)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    public var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: WunderlistAPIBaseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = FolderRouter.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        default:
            return mutableURLRequest
        }
    }
}
