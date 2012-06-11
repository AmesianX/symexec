; ModuleID = 'method_para_int.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"%d %d\0A\00", align 1

define i32 @branch(i32 %n, i32 %m) nounwind uwtable {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %n, i32* %1, align 4
  store i32 %m, i32* %2, align 4
  %3 = load i32* %1, align 4
  %4 = load i32* %2, align 4
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i32 0, i32 0), i32 %3, i32 %4)
  ret i32 0
}

declare i32 @printf(i8*, ...)

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 @branch(i32 4, i32 3)
  %3 = call i32 @branch(i32 0, i32 6)
  ret i32 0
}
