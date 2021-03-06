//===--- DictionaryLiteral.swift ------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
// RUN: %target-run-simple-swift
// REQUIRES: executable_test

// REQUIRES: objc_interop

import SwiftExperimental
import Foundation
import StdlibUnittest

// Also import modules which are used by StdlibUnittest internally. This
// workaround is needed to link all required libraries in case we compile
// StdlibUnittest with -sil-serialize-all.
import SwiftPrivate
#if _runtime(_ObjC)
import ObjectiveC
#endif

// Check that the generic parameters are called 'Key' and 'Value'.
protocol TestProtocol1 {}

extension DictionaryLiteral where Key : TestProtocol1, Value : TestProtocol1 {
  var _keyAndValueAreTestProtocol1: Bool {
    fatalError("not implemented")
  }
}

var strings: DictionaryLiteral = ["a": "1", "b": "Foo"]
expectType(DictionaryLiteral<String, String>.self, &strings)

var stringNSStringLiteral: DictionaryLiteral = [
  "a": "1", "b": "Foo" as NSString]
expectType(DictionaryLiteral<String, NSString>.self, &stringNSStringLiteral)

let aString = "1"
let anNSString = "Foo" as NSString
var stringNSStringLet: DictionaryLiteral = [ "a": aString, "b": anNSString]
expectType(DictionaryLiteral<String, NSString>.self, &stringNSStringLet)

var hetero1: DictionaryLiteral = ["a": 1, "b": "Foo" as NSString]
expectType(DictionaryLiteral<String, NSObject>.self, &hetero1)

var hetero2: DictionaryLiteral = ["a": 1, "b": "Foo"]
expectType(DictionaryLiteral<String, NSObject>.self, &hetero2)
