; ModuleID = 'avg_double.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%lf\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"$%.2lf\0A\00", align 1

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %t = alloca i32, align 4
  %sum = alloca double, align 8
  %n = alloca double, align 8
  store i32 0, i32* %1
  store i32 12, i32* %t, align 4
  store double 0.000000e+00, double* %sum, align 8
  br label %2

; <label>:2                                       ; preds = %6, %0
  %3 = load i32* %t, align 4
  %4 = add nsw i32 %3, -1
  store i32 %4, i32* %t, align 4
  %5 = icmp ne i32 %3, 0
  br i1 %5, label %6, label %11

; <label>:6                                       ; preds = %2
  %7 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), double* %n)
  %8 = load double* %n, align 8
  %9 = load double* %sum, align 8
  %10 = fadd double %9, %8
  store double %10, double* %sum, align 8
  br label %2

; <label>:11                                      ; preds = %2
  %12 = load double* %sum, align 8
  %13 = fdiv double %12, 1.200000e+01
  store double %13, double* %sum, align 8
  %14 = load double* %sum, align 8
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), double %14)
  ret i32 0
}

declare i32 @__isoc99_scanf(i8*, ...)

declare i32 @printf(i8*, ...)
