
.globl drawAL,draw_arrow
 
//.LC0:
//	.long 0x0
//	.long 0x40240000 /* 10 */

.LC0:
	.long 0x0
	.long 0x403e0000 /* 30 */


//.LC1:
//	.long 0x0
//	.long 0x40100000 /* 4 */

.LC1:
	.long 0x0
	.long 0x40240000 /* 4 */


.LC2:
	.long 0x0
	.long 0x80000000 /* -0 */

.LC3:
	.string "x3=%d,y3=%d,x4=%d,y4=%d\n"

.LC4:
	.string "%lf\n"




.text
main6:
	pushq %rbp
	movq %rsp,%rbp

	subq $0x1000,%rsp

	movl $400,%ecx 
	movl $400,%edx 
	movl $100,%esi 
	movl $100,%edi 
	call drawAL

	movl $0,%eax
	leave
	ret

drawAL:
	pushq %rbp
	movq %rsp,%rbp

	subq $0x1000,%rsp

	movl %edi,-0x1000(%rbp) /* sx */
	movl %esi,-0xffc(%rbp) /* sy */
	movl %edx,-0xff8(%rbp) /* ex */
	movl %ecx,-0xff4(%rbp) /* ey */
	movq $0,-0xff0(%rbp) /* H */
	movq $0,-0xfe0(%rbp) /* L */

	movl $0,-0xfd0(%rbp) /* x3 */
	movl $0,-0xfcc(%rbp) /* y3 */
	movl $0,-0xfc8(%rbp) /* x4 */
	movl $0,-0xfc4(%rbp) /* y4 */

	movq $0,-0xfb0(%rbp) /* awrad */
	movq $0,-0xfa0(%rbp) /* arraow_len */
	movq $0,-0xf90(%rbp) /* arrXY_1 */
	movq $0,-0xf80(%rbp) /* arrXY_2 */
	movq $0,-0xf70(%rbp) /* x_3 */
	movq $0,-0xf60(%rbp) /* y_3 */
	movq $0,-0xf50(%rbp) /* x_4 */
	movq $0,-0xf40(%rbp) /* y_4 */

	movl $0,-0xf30(%rbp) /* x3 */
	movl $0,-0xf2c(%rbp) /* y3 */
	movl $0,-0xf28(%rbp) /* x4 */
	movl $0,-0xf24(%rbp) /* y4 */

	movsd .LC0(%rip),%xmm0 /* 10 */
	movsd %xmm0,-0xff0(%rbp) /* H */

	movsd .LC1(%rip),%xmm0 /* 4 */
	movsd %xmm0,-0xfe0(%rbp) /* L */


	movsd -0xfe0(%rbp),%xmm0 /* L */
	movsd -0xff0(%rbp),%xmm1 /* H */

	divsd %xmm1,%xmm0 
	call atan 
	movsd %xmm0,-0xfb0(%rbp) /* awrad */

	movsd -0xfe0(%rbp),%xmm0 /* L */
	mulsd %xmm0,%xmm0
	
	movsd -0xff0(%rbp),%xmm1 /* H */
	mulsd %xmm1,%xmm1

	addsd %xmm1,%xmm0 
	call sqrt 
	movsd %xmm0,-0xfa0(%rbp) /* arraow_len */

	movsd -0xfa0(%rbp),%xmm1 /* arraow_len */
	movl $1,%edx 
	movsd -0xfb0(%rbp),%xmm0 /* awrad */
	
	movl -0xff4(%rbp),%eax /* ey */
	subl -0xffc(%rbp),%eax /* sy */
	movl %eax,%esi 

	movl -0xff8(%rbp),%eax /* ex */
	subl -0x1000(%rbp),%eax /* sx */
	movl %eax,%edi 
	call rotateVec 
	movq %rax,-0xf90(%rbp) /* arrXY_1 */

	movsd -0xfa0(%rbp),%xmm1 /* arraow_len */
	movl $1,%edx 

	movq -0xfb0(%rbp),%xmm0 /* awrad */
	movsd .LC2(%rip),%xmm2
	xorpd %xmm2,%xmm0 

	movl -0xff4(%rbp),%eax /* ey */
	subl -0xffc(%rbp),%eax /* sy */	
	movl %eax,%esi 

	movl -0xff8(%rbp),%eax /* ex */
	subl -0x1000(%rbp),%eax /* sx */
	movl %eax,%edi 
	call rotateVec 
	movq %rax,-0xf80(%rbp) /* arrXY_2 */

