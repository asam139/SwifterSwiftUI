# CHANGELOG

The changelog for **SwifterSwiftUI**. Also see the [releases](https://github.com/asam139/SwifterSwiftUI/releases) on GitHub.

## Upcoming Release

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

---

## [v0.4.2](https://github.com/asam139/SwifterSwiftUI/releases/tag/0.4.2)

- **Utils**:
    - `ifLet(value:, empty:, then:)`, `ifLet(value:, empty:, then:, else:)`.  [#5](https://github.com/asam139/Steps/pull/5) by [asam139](https://github.com/asam139)
- **Optional**:
    - `isNilOrEmpty`.  [#5](https://github.com/asam139/Steps/pull/5) by [asam139](https://github.com/asam139)

## [v0.4.1](https://github.com/asam139/SwifterSwiftUI/releases/tag/0.4.1)

### Added
- **Result**
    -  `isSuccess`,  `isFailure`,  `success`,  `failure`,   `init(value:, error:)`,  `tryMap(_:)`,  `tryMapError(_:)`. [#4](https://github.com/asam139/Steps/pull/4) by [asam139](https://github.com/asam139) 
- **UserDefaultEnum**
    - Property wrapper to use the user's defaults with enum type with string raw value. [#4](https://github.com/asam139/Steps/pull/4) by [asam139](https://github.com/asam139) 
- **UserDefault**
    - Property wrapper to use the user's defaults with default types. [#4](https://github.com/asam139/Steps/pull/4) by [asam139](https://github.com/asam139) 

### Changed
- Rename **Storage** property wrapper to **UserDefault**. [#4](https://github.com/asam139/Steps/pull/4) by [asam139](https://github.com/asam139) 

## [v0.3.1](https://github.com/asam139/SwifterSwiftUI/releases/tag/0.3.1)

### Added

- **PublishedOnMain**
    - A type that publishes a property marked with an attribute received on the main thread.  [#3](https://github.com/asam139/Steps/pull/3) by [asam139](https://github.com/asam139) 
- **Storage**
    - Property wrapper to use the user's defaults. [#3](https://github.com/asam139/Steps/pull/3) by [asam139](https://github.com/asam139) 
    
## [v0.3.0](https://github.com/asam139/SwifterSwiftUI/releases/tag/0.3.0)

### Added

- **View**:
    - `bind(_:, state:)`.  [#2](https://github.com/asam139/Steps/pull/2) by [asam139](https://github.com/asam139) 
- **Subscribers.Completion**:
    - `error`.  [#2](https://github.com/asam139/Steps/pull/2) by [asam139](https://github.com/asam139) 
- **Publisher**:
    - `sink(receiveCompletion:)`, `sinkToResult(_:)`, `replaceError(_:)`, `ignoreError()`.  [#2](https://github.com/asam139/Steps/pull/2) by [asam139](https://github.com/asam139) 
- **Image**:
    - `init(_:, defaultImage:)`,  `init(_:, defaultSystemImage:)`.  [#1](https://github.com/asam139/Steps/pull/1) by [asam139](https://github.com/asam139)
- **Color**: 
    - `init?(hex:)`. [#1](https://github.com/asam139/Steps/pull/1) by [asam139](https://github.com/asam139)
- **View**:
    - `embedInNavigation()`, `bind(_:, state:)`.  [#1](https://github.com/asam139/Steps/pull/1) by [asam139](https://github.com/asam139) 

---

## [v0.2.1](https://github.com/asam139/SwifterSwiftUI/releases/tag/0.2.1)

### Added
- **LinearGradient**:
    - `eraseToAnyView()`, `if(_:, then:)`, `if(_:, then:, else:)`, `conditionalModifier(_:, modifier:)`, `conditionalModifier(_:, trueModifier:, falseModifier:)`, `animateOnAppear(using:, action:)`, `animateOnDisappear(using:, action:)`.  [#1](https://github.com/asam139/Steps/pull/1) by [asam139](https://github.com/asam139)

- **LinearGradient**:
    - `init(_:, startPoint:, endPoint)`.  [#0](https://github.com/asam139/Steps/pull/0) by [asam139](https://github.com/asam139)

- **Utils**:
    - `ifLet(value:, then:)`, `ifLet(value:, then:, else:)`.  [#0](https://github.com/asam139/Steps/pull/0) by [asam139](https://github.com/asam139)

---
