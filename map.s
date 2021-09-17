
.globl get,put

.comm khead,8,32


f:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp


	movl $0,%eax
	leave
	ret


put:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp
	
	movq %rdi,-0x1000(%rbp) /* key */
	movq %rsi,-0xff8(%rbp) /* val */

	movq -0xff8(%rbp),%rdx /* val */
	movq -0x1000(%rbp),%rsi /* key */
	leaq khead(%rip),%rdi
	call add_key 

	movl $0,%eax
	leave
	ret

add_key:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* khead */
	movq %rsi,-0xff8(%rbp) /* key */
	movq %rdx,-0xff0(%rbp) /* val */


	movq -0x1000(%rbp),%rdi /* khead */
	cmpq $0,(%rdi)
	je .Ladd_key_400

	movl $24,%edi
	call malloc 

	movq %rax,%rdi
	movq -0xff8(%rbp),%rax /* key */
	movq %rax,0(%rdi)
	movq $0,8(%rdi) 
	movq -0xff0(%rbp),%rax /* val */
	movq %rax,16(%rdi) /* val */

	movq %rdi,%rax
	movq -0x1000(%rbp),%rdi
	movq (%rdi),%rdi 
.Ladd_key_450:
	movq %rdi,%rcx 
	movq 8(%rdi),%rdi 
	cmpq $0,%rdi
	jne .Ladd_key_450
	movq %rax,8(%rcx) /* next */

	jmp .Ladd_key_0

.Ladd_key_400:
	movl $24,%edi
	call malloc 
	movq %rax,%rdi
	movq -0xff8(%rbp),%rax
	movq %rax,0(%rdi) /* key  */
	movq $0,8(%rdi) /* next */
	movq -0xff0(%rbp),%rax /* val */
	movq %rax,16(%rdi) /* val */


	movq -0x1000(%rbp),%rax /* khead */
	movq %rdi,(%rax) 

.Ladd_key_0:
	movl $0,%eax
	leave
	ret


get:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp 

	movq %rdi,-0x1000(%rbp) /* key */
	movq %rsi,-0xff8(%rbp) /* head */

	movq -0xff8(%rbp),%rdi /* head */
.Lget_500:
	cmpq $0,(%rdi) 
	je .Lget_400
	movq (%rdi),%rdi 
.Lget_490:
	movq -0x1000(%rbp),%rax /* key */
	cmpq %rax,0(%rdi) /* key */
	jne .Lget_450

	movq 16(%rdi),%rax /* val */
	jmp .Lget_0

.Lget_450:
	movq 8(%rdi),%rdi /* node->next */
	cmpq $0,%rdi 
	jne .Lget_490

.Lget_400:

	movq $0,%rax
.Lget_0:
	leave
	ret
