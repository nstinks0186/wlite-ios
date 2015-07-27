wlite-ios
===========

Wunderlist OAuth library for iOS.

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action) [![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift) [![Build Status](https://travis-ci.org/nstinks0186/wlite-ios.svg?branch=master)](https://travis-ci.org/nstinks0186/wlite-ios)

## Setup

* Create a Wunderlist Application at https://developer.wunderlist.com/apps. 
* Create an `AppConfig` using the info:
```
let appConfig = AppConfig(clientID:"**",
  clientSecret:"**",
  authCallbackUrl:"**")
```
* Create a `Wlite` context using the appConfig: `let wlite = Wlite(appConfig: appConfig)`

### Auth Callback URL
* The authCallbackUrl in the `AppConfig` should match the Auth Callback URL setting in the "My Apps" settings
* The Wunderlist API does not support iOS integration right now so the Auth Callback URL should be an HTTP url. As a workaround, you can process the token in an HTTP resource and redirect the token to your app:
```
  window.location.assign(<YourAppURLSchemeHere> + "://<YourAppDomainHere>?token=" + token)
```
* Read additional info here: https://developer.wunderlist.com/documentation/concepts/authorization

## Authentication

* In the App delegate, let `wlite` handle URLs:
```
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
  wlite.handleOpenURL(url)
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
      println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
    }
    else if let wuser = user {
      println("\(wuser.name) | \(wuser.email)")
    }
  }
```

### List

* Get all lists user has permission
```
wlite.api.list.fetchLoggedInUserLists { (lists, error) -> Void in
    if let werror = error {
      println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
    }
    else if let wlists = lists{
      println("lists: \(wlists.count)")
      for list:List in wlists {
        println("  \(list.title.capitalizedString) | \(list.listType.rawValue) ")
      }
    }
  }
```
* Get a specific list
```
let listid = 32767 // id of a specific list
wlite.api.list.fetchList(listid, callback: { (list, error) -> Void in
  if let werror = error {
    println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
  }
  else if let wlist = list {
    println("list: \(wlist.id) | \(wlist.title.capitalizedString) | \(wlist.listType.rawValue) ")
  }
})
```
* Create a list
```
let newlist = List(title:"HolaMundo")
wlite.api.list.createList(newlist, callback: { (list, error) -> Void in
  if let werror = error {
    println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
  }
  else if let wlist = list {
    println("new list: \(newlist.id) | \(newlist.title.capitalizedString) | \(newlist.listType.rawValue) ")
  }
})
```
* Update a list by overwriting properties
```
// assuming updatedList is an actual list fetched from Wunderlist with id and revision values
updatedList.title = "UpdatedList"
wlite.api.list.updateList(updatedList, callback: { (list, error) -> Void in
  if let werror = error {
    println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
  }
  else if let wlist = list {
    println("updated list: \(updatedList.id) | \(updatedList.title.capitalizedString) | \(updatedList.listType.rawValue) ")
  }
})
```

