# wlite-ios

## Setup

* Create a Wunderlist Application at https://developer.wunderlist.com/apps. 
* Create an `AppConfig` using the info:
```
let appConfig = AppConfig(clientID:"71436ba1a9dc81c908f1",
  clientSecret:"0974ff4a3fbd2403522a7608c5a227e2e06f8925cdab58fd7a34f8199dc8",
  authCallbackUrl:"https://dl.dropboxusercontent.com/u/33491043/sites/wlite/success.html")
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
