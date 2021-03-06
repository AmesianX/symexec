; ModuleID = 'mul_add.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

define i32 @mul_add(i32 %x, i32 %y, i32 %z) nounwind uwtable {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  store i32 %y, i32* %2, align 4
  store i32 %z, i32* %3, align 4
  %4 = load i32* %1, align 4
  %5 = load i32* %2, align 4
  %6 = mul nsw i32 %4, %5
  %7 = load i32* %3, align 4
  %8 = add nsw i32 %6, %7
  ret i32 %8
}
