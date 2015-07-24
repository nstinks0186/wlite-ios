//
//  Error.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation

enum ErrorAuthentication : String {
    case Missing = "missing"
    case Undefined = ""
}

enum ErrorMessage : String {
    case UnknownServerError = "An unknown server error occurred"
    case Undefined = ""
}

enum ErrorTranslationKey : String {
    case APIErrorUnknown = "api_error_unknown"
    case Undefined = ""
}

enum ErrorType : String {
    case ServerError = "server_error"
    case Undefined = ""
}

public class Error {
    var authentication = [ErrorAuthentication]()
    var translationKey = ErrorTranslationKey.Undefined
    var message = ErrorMessage.Undefined
    var type = ErrorType.Undefined
    
    public var isAuthenticationError : Bool {
        get {
            return (authentication.first == ErrorAuthentication.Missing
                && translationKey == ErrorTranslationKey.APIErrorUnknown
                && message == ErrorMessage.UnknownServerError
                && type == ErrorType.ServerError )
        }
    }
    
    init(authentication:[ErrorAuthentication], translationKey:ErrorTranslationKey, message:ErrorMessage, type:ErrorType){
        self.authentication = authentication
        self.translationKey = translationKey
        self.message = message
        self.type = type
    }
    
    public convenience init(rawError:[String:AnyObject]){
        let rawauthentication = rawError["authentication"] as! NSArray
        var authentication = [ErrorAuthentication]()
        for auth in rawauthentication {
            authentication.append((auth as! String == "missing" ? .Missing : .Undefined))
        }
        
        let rawtranslationKey = rawError["translation_key"] as! NSString
        let translationKey = (rawtranslationKey as! String == "api_error_unknown" ? ErrorTranslationKey.APIErrorUnknown : ErrorTranslationKey.Undefined)
        
        let rawmessage = rawError["message"] as! NSString
        let message = (rawmessage as! String == "An unknown server error occurred" ? ErrorMessage.UnknownServerError : ErrorMessage.Undefined)
        
        let rawtype = rawError["type"] as! NSString
        let type = (rawtype as! String == "server_error" ? ErrorType.ServerError : ErrorType.Undefined)
        
        self.init(authentication:authentication, translationKey:translationKey, message:message, type:type)
    }
}
