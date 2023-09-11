//
//  Image+Extensions.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 26/04/2020.
//

import SwiftUI

public extension Image {
    /// Sets the mode by which SwiftUI resizes an image to fit its space and scales to fit its frame:
    ///
    ///     let image = Image(systemName: "bandage.fill").fit()
    ///
    /// - Returns: An image, with the new resizing behavior set and that constrains its view’s dimensions to the fit aspect ratio
    @inlinable func fit() -> some View {
        resizable().aspectRatio(contentMode: .fit)
    }
}

#if canImport(UIKit)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension Image {
    /// Create a image with default one
    ///
    ///     let image = Image("photo", defaultImage: "empty-photo")
    ///
    /// - Parameters:
    ///   - name: Image name
    ///   - defaultImage: Default image name
    /// - Returns: A new image
    @inlinable init(_ name: String, defaultImage: String) {
        if let img = UIImage(named: name) {
            self.init(uiImage: img)
        } else {
            self.init(defaultImage)
        }
    }

    /// Create a image with default one
    ///
    ///     let image = Image("photo", defaultSystemImage: "bandage.fill")
    ///
    /// - Parameters:
    ///   - name: Image name
    ///   - defaultSystemImage: Default  system image name
    /// - Returns: A new image
    @available(OSX 10.15, *)
    @inlinable init(_ name: String, defaultSystemImage: String) {
        if let img = UIImage(named: name) {
            self.init(uiImage: img)
        } else {
            self.init(systemName: defaultSystemImage)
        }
    }
}
#endif

#if canImport(AppKit)
@available(OSX 10.15, *)
public extension Image {
    /// Create a image with default one
    ///
    ///     let image = Image("photo", defaultImage: "empty-photo")
    ///
    /// - Parameters:
    ///   - name: Image name
    ///   - defaultImage: Default image name
    /// - Returns: A new image
    @inlinable init(_ name: String, defaultImage: String) {
        if let img = NSImage(named: name) {
            self.init(nsImage: img)
        } else {
            self.init(defaultImage)
        }
    }
}
#endif
