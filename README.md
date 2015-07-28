wlite-ios
===========

Wunderlist OAuth library for iOS.

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action) [![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift) [![Build Status](https://travis-ci.org/nstinks0186/wlite-ios.svg?branch=master)](https://travis-ci.org/nstinks0186/wlite-ios) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Installation

### Carthage 

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application. (See Carthage installation instruction [here](https://github.com/Carthage/Carthage#installing-carthage).)

To integrate Wlite using Carthage, specify it in your Cartfile:
```
github "nstinks0186/wlite-ios"
```

### Manually

To integrate Wlite manually, you can clone the project and run it manually:
```
git clone https://github.com/nstinks0186/wlite-ios.git
```

Running the Wlite project should create Wlite.framework. You can then add that framework to your project.

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
wlite.authorize { (token) -> Void in
  // Handle auth success here
}, failureHandler: { (error) -> Void in
  // Handle auth failure here
}
```

### Access Token

After a successful authentication, the access token is saved in the user defaults. For convenience, you can access the token using the following code:
```
App.wlite.accessToken
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
let list = List(id: 141552880)
wlite.api.list.fetchList(list) { (_, error)  in
  if let werror = error {
    println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
  }
  else {
    println("fetched list: \(list.id) | \(list.title)")
  }
}
```
* Create a list
```
let newlist = List(title:"NewList")
wlite.api.list.createList(newlist) { (_, error)  in
  if let werror = error {
    println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
  }
  else {
      println("new list: \(newlist.id) | \(newlist.title.capitalizedString) | \(newlist.listType.rawValue) ")
  }
}
```
* Update a list by overwriting properties
```
// assuming updatedList is an actual list fetched from Wunderlist with id and revision values
updatedList.title = "UpdatedList"
wlite.api.list.updateList(updatedList) { (list, error) -> Void in
  if let werror = error {
    println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
  }
  else if let wlist = list {
    println("updated list: \(updatedList.id) | \(updatedList.title.capitalizedString) | \(updatedList.listType.rawValue) ")
  }
}
```

### Task

* Create a task
```
let list = List(id: 104379923)
let newtask = Task(title: "blah")
wlite.api.task.createTask(newtask, forList: list) { (task, error) -> Void in
    if let werror = error {
      println("error: \(werror.type.rawValue) | \(werror.message.rawValue)")
    }
    else {
      println("new task: \(newtask.id) | \(newtask.title)")
    }
}
```

