; ModuleID = 'out_file_call.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @greater(i32 %a, i32 %b) nounwind uwtable {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %a, i32* %2, align 4
  store i32 %b, i32* %3, align 4
  %4 = load i32* %2, align 4
  %5 = load i32* %3, align 4
  %6 = icmp sgt i32 %4, %5
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %0
  %8 = load i32* %2, align 4
  store i32 %8, i32* %1
  br label %11

; <label>:9                                       ; preds = %0
  %10 = load i32* %3, align 4
  store i32 %10, i32* %1
  br label %11

; <label>:11                                      ; preds = %9, %7
  %12 = load i32* %1
  ret i32 %12
}

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 @greater(i32 3, i32 4)
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %2)
  ret i32 0
}

declare i32 @printf(i8*, ...)
