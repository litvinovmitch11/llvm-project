# RUN: llvm-mc -triple x86_64-pc-linux %s -filetype=obj | \
# RUN:   not llvm-dwarfdump -verify -verify-json=%t.json -
# RUN: FileCheck %s --input-file %t.json

# CHECK: {"error-categories":{"Duplicate Name Index":{"count":1,"details":{}},"Name Index doesn't index any CU":{"count":1,"details":{}},"Name Index references non-existing CU":{"count":1,"details":{}}},"error-count":3}
# CHECK-NOT : error: Name Index @ 0x58 references a CU @ 0x0, but this CU is already indexed by Name Index @ 0x28
# CHECK-NOT: warning: CU @ 0x13 not covered by any Name Index


	.section	.debug_str,"MS",@progbits,1
.Lstring_foo:
	.asciz	"foo"
.Lstring_foo_mangled:
	.asciz	"_Z3foov"
.Lstring_bar:
	.asciz	"bar"
.Lstring_producer:
	.asciz	"Hand-written dwarf"

	.section	.debug_abbrev,"",@progbits
.Lsection_abbrev:
	.byte	1                       # Abbreviation Code
	.byte	17                      # DW_TAG_compile_unit
	.byte	1                       # DW_CHILDREN_yes
	.byte	37                      # DW_AT_producer
	.byte	14                      # DW_FORM_strp
	.byte	19                      # DW_AT_language
	.byte	5                       # DW_FORM_data2
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	0                       # EOM(3)

	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Lcu_end0-.Lcu_start0   # Length of Unit
.Lcu_start0:
	.short	4                       # DWARF version number
	.long	.Lsection_abbrev        # Offset Into Abbrev. Section
	.byte	8                       # Address Size (in bytes)
	.byte	1                       # Abbrev [1] DW_TAG_compile_unit
	.long	.Lstring_producer       # DW_AT_producer
	.short	12                      # DW_AT_language
	.byte	0                       # End Of Children Mark
.Lcu_end0:

.Lcu_begin1:
	.long	.Lcu_end1-.Lcu_start1   # Length of Unit
.Lcu_start1:
	.short	4                       # DWARF version number
	.long	.Lsection_abbrev        # Offset Into Abbrev. Section
	.byte	8                       # Address Size (in bytes)
	.byte	1                       # Abbrev [1] DW_TAG_compile_unit
	.long	.Lstring_producer       # DW_AT_producer
	.short	12                      # DW_AT_language
	.byte	0                       # End Of Children Mark
.Lcu_end1:

	.section	.debug_names,"",@progbits
	.long	.Lnames_end0-.Lnames_start0 # Header: contribution length
.Lnames_start0:
	.short	5                       # Header: version
	.short	0                       # Header: padding
	.long	0                       # Header: compilation unit count
	.long	0                       # Header: local type unit count
	.long	0                       # Header: foreign type unit count
	.long	0                       # Header: bucket count
	.long	0                       # Header: name count
	.long	.Lnames_abbrev_end0-.Lnames_abbrev_start0 # Header: abbreviation table size
	.long	0                       # Header: augmentation length
.Lnames_abbrev_start0:
	.byte	0                       # End of abbrev list
.Lnames_abbrev_end0:
.p2align 2
.Lnames_end0:

	.long	.Lnames_end1-.Lnames_start1 # Header: contribution length
.Lnames_start1:
	.short	5                       # Header: version
	.short	0                       # Header: padding
	.long	2                       # Header: compilation unit count
	.long	0                       # Header: local type unit count
	.long	0                       # Header: foreign type unit count
	.long	0                       # Header: bucket count
	.long	0                       # Header: name count
	.long	.Lnames_abbrev_end1-.Lnames_abbrev_start1 # Header: abbreviation table size
	.long	0                       # Header: augmentation length
	.long	.Lcu_begin0             # Compilation unit 0
	.long	.Lcu_begin0+1           # Compilation unit 0
.Lnames_abbrev_start1:
	.byte	0                       # End of abbrev list
.Lnames_abbrev_end1:
.p2align 2
.Lnames_end1:

	.long	.Lnames_end2-.Lnames_start2 # Header: contribution length
.Lnames_start2:
	.short	5                       # Header: version
	.short	0                       # Header: padding
	.long	1                       # Header: compilation unit count
	.long	0                       # Header: local type unit count
	.long	0                       # Header: foreign type unit count
	.long	0                       # Header: bucket count
	.long	0                       # Header: name count
	.long	.Lnames_abbrev_end2-.Lnames_abbrev_start2 # Header: abbreviation table size
	.long	0                       # Header: augmentation length
	.long	.Lcu_begin0             # Compilation unit 0
.Lnames_abbrev_start2:
	.byte	0                       # End of abbrev list
.Lnames_abbrev_end2:
.p2align 2
.Lnames_end2:
