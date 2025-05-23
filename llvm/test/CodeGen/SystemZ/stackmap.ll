; RUN: llc < %s -mtriple=s390x-linux-gnu | FileCheck %s
;
; Note: Print verbose stackmaps using -debug-only=stackmaps.

; CHECK:       .section .llvm_stackmaps
; CHECK-NEXT:  __LLVM_StackMaps:
; Header
; CHECK-NEXT:   .byte 3
; CHECK-NEXT:   .byte 0
; CHECK-NEXT:   .short 0
; Num Functions
; CHECK-NEXT:   .long 16
; Num LargeConstants
; CHECK-NEXT:   .long 4
; Num Callsites
; CHECK-NEXT:   .long 20

; Functions and stack size
; CHECK-NEXT:   .quad constantargs
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad osrinline
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad osrcold
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad propertyRead
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad propertyWrite
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad jsVoidCall
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad jsIntCall
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad spilledValue
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad spilledStackMapValue
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad spillSubReg
; CHECK-NEXT:   .quad 168
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad liveConstant
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad directFrameIdx
; CHECK-NEXT:   .quad 200
; CHECK-NEXT:   .quad 2
; CHECK-NEXT:   .quad longid
; CHECK-NEXT:   .quad 160
; CHECK-NEXT:   .quad 4
; CHECK-NEXT:   .quad clobberScratch
; CHECK-NEXT:   .quad 168
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad needsStackRealignment
; CHECK-NEXT:   .quad -1
; CHECK-NEXT:   .quad 1
; CHECK-NEXT:   .quad floats
; CHECK-NEXT:   .quad 176
; CHECK-NEXT:   .quad 1

; Large Constants
; CHECK-NEXT:   .quad   2147483648
; CHECK-NEXT:   .quad   4294967295
; CHECK-NEXT:   .quad   4294967296
; CHECK-NEXT:   .quad   4294967297

; Callsites
; Constant arguments
;
; CHECK-NEXT:   .quad   1
; CHECK-NEXT:   .long   .L{{.*}}-constantargs
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  14
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   65535
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   65535
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   65536
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   2000000000
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   2147483647
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   -1
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   -1
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; LargeConstant at index 0
; CHECK-NEXT:   .byte   5
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; LargeConstant at index 1
; CHECK-NEXT:   .byte   5
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   1
; LargeConstant at index 2
; CHECK-NEXT:   .byte   5
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   2
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   -1
; SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   66
; LargeConstant at index 3
; CHECK-NEXT:   .byte   5
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   3

define void @constantargs() {
entry:
  %0 = inttoptr i64 12345 to ptr
  tail call void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 1, i32 14, ptr %0, i32 0, i16 65535, i16 -1, i32 65536, i32 2000000000, i32 2147483647, i32 -1, i32 4294967295, i32 4294967296, i64 2147483648, i64 4294967295, i64 4294967296, i64 -1, i128 66, i128 4294967297)
  ret void
}

; Inline OSR Exit
;
; CHECK:        .long   .L{{.*}}-osrinline
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  2
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
define void @osrinline(i64 %a, i64 %b) {
entry:
  ; Runtime void->void call.
  call void inttoptr (i64 -559038737 to ptr)()
  ; Followed by inline OSR patchpoint with 12-byte shadow and 2 live vars.
  call void (i64, i32, ...) @llvm.experimental.stackmap(i64 3, i32 12, i64 %a, i64 %b)
  ret void
}

; Cold OSR Exit
;
; 2 live variables in register.
;
; CHECK:        .long   .L{{.*}}-osrcold
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  2
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
define void @osrcold(i64 %a, i64 %b) {
entry:
  %test = icmp slt i64 %a, %b
  br i1 %test, label %ret, label %cold
cold:
  ; OSR patchpoint with 12-byte nop-slide and 2 live vars.
  %thunk = inttoptr i64 -559038737 to ptr
  call void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 4, i32 14, ptr %thunk, i32 0, i64 %a, i64 %b)
  unreachable
ret:
  ret void
}

