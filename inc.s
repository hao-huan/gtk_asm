

.text

.globl .LC0,.LC1,.LC3,.LC4,.LC5,.LC6,.LC7,.LC8,.LC9,.LC10,.LC11,.LC12,.LC13,.LC14,.LC15,.LC16,.LC17

.data
.comm window,8,32
.comm pixmap,8,32

.comm x,4,32
.comm y,4,32
.comm direct,4,32
.comm ybak,4,32
.comm buffer,256,32

ybak:
	.long 0

x:
	.long 100
y:
	.long 100



.section .rodata

.LC0:
	.string "绘图软件"

.LC1:
	.long 0x0
	.long 0x40080000 /* 3 */

.LC2:
	.long 0x0
	.long 0x40180000 /* 6 */

.LC3:
	.string "delete_event"

.LC4:
	.string "<u>绘图区域</u>"

.LC5:
	.string "expose_event" 

.LC6:
	.string "configure_event"

.LC7:
	.string "motion_notify_event"

.LC8:
	.string "button_press_event"


.LC9:
	.string	 "cursor,-urw-nimbus roman no9 l-bold-r-normal--0-0-0-0-p-0-iso8859-1"


/* xlsfonts */
.LC10:
	.long 365

.LC11:
	.string "%d"

.LC12:
	.string "base"

.LC13:
	.string "Sans"

.LC14:
	.string "clicked"

.LC15:
	.string "配置数据"

.LC16:
	.string "算法分析"

.LC17:
	.string "运行"


