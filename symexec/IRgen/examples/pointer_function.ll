; ModuleID = 'pointer_function.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define void @my_int_func(i32 %x) nounwind uwtable {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %2)
  ret void
}

declare i32 @printf(i8*, ...)

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %foo = alloca void (i32)*, align 8
  store i32 0, i32* %1
  store void (i32)* @my_int_func, void (i32)** %foo, align 8
  %2 = load void (i32)** %foo, align 8
  call void %2(i32 2)
  %3 = load void (i32)** %foo, align 8
  call void %3(i32 2)
  ret i32 0
}
