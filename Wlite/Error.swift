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

enum ErrorRevision : String {
    case Required = "required"
    case Undefined = ""
}

public enum ErrorMessage : String {
    case UnknownServerError = "An unknown server error occurred"
    case MissingParameterError = "Missing parameter."
    case Undefined = ""
}

public enum ErrorTranslationKey : String {
    case APIErrorUnknown = "api_error_unknown"
    case APIErrorMissingParams = "api_error_missing_params"
    case Undefined = ""
}

public enum ErrorType : String {
    case ServerError = "server_error"
    case MissingParameter = "missing_parameter"
    case Undefined = ""
}

public class Error {
    var authentication = [ErrorAuthentication]()
    public var translationKey = ErrorTranslationKey.Undefined
    public var message = ErrorMessage.Undefined
    public var type = ErrorType.Undefined
    
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
        println("raw error: \(rawError)")
        
        var authentication = [ErrorAuthentication]()
        if  let rawauthentication = rawError["authentication"] as? NSArray {
            for auth in rawauthentication {
                if let errorAuth = ErrorAuthentication(rawValue: auth as! String) {
                    authentication.append(errorAuth)
                }
            }
        }
        
        var translationKey = ErrorTranslationKey.Undefined
        if let rawtranslationKey = rawError["translation_key"] as? NSString {
            if let tempTranslationKey = ErrorTranslationKey(rawValue: rawtranslationKey as! String) {
                translationKey = tempTranslationKey
            }
        }
        
        var message = ErrorMessage.Undefined
        if let rawmessage = rawError["message"] as? NSString {
            if let tempMessage = ErrorMessage(rawValue: rawmessage as! String) {
                message = tempMessage
            }
        }
        
        var type = ErrorType.Undefined
        if let rawtype = rawError["type"] as? NSString {
            if let tempType = ErrorType(rawValue: rawtype as! String) {
                type = tempType
            }
        }
        
        self.init(authentication:authentication, translationKey:translationKey, message:message, type:type)
    }
}
