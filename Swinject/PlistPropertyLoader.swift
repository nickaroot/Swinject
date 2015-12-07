//
//  PlistPropertyLoader.swift
//  Swinject
//
//  Created by mike.owens on 12/6/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation


/// The PlistPropertyLoader will load properties from plist resources
final public class PlistPropertyLoader {
    
    /// the bundle where the resource exists (defualts to mainBundle)
    private let bundle: NSBundle
    
    /// the name of the JSON resource. For example, if your resource is "properties.json" then this value will be set to "properties"
    private let name: String
    
    ///
    /// Will create a plist property loader
    ///
    /// - parameter bundle: the bundle where the resource exists (defaults to mainBundle)
    /// - parameter name:   the name of the JSON resource. For example, if your resource is "properties.plist"
    ///                     then this value will be set to "properties"
    ///
    public init(bundle: NSBundle? = .mainBundle(), name: String) {
        self.bundle = bundle!
        self.name = name
    }
}

// MARK: - PropertyLoadable
extension PlistPropertyLoader: PropertyLoadable {
    public func load() -> [String:AnyObject]? {
        if let data: NSData = loadDataFromBundle(bundle, withName: name, ofType: "plist") {
            do {
                let plist = try NSPropertyListSerialization.propertyListWithData(data, options: .Immutable, format: nil)
                guard let props = plist as? [String:AnyObject] else {
                    fatalError("Plist must be a top level dictionary")
                }
                return props
            } catch {
                // noop
            }
        }
        return nil
    }
}
