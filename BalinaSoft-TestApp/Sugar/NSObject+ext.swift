//
//  NSObject+ext.swift
//  BalinaSoft-TestApp
//
//  Created by Максим Бриштен on 08.09.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation

extension NSObject {
	var className: String {
		return NSStringFromClass(self as! AnyClass).components(separatedBy: ".").last ?? ""
	}
	
	@nonobjc class var className: String {
		return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
	}
}