; Property Read
; CHECK:        .long   .L{{.*}}-propertyRead
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  2
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
define i64 @propertyRead(ptr %obj) {
entry:
  %resolveRead = inttoptr i64 -559038737 to ptr
  %result = call anyregcc i64 (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.i64(i64 5, i32 14, ptr %resolveRead, i32 1, ptr %obj)
  %add = add i64 %result, 3
  ret i64 %add
}

; Property Write
; CHECK:        .long   .L{{.*}}-propertyWrite
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  2
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
define void @propertyWrite(i64 %dummy1, ptr %obj, i64 %dummy2, i64 %a) {
entry:
  %resolveWrite = inttoptr i64 -559038737 to ptr
  call anyregcc void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 6, i32 14, ptr %resolveWrite, i32 2, ptr %obj, i64 %a)
  ret void
}

; Void JS Call
;
; 2 live variables in registers.
;
; CHECK:        .long   .L{{.*}}-jsVoidCall
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  2
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
define void @jsVoidCall(i64 %dummy1, ptr %obj, i64 %arg, i64 %l1, i64 %l2) {
entry:
  %resolveCall = inttoptr i64 -559038737 to ptr
  call void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 7, i32 14, ptr %resolveCall, i32 2, ptr %obj, i64 %arg, i64 %l1, i64 %l2)
  ret void
}

; i64 JS Call
;
; 2 live variables in registers.
;
; CHECK:        .long   .L{{.*}}-jsIntCall
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  2
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{[0-9]+}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
define i64 @jsIntCall(i64 %dummy1, ptr %obj, i64 %arg, i64 %l1, i64 %l2) {
entry:
  %resolveCall = inttoptr i64 -559038737 to ptr
  %result = call i64 (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.i64(i64 8, i32 14, ptr %resolveCall, i32 2, ptr %obj, i64 %arg, i64 %l1, i64 %l2)
  %add = add i64 %result, 3
  ret i64 %add
}

; Spilled stack map values.
;
; Verify 17 stack map entries.
;
; CHECK:        .long .L{{.*}}-spilledValue
; CHECK-NEXT:   .short 0
; CHECK-NEXT:   .short 17
;
; Check that at least one is a spilled entry from the parameter area.
; Location: Indirect r15 + XX
; CHECK:        .byte  3
; CHECK-NEXT:   .byte  0
; CHECK-NEXT:   .short 8
; CHECK-NEXT:   .short 15
; CHECK-NEXT:   .short 0
; CHECK-NEXT:   .long
define void @spilledValue(i64 %arg0, i64 %arg1, i64 %arg2, i64 %arg3, i64 %arg4, i64 %l0, i64 %l1, i64 %l2, i64 %l3, i64 %l4, i64 %l5, i64 %l6, i64 %l7, i64 %l8, i64 %l9, i64 %l10, i64 %l11, i64 %l12, i64 %l13, i64 %l14, i64 %l15, i64 %l16) {
entry:
  call void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 11, i32 14, ptr null, i32 5, i64 %arg0, i64 %arg1, i64 %arg2, i64 %arg3, i64 %arg4, i64 %l0, i64 %l1, i64 %l2, i64 %l3, i64 %l4, i64 %l5, i64 %l6, i64 %l7, i64 %l8, i64 %l9, i64 %l10, i64 %l11, i64 %l12, i64 %l13, i64 %l14, i64 %l15, i64 %l16)
  ret void
}

; Spilled stack map values.
;
; Verify 17 stack map entries.
;
; CHECK:        .long .L{{.*}}-spilledStackMapValue
; CHECK-NEXT:   .short 0
; CHECK-NEXT:   .short 17
;
; Check that at least one is a spilled entry from the parameter area.
; Location: Indirect r15 + XX
; CHECK:        .byte  3
; CHECK-NEXT:   .byte  0
; CHECK-NEXT:   .short 8
; CHECK-NEXT:   .short 15
; CHECK-NEXT:   .short 0
; CHECK-NEXT:   .long
define void @spilledStackMapValue(i64 %l0, i64 %l1, i64 %l2, i64 %l3, i64 %l4, i64 %l5, i64 %l6, i64 %l7, i64 %l8, i64 %l9, i64 %l10, i64 %l11, i64 %l12, i64 %l13, i64 %l14, i64 %l15, i64 %l16) {
entry:
  call void (i64, i32, ...) @llvm.experimental.stackmap(i64 12, i32 16, i64 %l0, i64 %l1, i64 %l2, i64 %l3, i64 %l4, i64 %l5, i64 %l6, i64 %l7, i64 %l8, i64 %l9, i64 %l10, i64 %l11, i64 %l12, i64 %l13, i64 %l14, i64 %l15, i64 %l16)
  ret void
}

