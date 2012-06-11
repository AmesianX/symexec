; ModuleID = 'usb_counter.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %t = alloca i32, align 4
  %n = alloca i32, align 4
  %sum = alloca i32, align 4
  %tmp = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %t)
  br label %3

; <label>:3                                       ; preds = %21, %0
  %4 = load i32* %t, align 4
  %5 = add nsw i32 %4, -1
  store i32 %5, i32* %t, align 4
  %6 = icmp ne i32 %4, 0
  br i1 %6, label %7, label %24

; <label>:7                                       ; preds = %3
  %8 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %n)
  %9 = load i32* %n, align 4
  %10 = sub nsw i32 0, %9
  %11 = add nsw i32 %10, 1
  store i32 %11, i32* %sum, align 4
  br label %12

; <label>:12                                      ; preds = %16, %7
  %13 = load i32* %n, align 4
  %14 = add nsw i32 %13, -1
  store i32 %14, i32* %n, align 4
  %15 = icmp ne i32 %13, 0
  br i1 %15, label %16, label %21

; <label>:16                                      ; preds = %12
  %17 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %tmp)
  %18 = load i32* %tmp, align 4
  %19 = load i32* %sum, align 4
  %20 = add nsw i32 %19, %18
  store i32 %20, i32* %sum, align 4
  br label %12

; <label>:21                                      ; preds = %12
  %22 = load i32* %sum, align 4
  %23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %22)
  br label %3

; <label>:24                                      ; preds = %3
  ret i32 0
}

declare i32 @__isoc99_scanf(i8*, ...)

declare i32 @printf(i8*, ...)
