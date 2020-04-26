//
//  Image+Extensions.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 26/04/2020.
//

import SwiftUI

//extension Image {
//    /// Create a image with default one
//    ///
//    ///    let image = Image("photo", defaultImage: "empty-photo")
//    ///
//    /// - Parameters:
//    ///   - name: Image name
//    ///   - defaultImage: Default image name
//    /// - Returns: A new image
//    init(_ name: String, defaultImage: String) {
//        #if canImport(UIKit)
//        if let img = UIImage(named: name) {
//            self.init(uiImage: img)
//        } else {
//            self.init(defaultImage)
//        }
//        #else
//        if let img = NSImage(named: name) {
//            self.init(nsImage: img)
//        } else {
//            self.init(defaultImage)
//        }
//        #endif
//    }
//}
//
//#if canImport(UIKit)
//extension Image {
//    /// Create a image with default one
//    ///
//    ///    let image = Image("photo", defaultSystemImage: "bandage.fill")
//    ///
//    /// - Parameters:
//    ///   - name: Image name
//    ///   - defaultSystemImage: Default  system image name
//    /// - Returns: A new image
//    @available(OSX 10.15, *)
//    init(_ name: String, defaultSystemImage: String) {
//        if let img = UIImage(named: name) {
//            self.init(uiImage: img)
//        } else {
//            self.init(systemName: defaultSystemImage)
//        }
//    }
//}
//#endif