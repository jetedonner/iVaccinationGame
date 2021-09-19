//
//  CGFloatValueTransformer.swift
//  CGFloatValueTransformer
//
//  Created by Kim David Hauser on 18.09.21.
//

import Foundation
import Cocoa

extension NSValueTransformerName {
    static let myCGFloatValueTransformer = NSValueTransformerName( rawValue: "CGFloatValueTransformer")
}

extension CGFloat {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class CGFloatValueTransformer: ValueTransformer {
    
    override func valueClassForBinding(_ binding: NSBindingName) -> AnyClass? {
        return Optional<CGFloat>.self as! AnyClass
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        return (value as! CGFloat).rounded(toPlaces:2)
    }
}
