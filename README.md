# Lilo

Lilo (Little Loader) is a lightweight and simple loading overlay for iOS. There are no frills, dependencies, animations (other than the built in UIActivityIndicatorView), or bloat. It adds an overlay directly to the UIWindow so you don't have to manually block navigation or user interaction.

### Preview
![Alt Text](https://github.com/laferil/Lilo/raw/master/demo.gif)

### Showing/Hiding
It's as simple as this:
```swift
import Lilo

Lilo.show()
// Do some stuff
Lilo.hide()
```

### Customization
If you need a little bit extra there are some config options you can use. These are the default values when calling `Lilo.show()`.
```swift
Lilo.show(loaderStyle: .solid(.systemBackground), 
          cornerStyle: .rounded(16), 
          backgroundStyle: .translucent(.black), 
          width: 75, 
          height: 75, 
          animated: true)
```

#### Swift Package Manager (SPM)

In an effort to be as light as possible only Swift Package Manager is supported. Everything else is a little too heavy for something like this. To integrate using Xcode:

File -> Swift Packages -> Add Package Dependency...

Enter package URL : https://github.com/laferil/Lilo, and select the latest release.
