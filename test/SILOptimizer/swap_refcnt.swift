// RUN: %target-swift-frontend -O -emit-sil %s | FileCheck %s

// Make sure we can swap two values in an array without retaining anything.

//CHECK-LABEL: _TF11swap_refcnt11swapByIndex
//CHECK-NOT: strong_retain
//CHECK-NOT: strong_release
//CHECK: return
public func swapByIndex(A: inout [Int8], x : Int, y : Int) {
  swap(&A[x],&A[y])
}

