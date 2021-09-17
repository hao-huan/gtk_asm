.text
.globl test2


test2:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */
	movl $0,-0xff0(%rbp) /* i */
	movl $0,-0xfec(%rbp) /* x */
	movl $0,-0xfe8(%rbp) /* y */

	movq -0x1000(%rbp),%rdi /* widget */
	cmpq $0,80(%rdi) /* widget->window */
	jne .Ltest2_400
	
	movl $0,%eax
	jmp .Ltest2_0 

.Ltest2_400:

//	addl $1,ybak(%rip)
//
//	movl ybak(%rip),%esi 
//	cvtsi2sd y(%rip),%xmm1
//	cvtsi2sd x(%rip),%xmm0 
//
//	movq -0x1000(%rbp),%rdi /* widget */
//	movl $0,%eax
//	call draw0



/*************************************/
//	movl $0,-0xff0(%rbp) /* i */
//	movl $100,-0xfec(%rbp) /* x */
//	movl $100,-0xfe8(%rbp) /* y */
//	
//	jmp .Ltest2_300
//
//.Ltest2_390:
//
//	movl -0xff0(%rbp),%eax /* i */
//	sall $2,%eax
//	movslq %eax,%rax 
//	leaq arr(%rip),%rdi 
//	movl 0(%rdi,%rax,1),%esi /* arr[i] */
//	
//	cvtsi2sd -0xfe8(%rbp),%xmm1 /* y */
//	cvtsi2sd -0xfec(%rbp),%xmm0  /* x */
//
	movq -0x1000(%rbp),%rdi /* widget */
	call draw1
//
//	addl $140,-0xfec(%rbp) /* x */
//
//	addl $1,-0xff0(%rbp) /* i */
//
//.Ltest2_300:
//	cmpl $10,-0xff0(%rbp) /* i */
//	jl .Ltest2_390



/*************************************/
	
.Ltest2_1:

	movl $1,%eax
.Ltest2_0:
	leave
	ret