; Spill a subregister stackmap operand.
;
; CHECK:        .long .L{{.*}}-spillSubReg
; CHECK-NEXT:   .short 0
; 4 locations
; CHECK-NEXT:   .short 1
;
; Check that the subregister operand is a 4-byte spill.
; Location: Indirect, 4-byte, %r15 + 164
; CHECK:        .byte  3
; CHECK-NEXT:   .byte  0
; CHECK-NEXT:   .short 4
; CHECK-NEXT:   .short 15
; CHECK-NEXT:   .short 0
; CHECK-NEXT:   .long  164
define void @spillSubReg(i64 %arg) #0 {
bb:
  br i1 undef, label %bb1, label %bb2

bb1:
  unreachable

bb2:
  %tmp = load i64, ptr inttoptr (i64 140685446136880 to ptr)
  br i1 undef, label %bb16, label %bb17

bb16:
  unreachable

bb17:
  %tmp32 = trunc i64 %tmp to i32
  br i1 undef, label %bb60, label %bb61

bb60:
  tail call void asm sideeffect "nopr %r0", "~{r0},~{r1},~{r2},~{r3},~{r4},~{r5},~{r6},~{r7},~{r8},~{r9},~{r10},~{r11},~{r12},~{r13},~{r14}"() nounwind
  tail call void (i64, i32, ...) @llvm.experimental.stackmap(i64 13, i32 6, i32 %tmp32)
  unreachable

bb61:
  unreachable
}

; Map a constant value.
;
; CHECK:        .long .L{{.*}}-liveConstant
; CHECK-NEXT:   .short 0
; 1 location
; CHECK-NEXT:   .short 1
; Loc 0: SmallConstant
; CHECK-NEXT:   .byte   4
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   33

define void @liveConstant() {
  tail call void (i64, i32, ...) @llvm.experimental.stackmap(i64 15, i32 6, i32 33)
  ret void
}

; Directly map an alloca's address.
;
; Callsite 16
; CHECK:        .long .L{{.*}}-directFrameIdx
; CHECK-NEXT:   .short 0
; 1 location
; CHECK-NEXT:   .short	1
; Loc 0: Direct %r15 + ofs
; CHECK-NEXT:   .byte	2
; CHECK-NEXT:   .byte	0
; CHECK-NEXT:   .short	8
; CHECK-NEXT:   .short	15
; CHECK-NEXT:   .short	0
; CHECK-NEXT:   .long

; Callsite 17
; CHECK:        .long .L{{.*}}-directFrameIdx
; CHECK-NEXT:   .short	0
; 2 locations
; CHECK-NEXT:   .short	2
; Loc 0: Direct %r15 + ofs
; CHECK-NEXT:   .byte	2
; CHECK-NEXT:   .byte	0
; CHECK-NEXT:   .short	8
; CHECK-NEXT:   .short	15
; CHECK-NEXT:   .short	0
; CHECK-NEXT:   .long
; Loc 1: Direct %r15 + ofs
; CHECK-NEXT:   .byte	2
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short	15
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long
define void @directFrameIdx() {
entry:
  %metadata1 = alloca i64, i32 3, align 8
  store i64 11, ptr %metadata1
  store i64 12, ptr %metadata1
  store i64 13, ptr %metadata1
  call void (i64, i32, ...) @llvm.experimental.stackmap(i64 16, i32 0, ptr %metadata1)
  %metadata2 = alloca i8, i32 4, align 8
  %metadata3 = alloca i16, i32 4, align 8
  call void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 17, i32 6, ptr null, i32 0, ptr %metadata2, ptr %metadata3)
  ret void
}

