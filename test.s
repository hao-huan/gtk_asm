


.globl test

test:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	leaq .LC0(%rip),%rdi
	movl $0,%eax 
	call printf 

	movl $0,%eax
	leave
	ret


time_handler:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */

	movq -0x1000(%rbp),%rdi /* widget */
	cmpq $0,80(%rdi) /* widget->window */
	jne .Ltime_handler_400
	
	movl $0,%eax
	jmp .Ltime_handler_0 

.Ltime_handler_400:
	cvtsi2sd y(%rip),%xmm1
	cvtsi2sd x(%rip),%xmm0 

	movq -0x1000(%rbp),%rdi /* widget */
	movl $0,%eax
	call draw_brush

/*************************************/
	cmpl $1,direct(%rip)
	jne .Ltime_handler_390
	
	addl $3,x(%rip)
	cmpl $700,x(%rip)
	jle .Ltime_handler_391
	movl $2,direct(%rip)
	movl y(%rip),%eax
	movl %eax,ybak(%rip)
.Ltime_handler_391:
	jmp .Ltime_handler_1

.Ltime_handler_390:
	cmpl $2,direct(%rip)
	jne .Ltime_handler_380
	addl $3,y(%rip)
	movl ybak(%rip),%eax
	addl $40,%eax
	cmpl y(%rip),%eax
	jge .Ltime_handler_381

	movl $3,direct(%rip)

.Ltime_handler_381:
	jmp .Ltime_handler_1

.Ltime_handler_380:
	cmpl $3,direct(%rip)
	jne .Ltime_handler_370

	subl $3,x(%rip)
	cmpl $20,x(%rip)
	jge .Ltime_handler_371
	movl $4,direct(%rip)
	movl y(%rip),%eax
	movl %eax,ybak(%rip)

.Ltime_handler_371:
	jmp .Ltime_handler_1
.Ltime_handler_370:
	cmpl $4,direct(%rip)
	jne .Ltime_handler_1

	addl $3,y(%rip)
	movl ybak(%rip),%eax
	addl $40,%eax
	cmpl y(%rip),%eax
	jge .Ltime_handler_1
	movl $1,direct(%rip)

/*************************************/
	
.Ltime_handler_1:

	movl $1,%eax
.Ltime_handler_0:
	leave
	ret

