; ModuleID = 'pointer_array.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@my_array = global [6 x i32] [i32 1, i32 23, i32 17, i32 4, i32 -5, i32 100], align 16
@ptr = common global i32* null, align 8
@.str = private unnamed_addr constant [3 x i8] c"\0A\0A\00", align 1
@.str1 = private unnamed_addr constant [21 x i8] c"my_array[%d] = %d   \00", align 1
@.str2 = private unnamed_addr constant [15 x i8] c"ptr + %d = %d\0A\00", align 1

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %1
  store i32* getelementptr inbounds ([6 x i32]* @my_array, i32 0, i64 0), i32** @ptr, align 8
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %3

; <label>:3                                       ; preds = %20, %0
  %4 = load i32* %i, align 4
  %5 = icmp slt i32 %4, 6
  br i1 %5, label %6, label %23

; <label>:6                                       ; preds = %3
  %7 = load i32* %i, align 4
  %8 = load i32* %i, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [6 x i32]* @my_array, i32 0, i64 %9
  %11 = load i32* %10, align 4
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str1, i32 0, i32 0), i32 %7, i32 %11)
  %13 = load i32* %i, align 4
  %14 = load i32** @ptr, align 8
  %15 = load i32* %i, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds i32* %14, i64 %16
  %18 = load i32* %17
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str2, i32 0, i32 0), i32 %13, i32 %18)
  br label %20

; <label>:20                                      ; preds = %6
  %21 = load i32* %i, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, i32* %i, align 4
  br label %3

; <label>:23                                      ; preds = %3
  ret i32 0
}

declare i32 @printf(i8*, ...)
