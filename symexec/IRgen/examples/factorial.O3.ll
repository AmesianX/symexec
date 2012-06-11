; ModuleID = 'factorial.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @factorial(i32 %X) nounwind uwtable readnone {
  %1 = icmp eq i32 %X, 0
  br i1 %1, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %0, %tailrecurse
  %X.tr2 = phi i32 [ %2, %tailrecurse ], [ %X, %0 ]
  %accumulator.tr1 = phi i32 [ %3, %tailrecurse ], [ 1, %0 ]
  %2 = add nsw i32 %X.tr2, -1
  %3 = mul nsw i32 %X.tr2, %accumulator.tr1
  %4 = icmp eq i32 %2, 0
  br i1 %4, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %0
  %accumulator.tr.lcssa = phi i32 [ 1, %0 ], [ %3, %tailrecurse ]
  ret i32 %accumulator.tr.lcssa
}

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind uwtable {
  %1 = getelementptr inbounds i8** %argv, i64 1
  %2 = load i8** %1, align 8, !tbaa !0
  %3 = tail call i64 @strtol(i8* nocapture %2, i8** null, i32 10) nounwind
  %4 = trunc i64 %3 to i32
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %factorial.exit, label %tailrecurse.i

tailrecurse.i:                                    ; preds = %0, %tailrecurse.i
  %X.tr2.i = phi i32 [ %6, %tailrecurse.i ], [ %4, %0 ]
  %accumulator.tr1.i = phi i32 [ %7, %tailrecurse.i ], [ 1, %0 ]
  %6 = add nsw i32 %X.tr2.i, -1
  %7 = mul nsw i32 %accumulator.tr1.i, %X.tr2.i
  %8 = icmp eq i32 %6, 0
  br i1 %8, label %factorial.exit, label %tailrecurse.i

factorial.exit:                                   ; preds = %tailrecurse.i, %0
  %accumulator.tr.lcssa.i = phi i32 [ 1, %0 ], [ %7, %tailrecurse.i ]
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %accumulator.tr.lcssa.i) nounwind
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind

declare i64 @strtol(i8*, i8** nocapture, i32) nounwind

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
