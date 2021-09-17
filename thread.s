/* 多线程 */

.text 
.data 
.comm thread,16,32
.comm mut,40,32
.comm number,4,32
.comm i,4,32

.section .rodata 
.LC0:
	.string "thread1 : I'm thread 1\n"

.LC1:
	.string "thread1 : number = %d\n"

.LC2:
	.string "thread1 :主函数在等我完成任务吗?\n"

.LC3:
	.string "thread2 : I'm thread 2\n"

.LC4:
	.string "thread2 : number = %d\n"

.LC5:
	.string "thread2 :主函数在等我完成任务吗?\n"

.LC6:
	.string "线程1创建失败!\n"

.LC7:
	.string "线程1被创建\n"

.LC8:
	.string "线程2创建失败\n"

.LC9:
	.string "线程2被创建\n"

.LC10:
	.string "线程1已经结束\n"

.LC11:
	.string "线程2已经结束\n"

.LC12:
	.string "我是主函数哦，我正在创建线程,呵呵\n"

.LC13:
	.string "我是主函数哦,我正在等待线程完成任务阿,呵呵\n"

.text

.globl main2

thread1:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	leaq .LC0(%rip),%rdi
	movl $0,%eax 
	call printf 

	movl $0,i(%rip)
	jmp .Lthread1_400

.Lthread1_500:
	movl number(%rip),%esi  /* number */
	leaq .LC1(%rip),%rdi
	movl $0,%eax 
	call printf 

	leaq mut(%rip),%rdi
	call pthread_mutex_lock

	addl $1,number(%rip) /* number */

	leaq mut(%rip),%rdi
	call pthread_mutex_unlock 

	movl $2,%edi 
	call sleep 

	addl $1,i(%rip) 

.Lthread1_400:
	cmpl $10,i(%rip)
	jl .Lthread1_500

	leaq .LC2(%rip),%rdi
	movl $0,%eax 
	call printf 

	movl $0,%edi
	call pthread_exit

	movl $0,%eax 
	leave
	ret

thread2:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	leaq .LC3(%rip),%rdi
	movl $0,%eax 
	call printf 

	movl $0,i(%rip)
	jmp .Lthread2_400

.Lthread2_500:
	movl number(%rip),%esi /* number */
	leaq .LC4(%rip),%rdi
	movl $0,%eax
	call printf 

	leaq mut(%rip),%rdi
	movl $0,%eax 
	call pthread_mutex_lock 
	
	addl $1,number(%rip)

	leaq mut(%rip),%rdi
	movl $0,%eax
	call pthread_mutex_unlock 

	movl $3,%edi
	movl $0,%eax
	call sleep 

	addl $1,i(%rip)

.Lthread2_400:
	cmpl $10,i(%rip)
	jl .Lthread2_500

	leaq .LC5(%rip),%rdi
	movl $0,%eax
	call printf 
	
	movl $0,%edi
	movl $0,%eax 
	call pthread_exit 

	movl $0,%eax 
	leave
	ret

thread_create:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movl $0,-0x1000(%rbp) /* temp */

	movl $16,%edx
	movl $0,%esi
	leaq thread(%rip),%rdi
	call memset 

	movq $0,%rcx
	leaq thread1(%rip),%rdx
	movq $0,%rsi 

	movl $0,%eax 
	sall $3,%eax
	movslq %eax,%rax
	leaq thread(%rip),%rdi 
	leaq 0(%rdi,%rax,1),%rdi /* thread[0] */
	
	call pthread_create 
	movl %eax,-0x1000(%rbp) /* temp */

	cmpl $0,-0x1000(%rbp) /* temp */
	je .Lthread_create_400

	leaq .LC6(%rip),%rdi
	movl $0,%eax 
	call printf 

	jmp .Lthread_create_380

.Lthread_create_400:
	leaq .LC7(%rip),%rdi
	movl $0,%eax
	call printf 

.Lthread_create_380:

	movq $0,%rcx 
	leaq thread2(%rip),%rdx 
	movq $0,%rsi 
	
	movl $1,%eax
	sall $3,%eax
	movslq %eax,%rax
	leaq thread(%rip),%rdi 
	leaq 0(%rdi,%rax,1),%rdi
	call pthread_create 
	movq %rax,-0x1000(%rbp) /* temp */

	cmpl $0,-0x1000(%rbp) /* temp */
	je .Lthread_create_350

	leaq .LC8(%rip),%rdi
	movl $0,%eax 
	call printf 

	jmp .Lthread_create_0

.Lthread_create_350:
	leaq .LC9(%rip),%rdi
	movl $0,%eax
	call printf 

.Lthread_create_0:
	movl $0,%eax 
	leave
	ret

thread_wait:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp


	movl $0,%eax
	sall $3,%eax
	movslq %eax,%rax 
	leaq thread(%rip),%rdi
	cmpq $0,0(%rdi,%rax,1) /* thread[0]  */
	je .Lthread_wait_400

	movq $0,%rsi
	movq 0(%rdi,%rax,1),%rdi /* thread[0] */
	call pthread_join 

	leaq .LC10(%rip),%rdi
	movl $0,%eax
	call printf 

.Lthread_wait_400:
	movl $1,%eax
	sall $3,%eax
	movslq %eax,%rax 
	leaq thread(%rip),%rdi
	cmpq $0,0(%rdi,%rax,1) /* thread[1]  */
	je .Lthread_wait_0

	movq $0,%rsi
	movq 0(%rdi,%rax,1),%rdi /* thread[1] */
	call pthread_join 

	leaq .LC11(%rip),%rdi
	movl $0,%eax 
	call printf 
	
.Lthread_wait_0:
	movl $0,%eax 
	leave
	ret

main2:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq $0,%rsi
	leaq mut(%rip),%rdi
	movl $0,%eax
	call pthread_mutex_init 

	leaq .LC12(%rip),%rdi
	movl $0,%eax
	call printf

	call thread_create 

	leaq .LC13(%rip),%rdi
	movl $0,%eax
	call printf

	call thread_wait

	movl $0,%eax 
	leave
	ret