; Test a 64-bit ID.
;
; CHECK:        .quad 4294967295
; CHECK:        .long .L{{.*}}-longid
; CHECK:        .quad 4294967296
; CHECK:        .long .L{{.*}}-longid
; CHECK:        .quad 9223372036854775807
; CHECK:        .long .L{{.*}}-longid
; CHECK:        .quad -1
; CHECK:        .long .L{{.*}}-longid
define void @longid() {
entry:
  tail call void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 4294967295, i32 0, ptr null, i32 0)
  tail call void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 4294967296, i32 0, ptr null, i32 0)
  tail call void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 9223372036854775807, i32 0, ptr null, i32 0)
  tail call void (i64, i32, ptr, i32, ...) @llvm.experimental.patchpoint.void(i64 -1, i32 0, ptr null, i32 0)
  ret void
}

; Map a value when %r0 and %r1 are the only free registers.
; The scratch registers should not be used for a live stackmap value.
;
; CHECK:        .long .L{{.*}}-clobberScratch
; CHECK-NEXT:   .short 0
; 1 location
; CHECK-NEXT:   .short 1
; Loc 0: Indirect %r15 + offset
; CHECK-NEXT:   .byte   3
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  4
; CHECK-NEXT:   .short  15
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   164
define void @clobberScratch(i32 %a) {
  tail call void asm sideeffect "nopr %r0", "~{r2},~{r3},~{r4},~{r5},~{r6},~{r7},~{r8},~{r9},~{r10},~{r11},~{r12},~{r13},~{r14}"() nounwind
  tail call void (i64, i32, ...) @llvm.experimental.stackmap(i64 16, i32 8, i32 %a)
  ret void
}

; A stack frame which needs to be realigned at runtime (to meet alignment
; criteria for values on the stack) does not have a fixed frame size.
; CHECK:        .long .L{{.*}}-needsStackRealignment
; CHECK-NEXT:   .short 0
; 0 locations
; CHECK-NEXT:   .short 0
define void @needsStackRealignment() {
  %val = alloca i64, i32 3, align 128
  tail call void (...) @escape_values(ptr %val)
; Note: Adding any non-constant to the stackmap would fail because we
; expected to be able to address off the frame pointer.  In a realigned
; frame, we must use the stack pointer instead.  This is a separate bug.
  tail call void (i64, i32, ...) @llvm.experimental.stackmap(i64 0, i32 0)
  ret void
}
declare void @escape_values(...)

; CHECK-LABEL:  .long .L{{.*}}-floats
; CHECK-NEXT:   .short 0
; Num Locations
; CHECK-NEXT:   .short 9
; Loc 0: constant half stored to FP register
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  4
; CHECK-NEXT:   .short  {{.*}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   16
; Loc 0: constant float stored to FP register
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  4
; CHECK-NEXT:   .short  {{.*}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   32
; Loc 0: constant double stored to FP register
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{.*}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; Loc 1: half value in FP register
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  4
; CHECK-NEXT:   .short  {{.*}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   16
; Loc 1: float value in FP register
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  4
; CHECK-NEXT:   .short  {{.*}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   32
; Loc 2: double value in FP register
; CHECK-NEXT:   .byte   1
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{.*}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   0
; Loc 3: half on stack
; CHECK-NEXT:   .byte   2
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{.*}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   {{.*}}
; Loc 3: float on stack
; CHECK-NEXT:   .byte   2
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{.*}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   {{.*}}
; Loc 4: double on stack
; CHECK-NEXT:   .byte   2
; CHECK-NEXT:   .byte   0
; CHECK-NEXT:   .short  8
; CHECK-NEXT:   .short  {{.*}}
; CHECK-NEXT:   .short  0
; CHECK-NEXT:   .long   {{.*}}
define void @floats(half %e, float %f, double %g) {
  %hh = alloca half
  %ff = alloca float
  %gg = alloca double
  call void (i64, i32, ...) @llvm.experimental.stackmap(i64 888, i32 0, half 1.125,
    float 1.25, double 1.5, half %e, float %f, double %g, ptr %hh, ptr %ff, ptr %gg)
  ret void
}

declare void @llvm.experimental.stackmap(i64, i32, ...)
declare void @llvm.experimental.patchpoint.void(i64, i32, ptr, i32, ...)
declare i64 @llvm.experimental.patchpoint.i64(i64, i32, ptr, i32, ...)