/**********************************/

//	movl $0,%eax
//	sall $3,%eax
//	movslq %eax,%rax
//	movq -0xf90(%rbp),%rdi 
//	movsd 0(%rdi,%rax,1),%xmm0 /* arrXY_1[0] */
//
//	leaq .LC4(%rip),%rdi 
//	movl $1,%eax
//	call printf 


//	movl $1,%eax
//	sall $3,%eax
//	movslq %eax,%rax
//	movq -0xf90(%rbp),%rdi 
//	movsd 0(%rdi,%rax,1),%xmm0 /* arrXY_1[0] */
//
//	leaq .LC4(%rip),%rdi 
//	movl $1,%eax
//	call printf 





//	movl $0,%eax
//	sall $3,%eax
//	movslq %eax,%rax
//	movq -0xf80(%rbp),%rdi 
//	movsd 0(%rdi,%rax,1),%xmm0 /* arrXY_2[0] */
//
//	leaq .LC4(%rip),%rdi 
//	movl $1,%eax
//	call printf 
//
//
//	movl $1,%eax
//	sall $3,%eax
//	movslq %eax,%rax
//	movq -0xf80(%rbp),%rdi 
//	movsd 0(%rdi,%rax,1),%xmm0 /* arrXY_2[1] */
//
//	leaq .LC4(%rip),%rdi 
//	movl $1,%eax
//	call printf 


/*****************************/



	cvtsi2sd -0xff8(%rbp),%xmm0 /* ex */


	movl $0,%eax
	sall $3,%eax
	movslq %eax,%rax
	movq -0xf90(%rbp),%rdi 
	movsd 0(%rdi,%rax,1),%xmm1 /* arrXY_1[0] */

	subsd %xmm1,%xmm0  
	movsd %xmm0,-0xf70(%rbp) /* x_3 */


	cvtsi2sd -0xff4(%rbp),%xmm0 /* ey */
	
	movl $1,%eax
	sall $3,%eax
	movslq %eax,%rax
	movq -0xf90(%rbp),%rdi 
	movsd 0(%rdi,%rax,1),%xmm1 /* arrXY_1[0] */

	subsd %xmm1,%xmm0 
	movsd %xmm0,-0xf60(%rbp) /* y_3 */


	cvtsi2sd -0xff8(%rbp),%xmm0 /* ex */

	movl $0,%eax
	sall $3,%eax
	movslq %eax,%rax
	movq -0xf80(%rbp),%rdi 
	movsd 0(%rdi,%rax,1),%xmm1 /* arrXY_2[0] */

	subsd %xmm1,%xmm0
	movsd %xmm0,-0xf50(%rbp) /* x_4 */


	cvtsi2sd -0xff4(%rbp),%xmm0 /* ey */

	movl $1,%eax
	sall $3,%eax
	movslq %eax,%rax
	movq -0xf80(%rbp),%rdi 
	movsd 0(%rdi,%rax,1),%xmm1 /* arrXY_2[0] */

	subsd %xmm1,%xmm0
	movsd %xmm0,-0xf40(%rbp) /* y_4 */

	cvtsd2si -0xf70(%rbp),%eax  /* x_3 */
	movl %eax,-0xf30(%rbp) /* x3 */

	cvtsd2si -0xf60(%rbp),%eax  /* y_3 */
	movl %eax,-0xf2c(%rbp) /* y3 */

	cvtsd2si -0xf50(%rbp),%eax  /* x_4 */
	movl %eax,-0xf28(%rbp) /* x4 */

	cvtsd2si -0xf40(%rbp),%eax  /* y_4 */
	movl %eax,-0xf24(%rbp) /* y4 */

	movq -0xf90(%rbp),%rdi /*arrXY_1*/
	call free 

	movq -0xf80(%rbp),%rdi /*arrXY_2*/
	call free 

	movl $16,%edi 
	call malloc 

	movq %rax,%rdi
	movl -0xf30(%rbp),%eax /* x3 */
	movl %eax,0(%rdi) 

	movl -0xf2c(%rbp),%eax /* y3 */
	movl %eax,4(%rdi)

	movl -0xf28(%rbp),%eax /* x4 */
	movl %eax,8(%rdi)

	movl -0xf24(%rbp),%eax /* y4 */
	movl %eax,12(%rdi) 

	movq %rdi,%rax 
	leave
	ret

