; ModuleID = 'pointer.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"x is %d\0A\00", align 1
@.str1 = private unnamed_addr constant [10 x i8] c"*p is %d\0A\00", align 1

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 8
  store i32 0, i32* %1
  store i32* %x, i32** %p, align 8
  %2 = load i32** %p, align 8
  store i32 0, i32* %2
  %3 = load i32* %x, align 4
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i32 0, i32 0), i32 %3)
  %5 = load i32** %p, align 8
  %6 = load i32* %5
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str1, i32 0, i32 0), i32 %6)
  %8 = load i32** %p, align 8
  %9 = load i32* %8
  %10 = add nsw i32 %9, 1
  store i32 %10, i32* %8
  %11 = load i32* %x, align 4
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i32 0, i32 0), i32 %11)
  %13 = load i32** %p, align 8
  %14 = load i32* %13
  %15 = add nsw i32 %14, 1
  store i32 %15, i32* %13
  %16 = load i32* %x, align 4
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i32 0, i32 0), i32 %16)
  ret i32 0
}

declare i32 @printf(i8*, ...)
