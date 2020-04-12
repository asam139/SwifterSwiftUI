<p align="center">
  <img src="https://raw.githubusercontent.com/asam139/SwifterSwiftUI/master/Assets/logo.png" title="swifterswiftui" width="300">
</p>

[![Build Status](https://github.com/asam139/SwifterSwiftUI/workflows/SwifterSwiftUI/badge.svg?branch=master)](https://github.com/asam139/SwifterSwiftUI/actions)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20Linux-lightgrey.svg)](https://github.com/asam139/SwifterSwiftUI)
[![Cocoapods](https://img.shields.io/cocoapods/v/SwifterSwiftUI.svg)](https://cocoapods.org/pods/SwifterSwiftUI)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)
[![codecov](https://codecov.io/gh/asam139/SwifterSwiftUI/branch/master/graph/badge.svg)](https://codecov.io/gh/asam139/SwifterSwiftUI)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

SwifterSwiftUI is a collection of native SwiftUI extensions, with handy methods, syntactic sugar, and performance improvements for wide range of SwiftUI classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.

## Requirements

- **iOS** 10.0+ / **tvOS** 9.0+ / **watchOS** 2.0+ / **macOS** 10.10+ / **Ubuntu** 14.04+
- Swift 5.0+

## Installation

<details>
<summary>CocoaPods</summary>
</br>
<p>To integrate SwifterSwiftUI into your Xcode project using <a href="http://cocoapods.org">CocoaPods</a>, specify it in your <code>Podfile</code>:</p>

<pre><code class="ruby language-ruby">pod 'SwifterSwiftUI'</code></pre>
</details>

<details>
<summary>Swift Package Manager</summary>
</br>
<p>You can use <a href="https://swift.org/package-manager">The Swift Package Manager</a> to install <code>SwifterSwiftUI</code> by adding the proper description to your <code>Package.swift</code> file:</p>

<pre><code class="swift language-swift">import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/asam139/SwifterSwiftUI.git", from: "1.0.0")
    ]
)
</code></pre>

<p>Next, add <code>SwifterSwiftUI</code> to your targets dependencies like so:</p>
<pre><code class="swift language-swift">.target(
    name: "YOUR_TARGET_NAME",
    dependencies: [
        "SwifterSwiftUI",
    ]
),</code></pre>
<p>Then run <code>swift package update</code>.</p>
</details>



<details>
<summary>Manually</summary>
</br>
<p>Add the SwifterSwiftUI project to your Xcode project</p>
</details>

## Example


## Get involved

We want your feedback.
Please refer to [contributing guidelines](https://github.com/asam139/SwifterSwiftUI/tree/master/CONTRIBUTING.md) before participating.

## Thanks

Special thanks to:

- Hoping new contributors

## License

SwifterSwiftUI is released under the MIT license. See [LICENSE](https://github.com/asam139/SwifterSwiftUI/blob/master/LICENSE) for more information.
