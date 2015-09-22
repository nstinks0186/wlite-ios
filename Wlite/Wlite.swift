//
//  Wlite.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire

internal let WunderlistAPIBaseURL = "https://a.wunderlist.com/api/v1"
internal let UserDefaultsAuthTokenKey = "com.wlite.userdefaults.auth.accessToken"

public typealias AuthorizeSuccessHandler = (token: String) -> Void
public typealias AuthorizeFailureHandler = (error: NSError) -> Void

public class Wlite {
    public let api: API = API()
    
    private var appConfig: AppConfig
    
    private var authSuccessHandler: AuthorizeSuccessHandler?
    private var authFailureHandler: AuthorizeFailureHandler?
    
    /**
        The access token string for logged in session.
        
        - returns: The access token if there is a valid session.
    */
    
    public var accessToken : String? {
        get {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            return userDefaults.stringForKey(UserDefaultsAuthTokenKey)
        }
    }
    
    internal class func updateAccessToken(token:String?) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(token, forKey: UserDefaultsAuthTokenKey)
        userDefaults.synchronize()
    }
    
    public init(appConfig:AppConfig){
        self.appConfig = appConfig
        
        if let token = accessToken {
            updateRoutersToken(token)
            updateRoutersClientId(appConfig.clientID)
            
            // check if token is valid
            self.api.user.fetchLoggedInUser { (user, error) -> Void in
                
            }
        }
    }
    
    // MARK: - Auth Methods
    
    public func authorize(successHandler:AuthorizeSuccessHandler, failureHandler:AuthorizeFailureHandler) {
        authSuccessHandler = successHandler
        authFailureHandler = failureHandler
        
        if (accessToken != nil) {
            successHandler(token: accessToken!)
        }
        else {
            let oauthswift = OAuth2Swift(consumerKey: appConfig.clientID,
                consumerSecret: appConfig.clientSecret,
                authorizeUrl: "https://www.wunderlist.com/oauth/authorize",
                accessTokenUrl: "https://www.wunderlist.com/oauth/access_token",
                responseType: "token")
            oauthswift.authorizeWithCallbackURL( NSURL(string: appConfig.authCallbackUrl)!,
                scope: "",
                state: "com.wlite.oauth.state",
                success: {
                    credential, response, parameters in
                    // this is actually useless
                    print("success: \(credential) ; \(response) ; \(parameters)")
                },
                failure: {
                    (error:NSError!) -> Void in
                    // this is actually useless
                    print(error.localizedDescription)
            })
        }
        
        
    }
    
    public func handleOpenURL(url: NSURL) {
        if (url.host == "wlite") {
            let queryItem = url.queryItemForKey("token")
            if let token = queryItem!.value{
                Wlite.updateAccessToken(token)
                
                updateRoutersToken(token)
                updateRoutersClientId(appConfig.clientID)
                
                authSuccessHandler?(token: token)
            }
            else {
                // TODO: improve this shit
                print("Authentication failed. Unknown error occured.")
                print("url: \(url)")
//                authFailureHandler?(error: NSNull())
            }
        }else {
            print("Authentication failed. Unknown error occured.")
            print("url: \(url)")
        }
    }
    
    // MARK: - Private helper methods
    
    private func updateRoutersClientId(clientID:String) {
        AvatarRouter.ClientID = clientID
        FolderRouter.ClientID = clientID
        ListRouter.ClientID = clientID
        TaskRouter.ClientID = clientID
        UserRouter.ClientID = clientID
    }
    
    private func updateRoutersToken(token:String) {
        AvatarRouter.OAuthToken = token
        FolderRouter.OAuthToken = token
        ListRouter.OAuthToken = token
        TaskRouter.OAuthToken = token
        UserRouter.OAuthToken = token
    }
    
    private func clearRoutersToken(){
        AvatarRouter.OAuthToken = nil
        FolderRouter.OAuthToken = nil
        ListRouter.OAuthToken = nil
        TaskRouter.OAuthToken = nil
        UserRouter.OAuthToken = nil
    }
    
}

extension NSURL {
    var allQueryItems: [NSURLQueryItem] {
        get {
            let components = NSURLComponents(URL: self, resolvingAgainstBaseURL: false)!
            let allQueryItems = components.queryItems!
            return allQueryItems 
        }
    }
    
    func queryItemForKey(key: String) -> NSURLQueryItem? {
        
        let predicate = NSPredicate(format: "name=%@", key)
        return (allQueryItems as NSArray).filteredArrayUsingPredicate(predicate).first as? NSURLQueryItem
    }
}
