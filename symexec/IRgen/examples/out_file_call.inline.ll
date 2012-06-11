; ModuleID = 'out_file_call.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @greater(i32 %a, i32 %b) nounwind uwtable {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %a, i32* %2, align 4
  store i32 %b, i32* %3, align 4
  %4 = load i32* %2, align 4
  %5 = load i32* %3, align 4
  %6 = icmp sgt i32 %4, %5
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %0
  %8 = load i32* %2, align 4
  store i32 %8, i32* %1
  br label %11

; <label>:9                                       ; preds = %0
  %10 = load i32* %3, align 4
  store i32 %10, i32* %1
  br label %11

; <label>:11                                      ; preds = %9, %7
  %12 = load i32* %1
  ret i32 %12
}

define i32 @main() nounwind uwtable {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %4
  %5 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 -1, i8* %5)
  %6 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start(i64 -1, i8* %6)
  %7 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 -1, i8* %7)
  store i32 3, i32* %2, align 4
  store i32 4, i32* %3, align 4
  %8 = load i32* %2, align 4
  %9 = load i32* %3, align 4
  %10 = icmp sgt i32 %8, %9
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %0
  %12 = load i32* %2, align 4
  store i32 %12, i32* %1
  br label %greater.exit

; <label>:13                                      ; preds = %0
  %14 = load i32* %3, align 4
  store i32 %14, i32* %1
  br label %greater.exit

greater.exit:                                     ; preds = %11, %13
  %15 = load i32* %1
  %16 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.end(i64 -1, i8* %16)
  %17 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.end(i64 -1, i8* %17)
  %18 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.end(i64 -1, i8* %18)
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %15)
  ret i32 0
}

declare i32 @printf(i8*, ...)

declare void @llvm.lifetime.start(i64, i8* nocapture) nounwind

declare void @llvm.lifetime.end(i64, i8* nocapture) nounwind
