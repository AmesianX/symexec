; ModuleID = 'method_para_int_branch.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"Positive\0A\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"Zero\0A\00", align 1
@.str2 = private unnamed_addr constant [10 x i8] c"Negative\0A\00", align 1

define i32 @branch(i32 %n) nounwind uwtable {
  %1 = alloca i32, align 4
  store i32 %n, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = icmp sgt i32 %2, 0
  br i1 %3, label %4, label %6

; <label>:4                                       ; preds = %0
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0))
  br label %18

; <label>:6                                       ; preds = %0
  %7 = load i32* %1, align 4
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %6
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0))
  br label %17

; <label>:11                                      ; preds = %6
  %12 = load i32* %1, align 4
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %14, label %16

; <label>:14                                      ; preds = %11
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i32 0, i32 0))
  br label %16

; <label>:16                                      ; preds = %14, %11
  br label %17

; <label>:17                                      ; preds = %16, %9
  br label %18

; <label>:18                                      ; preds = %17, %4
  ret i32 0
}

declare i32 @printf(i8*, ...)

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 @branch(i32 -4)
  %3 = call i32 @branch(i32 0)
  %4 = call i32 @branch(i32 6)
  ret i32 0
}
