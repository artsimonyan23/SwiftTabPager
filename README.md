# SwiftTabPager

<p align="center">
    <img src="https://github.com/artsimonyan23/SwiftTabPager/blob/master/Screenshots/screenshot.png"
      width=300 height=50>
</p>

[![CI Status](http://img.shields.io/travis/artsimonyan23/SwiftTabPager.svg?style=flat)](https://travis-ci.org/artsimonyan23/SwiftTabPager)
[![Version](https://img.shields.io/cocoapods/v/SwiftTabPager.svg?style=flat)](https://cocoapods.org/pods/SwiftTabPager)
[![License](https://img.shields.io/cocoapods/l/SwiftTabPager.svg?style=flat)](https://github.com/artsimonyan23/SwiftTabPager/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/SwiftTabPager.svg?style=flat)](https://cocoapods.org/pods/SwiftTabPager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SwiftTabPager into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'SwiftTabPager'
```

Then, run the following command:

```bash
$ pod install
```


### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate SwiftTabPager into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "artsimonyan23/SwiftTabPager"
```

Run `carthage update` to build the framework and drag the built `SwiftTabPager`.framework into your Xcode project.


## Usage

<img src="https://github.com/artsimonyan23/SwiftTabPager/blob/master/Screenshots/storyboard.png"
  width=800 height=500>
  
  Create TabPage view from Stroryboard or by code and set it. Call setTitles function and set Titles by array and closure which gave you selected index. 
  See example in project.
  <img src="https://github.com/artsimonyan23/SwiftTabPager/blob/master/Screenshots/examples.png"
  width=200 height=432>

## Author

Arthur Simonyan


## License

SwiftTabPager is available under the MIT license. See the LICENSE file for more info.
