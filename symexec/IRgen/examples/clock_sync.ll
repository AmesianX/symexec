; ModuleID = 'clock_sync.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"%d:%d\00", align 1
@.str2 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %t = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %t)
  br label %3

; <label>:3                                       ; preds = %22, %0
  %4 = load i32* %t, align 4
  %5 = add nsw i32 %4, -1
  store i32 %5, i32* %t, align 4
  %6 = icmp ne i32 %4, 0
  br i1 %6, label %7, label %25

; <label>:7                                       ; preds = %3
  %8 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0), i32* %a, i32* %b)
  %9 = load i32* %b, align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %12

; <label>:11                                      ; preds = %7
  store i32 0, i32* %a, align 4
  br label %22

; <label>:12                                      ; preds = %7
  %13 = load i32* %a, align 4
  %14 = icmp sgt i32 %13, 12
  br i1 %14, label %15, label %18

; <label>:15                                      ; preds = %12
  %16 = load i32* %a, align 4
  %17 = sub nsw i32 %16, 12
  store i32 %17, i32* %a, align 4
  br label %21

; <label>:18                                      ; preds = %12
  %19 = load i32* %a, align 4
  %20 = add nsw i32 %19, 12
  store i32 %20, i32* %a, align 4
  br label %21

; <label>:21                                      ; preds = %18, %15
  br label %22

; <label>:22                                      ; preds = %21, %11
  %23 = load i32* %a, align 4
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %23)
  br label %3

; <label>:25                                      ; preds = %3
  ret i32 0
}

declare i32 @__isoc99_scanf(i8*, ...)

declare i32 @printf(i8*, ...)
