; ModuleID = 'plus.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"%d%d\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([5 x i8]* @.str, i32 0, i32 0), i32* %a, i32* %b)
  %3 = load i32* %a, align 4
  %4 = load i32* %b, align 4
  %5 = add nsw i32 %3, %4
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %5)
  ret i32 0
}

declare i32 @__isoc99_scanf(i8*, ...)

declare i32 @printf(i8*, ...)
