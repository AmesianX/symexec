; ModuleID = 'echo.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%c\00", align 1

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %c = alloca i8, align 1
  store i32 0, i32* %1
  br label %2

; <label>:2                                       ; preds = %5, %0
  %3 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i8* %c)
  %4 = icmp ne i32 %3, -1
  br i1 %4, label %5, label %9

; <label>:5                                       ; preds = %2
  %6 = load i8* %c, align 1
  %7 = sext i8 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32 %7)
  br label %2

; <label>:9                                       ; preds = %2
  ret i32 0
}

declare i32 @__isoc99_scanf(i8*, ...)

declare i32 @printf(i8*, ...)
