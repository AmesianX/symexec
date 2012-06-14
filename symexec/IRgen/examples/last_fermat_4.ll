; ModuleID = '<stdin>'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

define i32 @last_fermat_4(i32 %a, i32 %b, i32 %c) nounwind uwtable {
bb:
  %tmp = mul nsw i32 %a, %a
  %tmp1 = mul nsw i32 %tmp, %a
  %tmp2 = mul nsw i32 %tmp1, %a
  %tmp3 = mul nsw i32 %b, %b
  %tmp4 = mul nsw i32 %tmp3, %b
  %tmp5 = mul nsw i32 %tmp4, %b
  %tmp6 = add nsw i32 %tmp2, %tmp5
  %tmp7 = mul nsw i32 %c, %c
  %tmp8 = mul nsw i32 %tmp7, %c
  %tmp9 = mul nsw i32 %tmp8, %c
  %tmp10 = icmp eq i32 %tmp6, %tmp9
  %tmp11 = xor i1 %tmp10, true
  %tmp12 = zext i1 %tmp11 to i32
  ret i32 %tmp12
}
