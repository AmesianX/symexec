; ModuleID = 'array.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@billy = global [5 x i32] [i32 16, i32 2, i32 77, i32 40, i32 12071], align 16
@result = global i32 0, align 4
@n = common global i32 0, align 4
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  store i32 0, i32* @n, align 4
  br label %2

; <label>:2                                       ; preds = %12, %0
  %3 = load i32* @n, align 4
  %4 = icmp slt i32 %3, 5
  br i1 %4, label %5, label %15

; <label>:5                                       ; preds = %2
  %6 = load i32* @n, align 4
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds [5 x i32]* @billy, i32 0, i64 %7
  %9 = load i32* %8, align 4
  %10 = load i32* @result, align 4
  %11 = add nsw i32 %10, %9
  store i32 %11, i32* @result, align 4
  br label %12

; <label>:12                                      ; preds = %5
  %13 = load i32* @n, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, i32* @n, align 4
  br label %2

; <label>:15                                      ; preds = %2
  %16 = load i32* @result, align 4
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %16)
  ret i32 0
}

declare i32 @printf(i8*, ...)
