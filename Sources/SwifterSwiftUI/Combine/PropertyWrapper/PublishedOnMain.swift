//
//  PublishedOnMain.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 03/05/2020.
//

import Foundation
import Combine

/// A type that publishes a property marked with an attribute received on the main thread
///
/// Example:
/// ```
/// // View Model
/// struct ViewModel {
///    @PublishedOnMain var name: String = "Anonymous"
/// }
///
/// // View
/// viewModel.$name.assign(to: \.text, on: nameLabel)
///
/// ```
/// Adding the attribute @PublishedOnMain the property can be assigned directly to UI components.
///
@propertyWrapper public class PublishedOnMain<Value> {
  @Published var value: Value

  public var wrappedValue: Value {
    get { value }
    set { value = newValue }
  }

  public var projectedValue: AnyPublisher<Value, Never> {
    return $value
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  public init(wrappedValue initialValue: Value) {
    value = initialValue
  }
}
