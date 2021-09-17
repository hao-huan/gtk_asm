
.text
.globl f3,queue_add,del_fun

.comm head,8,32
.comm thead,8,32

.section .rodata

.LC0:
	.string "data=%d\n"

.LC1:
	.string "链表里面是空的\n"

.LC2:
	.string "tail data = %d\n"

.LC3:
	.string "--add--\n"

.LC4:
	.string "---del--\n"

.LC5:
	.string "添加元素: %d\n"

.LC6:
	.string "删除元素: %d\n"

.LC7:
	.string "arr"

.LC8:
	.string "["

.text
fun:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq $0,-0x1000(%rbp)  /* */
	movl $0,-0xff8(%rbp) /* num */
	movl $0,-0xff4(%rbp) /* i */

	movl $0,%edi 
	call time 

	movl %eax,%edi 
	call srand 

	call rand 

	movl $100,%ebx
	xorq %rdx,%rdx
	idivl %ebx 

	movl %edx,-0xff8(%rbp) /* num */

	movl $20,%edi
	call malloc 
	movq %rax,-0x1000(%rbp)

	movq -0x1000(%rbp),%rdi 
	movl -0xff8(%rbp),%eax /* num */
	movl %eax, 0(%rdi) /* node->num */
	movq $0,4(%rdi) /* node->next */

	movl $0,%eax
	leave
	ret


get_rand:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* p */

	movl $0,%edi 
	call time 

	movl %eax,%edi 
	call srand 

	call rand 

	movl $100,%ebx
	xorq %rdx,%rdx
	idivl %ebx 

	movq -0x1000(%rbp),%rdi /* p */
	movl %edx,(%rdi) /* num */

	movl $0,%eax
	leave
	ret



/* 判断是否为头节点 */
is_head_node:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* node */

	cmpq $0,12(%rdi) /* node->prev */
	je .Lis_head_node_1
	movl $0,%eax
	jmp .Lis_head_node_0

.Lis_head_node_1:
	movl $1,%eax

.Lis_head_node_0:
	leave
	ret

/*
	struct node{
	 long num,
	 node * next;
	 node * prev;
	 int type;
	 paint * p;
	}

*/



/* 添加元素*/
queue_add:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* paint */
	movl %esi,-0xff8(%rbp) /* num */
	movl %edx,-0xff4(%rbp) /* type */
	movq $0,-0xff0(%rbp) /* firstnode */
	movq $0,-0xfe0(%rbp) /* prevnode */
	movq %r9,-0xfd0(%rbp) /* node */
	movq %rcx,-0xfc0(%rbp) /* head */
	movq %r8,-0xfb0(%rbp) /* thead */


	movq -0xfc0(%rbp),%rdi /* head */
	movq (%rdi),%rdi 
	movq %rdi,-0xff0(%rbp) /* firstnode */

	movq -0xfd0(%rbp),%rax /* node */
	movq %rax,%rdi
	movl -0xff8(%rbp),%eax /* num */
	movl %eax,0(%rdi) /* node->data */
	movq $0,8(%rdi)  /* node->next */
	movq $0,16(%rdi) /* node->prev */
	movl -0xff4(%rbp),%eax /* type */
	movl %eax,24(%rdi) /* node->type */

	movq -0x1000(%rbp),%rax /* paint */
	movq %rax,28(%rdi) /* node->p */


	movq -0xff0(%rbp),%rcx /* firstnode */
	movq -0xfd0(%rbp),%rdi /* node */
	cmpq $0,%rcx 
	jne .Lqueue_add_400
	movq -0xfc0(%rbp),%rcx 
	movq %rdi,0(%rcx) /* head */

	movq -0xfb0(%rbp),%rcx /* thead */
	movq %rdi,(%rcx)

	jmp .Lqueue_add_0

.Lqueue_add_400:
	movq %rdi,16(%rcx) /* firstnode->prev */
	movq %rcx,8(%rdi) /* next  */

	movq -0xfc0(%rbp),%rcx
	movq %rdi,(%rcx)

.Lqueue_add_0:

	movl $0,%eax
	leave
	ret

foreach_by_tail:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* tailnode*/
	movq %rdi,-0xff8(%rbp) /* prevnode */

	movq -0x1000(%rbp),%rdi /* node */
	cmpq $0,%rdi
	je .Lforeach_by_tail_0

.Lforeach_by_tail_400:
	movl 0(%rdi),%esi /* node->data */
	leaq .LC2(%rip),%rdi
	movl $0,%eax 
	call printf 

	movq -0xff8(%rbp),%rdi /* prevnode*/
	movq 12(%rdi),%rdi /* node->prev */
	movq %rdi,-0xff8(%rbp) /* prevnode*/
	cmpq $0,%rdi
	jne .Lforeach_by_tail_400

.Lforeach_by_tail_0:
	movl $0,%eax
	leave
	ret

find_last:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* head */

	movq -0x1000(%rbp),%rdi
	cmpq $0,%rdi
	jne .Lfind_last_400
	
	movq %rdi,%rax
	jmp .Lfind_last_0

.Lfind_last_420:
	movq %rdi,%rcx 
	movq 8(%rdi),%rdi  /* p->next */

.Lfind_last_400:

	cmpq $0,%rdi /* p->next */
	jne .Lfind_last_420

	movq %rcx,%rax 
.Lfind_last_0:
	leave
	ret

add_fun:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movl $0,-0x1000(%rbp) /* sum */


	leaq .LC3(%rip),%rdi
	movl $0,%eax 
	call printf 

	jmp .Ladd_fun_400

.Ladd_fun_500:

	movl -0x1000(%rbp),%esi /* num */
	leaq .LC5(%rip),%rdi
	movl $0,%eax
	call printf 

	movl $1,%edi
	call sleep 

.Ladd_fun_400:
	jmp .Ladd_fun_500

	movl $0,%eax
	leave
	ret

del_fun:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* node */
	movq %rsi,-0xff8(%rbp) /* thead */

	jmp .Ldel_fun_400

.Ldel_fun_500:
	
	movq -0x1000(%rbp),%rdi 
	cmpq $0,%rdi 
	je .Ldel_fun_0

	movq %rdi,-0x1000(%rbp)

	movq -0x1000(%rbp),%rdi
	movq 16(%rdi),%rdi /* node->prev */
	cmpq $0,%rdi
	je .Ldel_fun_410 
	movq $0,8(%rdi)  /* node->prev->next */

.Ldel_fun_410:
	movq -0x1000(%rbp),%rdi

	movq -0xff8(%rbp),%rcx 
	movq (%rcx),%rcx
	cmpq %rcx,%rdi
	jne .Ldel_fun_0 


	movq -0x1000(%rbp),%rdi 
	movl 0(%rdi),%esi 
	leaq .LC6(%rip),%rdi
	movl $0,%eax 
	call printf 


	movq -0x1000(%rbp),%rdi 

	movq 16(%rdi),%rax /* node->prev */
	movq -0xff8(%rbp),%rcx 
	movq %rax ,(%rcx) 

	movq $0,16(%rdi) 

	movq 28(%rdi),%rdi /* node->paint */
	call free 
	
	movq -0x1000(%rbp),%rdi
	call free 


.Ldel_fun_400:
	jmp .Ldel_fun_500


.Ldel_fun_0:
	movl $0,%eax
	leave
	ret