rotateVec:
	pushq %rbp
	movq %rsp,%rbp

	subq $0x1000,%rsp

	movl %edi,-0x1000(%rbp) /* px */
	movl %esi,-0xffc(%rbp) /* py */
	movsd %xmm0,-0xfe0(%rbp) /* ang */
	movl %edx,-0xfd0(%rbp) /* isChLen */
	movq %xmm1,-0xfc0(%rbp) /* newLen */

	movq $0,-0xfb0(%rbp) /* mathstr */
	movq $0,-0xfa0(%rbp) /* vx */
	movq $0,-0xf90(%rbp) /* vy */
	movq $0,-0xf80(%rbp) /* d */
	movq $0,-0xf70(%rbp) /* temp */

	movl $16,%edi
	call malloc 
	movq %rax,-0xfb0(%rbp) /* mathstr */


	movsd -0xfe0(%rbp),%xmm0 /* ang */
	call cos 

	cvtsi2sd -0x1000(%rbp),%xmm1 /* px */
	mulsd %xmm1,%xmm0 
	movsd %xmm0,-0xf70(%rbp) /* temp */

	movsd -0xfe0(%rbp),%xmm0 /* ang */
	call sin 
	cvtsi2sd -0xffc(%rbp),%xmm1 /* py */
	mulsd %xmm1,%xmm0 

	movsd -0xf70(%rbp),%xmm2 /* temp */
	subsd %xmm0,%xmm2 
	movsd %xmm2,-0xfa0(%rbp) /* vx */



	movsd -0xfe0(%rbp),%xmm0 /* ang */
	call sin 

	cvtsi2sd -0x1000(%rbp),%xmm1 /* px */
	mulsd %xmm1,%xmm0 
	movsd %xmm0,-0xf70(%rbp) /* temp */


	movsd -0xfe0(%rbp),%xmm0 /* ang */
	call cos 

	cvtsi2sd -0xffc(%rbp),%xmm1 /* py */
	mulsd %xmm1,%xmm0 


	movsd -0xf70(%rbp),%xmm2 /* temp */
	addsd %xmm2,%xmm0 

	movsd %xmm0,-0xf90(%rbp) /* vy */


	movl -0xfd0(%rbp),%eax /* isChLen */
	testl %eax,%eax
	je .LrotateVec_0

 
	movsd -0xfa0(%rbp),%xmm0 /* vx */
	mulsd %xmm0,%xmm0
	
	movsd -0xf90(%rbp),%xmm1 /* vy */
	mulsd %xmm1,%xmm1 
	addsd %xmm1,%xmm0
	call sqrt 
	movsd %xmm0,-0xf80(%rbp) /* d */

	movsd -0xfa0(%rbp),%xmm0 /* vx */
	movsd -0xf80(%rbp),%xmm1 /* d */

	divsd %xmm1,%xmm0

	movsd -0xfc0(%rbp),%xmm1 /* newLen */

	mulsd %xmm1,%xmm0 

	movsd %xmm0, -0xfa0(%rbp) /* vx */
	
	
	movsd -0xf90(%rbp),%xmm0 /* vy */
	movsd -0xf80(%rbp),%xmm1 /* d */	

	divsd %xmm1,%xmm0
	movsd -0xfc0(%rbp),%xmm1 /* newLen */
	mulsd %xmm1,%xmm0 
	movsd %xmm0,-0xf90(%rbp) /* vy */ 

	movsd -0xfa0(%rbp),%xmm0 /* vx */


	
	movl $0,%eax 
	sall $3,%eax
	movslq %eax,%rax
	movq -0xfb0(%rbp),%rdi /* mathstr */
	movsd %xmm0,0(%rdi,%rax,1) /* mathstr[0] */

	movsd -0xf90(%rbp),%xmm0 /* vy */
	movl $1,%eax 
	sall $3,%eax
	movslq %eax,%rax
	movq -0xfb0(%rbp),%rdi /* mathstr */
	movsd %xmm0,0(%rdi,%rax,1) /* mathstr[1] */

