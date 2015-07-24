wlite-ios
===========

Wunderlist OAuth library for iOS.

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action) [![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)

## Setup

* Create a Wunderlist Application at https://developer.wunderlist.com/apps. 
* Create an `AppConfig` using the info:
```
let appConfig = AppConfig(clientID:"**",
  clientSecret:"**",
  authCallbackUrl:"**")
```
* Create a `Wlite` context using the appConfig: `let wlite = Wlite(appConfig: appConfig)`

## Authentication

* In the App delegate, let `wlite` handle URLs:
```
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
  Wlite.handleOpenURL(url)
  return true
}
```
* Authenticate:
```
wlite.authorize({ (token) -> Void in
    // Handle auth success here
  }, failureHandler: { (error) -> Void in
    // Handle auth failure here
  })
```

## API Usage Examples

### User 

* Fetch logged in user
```
wlite.api.user.fetchLoggedInUser { (user, error) -> Void in
    if let werror = error{
      println("\(werror.type) | \(werror.message)")
    }
    else if let wuser = user {
      println("\(wuser.name) | \(wuser.email)")
    }
  }
```