.LrotateVec_0:
	movq -0xfb0(%rbp),%rax /* mathstr */
	leave
	ret

draw_arrow:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */
	movl %esi,-0xff8(%rbp) /* x1 */
	movl %edx,-0xff4(%rbp) /* y1 */
	movl %ecx,-0xff0(%rbp) /* x2 */
	movl %r8d,-0xfec(%rbp) /* y2 */
	movq $0,-0xfe0(%rbp) /* temp */

	movl $1,%r8d 
	movl $1,%ecx 
	movl $0,%edx 
	movl $5,%esi 

	movq -0x1000(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 792(%rdi),%rdi /* widget->style->black_gc */
//	movq 800(%rdi),%rdi /* widget->style->gray_gc */
//	movq 784(%rdi),%rdi /* widget->style->white_gc */

	call gdk_gc_set_line_attributes

	movl -0xfec(%rbp),%r9d /* y2 */
	movl -0xff0(%rbp),%r8d /* x2 */
	movl -0xff4(%rbp),%ecx /* y1 */
	movl -0xff8(%rbp),%edx /* x1 */

	movq -0x1000(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 792(%rdi),%rsi /* widget->style->black_gc */
//	movq 800(%rdi),%rsi /* widget->style->black_gc */
//	movq 784(%rdi),%rsi /* widget->style->black_gc */

	movq pixmap(%rip),%rdi 
	call gdk_draw_line 

	movl -0xfec(%rbp),%ecx /* y2 */
	movl -0xff0(%rbp),%edx /* x2 */
	movl -0xff4(%rbp),%esi /* y1 */
	movl -0xff8(%rbp),%edi /* x1 */
	call drawAL 
	movq %rax,-0xfe0(%rbp) /* temp */

	movq %rax,%rdi 

	movl 4(%rdi),%r9d /* y3 */
	movl 0(%rdi),%r8d /* x3 */
	movl -0xfec(%rbp),%ecx  /* y2 */
	movl -0xff0(%rbp),%edx /* x2 */

	movq -0x1000(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 792(%rdi),%rsi /* widget->style->black_gc */
//	movq 800(%rdi),%rsi /* widget->style->black_gc */
//	movq 784(%rdi),%rsi /* widget->style->black_gc */

	movq pixmap(%rip),%rdi 
	call gdk_draw_line 

	movq -0xfe0(%rbp),%rdi  /* temp */ 
	movl 12(%rdi),%r9d /* y4 */
	movl 8(%rdi),%r8d  /* x4 */
	movl -0xfec(%rbp),%ecx  /* y2 */
	movl -0xff0(%rbp),%edx /* x2 */

	movq -0x1000(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 792(%rdi),%rsi /* widget->style->black_gc */
//	movq 800(%rdi),%rsi /* widget->style->black_gc */
//	movq 784(%rdi),%rsi /* widget->style->black_gc */

	movq pixmap(%rip),%rdi 
	call gdk_draw_line 

	movq -0x1000(%rbp),%rdi /* widget */
	call gtk_widget_queue_draw 


	movq -0xfe0(%rbp),%rdi  /* temp */ 
	call free 

	movl $0,%eax
	leave
	ret

