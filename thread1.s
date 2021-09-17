
.text
.globl arr,p_arr,p_arr1,p_arr2
.data
.comm arr,40,32
.comm p_arr,80,32
.comm p_arr1,80,32
.comm p_arr2,80,32
.comm count,4,32

count:
	.long 0


.section .rodata 

.LC0:
	.string "Hello World!"

.LC1:
	.string "create fail!"

.LC2:
	.string "create success!"

.LC3:
	.string "aaabbbcc"

.LC7:
	.string "arr"

.LC8:
	.string "["

.LC9:
	.string "]"

.LC10:
	.string "缓存"

.LC11:
	.string "%s"

.LC12:
	.string "clone_x=%d,clone_y=%d\n"

.LC13:
	.string "rect_clone_address=%ld\n"

.LC14:
	.string "i=%d\n"


.globl f

.text 



clone:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0xfe0(%rbp) /* node */
	movq %rsi,-0xff0(%rbp)  /* rectnode*/
	movq %rdx,-0xfc0(%rbp) /* key */
	movq $0,-0xfd0(%rbp) /* clone_node */
	movq $0,-0xfb0(%rbp) /* rect_clone */

	movl $74,%edi 
	call malloc
	movq %rax,-0xfd0(%rbp) /* clone_node */

	movl $74,%edx 
	movq -0xfe0(%rbp),%rsi /* node */
	movq %rax,%rdi 
	call memcpy 

	movl $16,%edi 
	call malloc
	movq %rax,-0xfb0(%rbp) /* rect_clone */


	movl $16,%edx 
	movq -0xff0(%rbp),%rsi /* rectnode */
	movq -0xfb0(%rbp),%rax /* rect_clone */
	movq %rax,%rdi 
	call memcpy 

	movq %rax, -0xfb0(%rbp) /* rect_clone */

	movq -0xfd0(%rbp),%rdi /* clone_node */
	movq -0xfb0(%rbp),%rax /* rect_clone */
	movq %rax,28(%rdi) /* paint */

	movq %rdi,%rsi  /* val */
	movq -0xfc0(%rbp),%rdi /* key */
	call put 


	movl $0,%eax
	leave
	ret


clone_arrow:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0xfe0(%rbp) /* node */
	movq %rsi,-0xff0(%rbp)  /* rectnode*/
	movq %rdx,-0xfc0(%rbp) /* key */
	movq $0,-0xfd0(%rbp) /* clone_node */
	movq $0,-0xfb0(%rbp) /* rect_clone */

	movl $74,%edi 
	call malloc
	movq %rax,-0xfd0(%rbp) /* clone_node */

	movl $74,%edx 
	movq -0xfe0(%rbp),%rsi /* node */
	movq %rax,%rdi 
	call memcpy 

	movl $16,%edi 
	call malloc
	movq %rax,-0xfb0(%rbp) /* rect_clone */


	movl $16,%edx 
	movq -0xff0(%rbp),%rsi /* rectnode */
	movq -0xfb0(%rbp),%rax /* rect_clone */
	movq %rax,%rdi 
	call memcpy 

	movq %rax, -0xfb0(%rbp) /* rect_clone */

	movq -0xfd0(%rbp),%rdi /* clone_node */
	movq -0xfb0(%rbp),%rax /* rect_clone */
	movq %rax,28(%rdi) /* paint */

//	movq %rdi,%rsi  /* val */
//	movq -0xfc0(%rbp),%rdi /* key */
//	call put 


	movl $0,%eax
	leave
	ret



set_arr_tip:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp 

	movl %edi,-0x1000(%rbp) /* data */
	movq $0,-0xfe0(%rbp) /* node */
	movl $0,-0xfd0(%rbp) /* string i */

	movl $74,%edi 
	call malloc 
	movq %rax,-0xfe0(%rbp) /* node */

	leaq .LC7(%rip),%rsi 
	movq -0xfe0(%rbp),%rdi 
	leaq 36(%rdi),%rdi 
	call strcpy 

	leaq .LC8(%rip),%rsi 
	movq -0xfe0(%rbp),%rdi  /* node */
	leaq 36(%rdi),%rdi 
	call strcat 

	leaq -0xfd0(%rbp),%rsi  /* string i*/
	movl -0x1000(%rbp),%edi /* data */
	call itoa 

	leaq -0xfd0(%rbp),%rsi /* string i*/
	movq -0xfe0(%rbp),%rdi  /* node */
	leaq 36(%rdi),%rdi 
	call strcat 

	leaq .LC9(%rip),%rsi 
	movq -0xfe0(%rbp),%rdi  /* node */
	leaq 36(%rdi),%rdi 
	call strcat 

	movq -0xfe0(%rbp),%rax /* node */
	leave
	ret


set_cache_tip:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp 

	movq $0,-0xfe0(%rbp) /* node */
	movl $0,-0xfd0(%rbp) /* string i */

	movl $74,%edi 
	call malloc 
	movq %rax,-0xfe0(%rbp) /* node */

	leaq .LC10(%rip),%rsi 
	movq -0xfe0(%rbp),%rdi 
	leaq 36(%rdi),%rdi 
	call strcpy 
	
	movq -0xfe0(%rbp),%rax /* node */
	leave
	ret


add_num:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rsi,-0xfc0(%rbp) /* address */
	movl %edi,-0x1000(%rbp) /* i */
	movq %rdx,-0xfe0(%rbp) /* node */
	movl %ecx,-0xfd8(%rbp) /* type */
	movq $0,-0xfd0(%rbp) /* string i */
	movq %r8,-0xff0(%rbp) /* rectnode */


	movq -0xfe0(%rbp),%r9 /* node */
	leaq thead(%rip),%r8
	leaq head(%rip),%rcx 
	movl -0xfd8(%rbp),%edx /* type */

	movq -0xfc0(%rbp),%rax 
	movl (%rax),%esi 
	movq -0xff0(%rbp),%rdi /* rectnode */


	movl -0xfd8(%rbp),%eax /* type */
	cmpl $1,%eax
 	jne .Ladd_num_500

	movl -0x1000(%rbp),%eax /* i */
	addl $1,%eax 
	imull $110,%eax 
	movl %eax,0(%rdi) /* x */
	movl $50,4(%rdi) /* y */
	movl $100,8(%rdi) /* width */
	movl $100,12(%rdi) /* height */
	call queue_add 

	movq -0xfc0(%rbp),%rdx /* key */
	movq -0xff0(%rbp),%rsi  /* rectnode*/
	movq -0xfe0(%rbp),%rdi /* node */
	call clone 

	jmp .Ladd_num_200

.Ladd_num_500:
	cmpl $2,%eax /* arrow */
	jne .Ladd_num_490

	call queue_add 

	jmp .Ladd_num_200


.Ladd_num_490:
	cmpl $3,%eax
	jne .Ladd_num_480

	movl $450,0(%rdi) /* x */
	movl $500,4(%rdi) /* y */
	movl $200,8(%rdi) /* width */
	movl $200,12(%rdi) /* height */
	call queue_add 

	movq -0xfc0(%rbp),%rdx /* key */
	movq -0xff0(%rbp),%rsi  /* rectnode*/
	movq -0xfe0(%rbp),%rdi /* node */
	call clone 


	jmp .Ladd_num_200

.Ladd_num_480:
	nop


.Ladd_num_200:

	movl $0,%eax
	leave
	ret

fun:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movl $0,-0x1000(%rbp) /* i */
	movl $0,-0xffc(%rbp) /* j */
	movl $0,-0xff8(%rbp) /* temp */
	movq $0,-0xff0(%rbp) /* rectnode */
	movq $0,-0xfe0(%rbp) /* node */
	movq $0,-0xfd0(%rbp) /* clone_node */
	movq $0,-0xfc0(%rbp) /* address */
	movl $0,-0xfb0(%rbp) /* cache */
	movq $0,-0xfa0(%rbp) /* arrow_src */
	movq $0,-0xf90(%rbp) /* arrow_dst */

	movl $0,-0x1000(%rbp) /* i */
	jmp .Lfun_600

.Lfun_700: 
	movl -0x1000(%rbp),%edi /* i */
	call set_arr_tip
	movq %rax,-0xfe0(%rbp) /* node */

	movl $16,%edi
	call malloc 
	movq %rax,%r8 /* rectnode */

	movl $1,%ecx /* type */
	movq -0xfe0(%rbp),%rdx /* node */

	movl -0x1000(%rbp),%eax /* i */
	sall $2,%eax
	movslq %eax,%rax 
	leaq arr(%rip),%rdi 
	leaq 0(%rdi,%rax,1),%rsi /* address */
	movl -0x1000(%rbp),%edi /* i */
	movl %edi,count(%rip) /* count */
	call add_num 

	addl $1,-0x1000(%rbp) /* i */

.Lfun_600:
	cmpl $10,-0x1000(%rbp) /* i */
	jl .Lfun_700


	call set_cache_tip
	movq %rax,-0xfe0(%rbp) /* node */

	movl $16,%edi
	call malloc 
	movq %rax,%r8 /* rectnode */

	movl $3,%ecx /* type */
	movq -0xfe0(%rbp),%rdx /* node */

	movl -0x1000(%rbp),%eax /* i */
	sall $2,%eax
	movslq %eax,%rax 
	leaq arr(%rip),%rdi 
	leaq -0xfb0(%rbp),%rsi /* cache  */
	movl -0x1000(%rbp),%edi /* i */
	movl %edi,count(%rip) /* count */
	call add_num 

	movl $1,-0x1000(%rbp) /* i */
	jmp .Lfun_400

.Lfun_500:
	movl -0x1000(%rbp),%esi /* i */
	leaq .LC14(%rip),%rdi
	movl $0,%eax 
	call printf 

	movl $1,%edi
	call sleep 




	movl -0x1000(%rbp),%eax /* i */
	sall $2,%eax
	movslq %eax,%rax 
	leaq arr(%rip),%rdi 
	movl 0(%rdi,%rax,1),%ecx /* arr[i] */




//===============================================
//key khead 

//	movq $0,-0xfa0(%rbp) /* arrow_src */
//	movq $0,-0xf90(%rbp) /* arrow_dst */





	leaq khead(%rip),%rsi 
	leaq 0(%rdi,%rax,1),%rdi /* key */
	call get 
	movq %rax,-0xfa0(%rbp) /* arrow_src */

	leaq khead(%rip),%rsi 
	leaq -0xfb0(%rbp),%rdi /* cache */
	call get 
	movq %rax,-0xf90(%rbp) /* arrow_dst */

	call set_cache_tip
	movq %rax,-0xfe0(%rbp) /* node */

	movl $16,%edi
	call malloc 
	movq %rax,%r8 /* rectnode */
	movq %rax,%rdi 
	movq -0xfa0(%rbp),%rcx /* src */
	movq 28(%rcx),%rcx
	movl 0(%rcx),%eax /* src.x */
	movl %eax,0(%rdi) /* node.x1 */

	movl 4(%rcx),%eax /* src.y */
	movl %eax,4(%rdi) /* node.y1 */

	movq -0xf90(%rbp),%rcx /* dst */
	movq 28(%rcx),%rcx
	movl 0(%rcx),%eax
	movl %eax,8(%rdi) /* node.x2 */

	movl 4(%rcx),%eax
	movl %eax,12(%rdi) /* node.y2 */


	movl $2,%ecx  /* type */
	movq -0xfe0(%rbp),%rdx /* node */


	movl -0x1000(%rbp),%eax /* i */
	sall $2,%eax
	movslq %eax,%rax 
	leaq arr(%rip),%rdi 
	leaq 0(%rdi,%rax,1),%rsi /* address */
	movl -0x1000(%rbp),%edi /* i */
	movl %edi,count(%rip) /* count */
	call add_num 

//=================================================

	movl %ecx,-0xff8(%rbp) /* temp */

	movl -0x1000(%rbp),%eax /* i */
	subl $1,%eax
	movl %eax,-0xffc(%rbp) /* j */

	jmp .Lfun_420

.Lfun_490:
	movl -0xffc(%rbp),%eax /* j */
	sall $2,%eax
	movslq %eax,%rax 
	leaq arr(%rip),%rdi 
	movl 0(%rdi,%rax,1),%ecx /* arr[j] */

	movl -0xffc(%rbp),%eax /* j */
	addl $1,%eax
	sall $2,%eax
	movslq %eax,%rax
	leaq arr(%rip),%rdi
	movl %ecx,0(%rdi,%rax,1) /* arr[j+1] */

	subl $1,-0xffc(%rbp) /* j */

	movl $1,%edi
	call sleep 

.Lfun_420:
	movl -0xffc(%rbp),%eax /* j */
	sall $2,%eax
	movslq %eax,%rax
	leaq arr(%rip),%rdi
	movl 0(%rdi,%rax,1),%ecx /* arr[j] */
	cmpl %ecx,-0xff8(%rbp) /* temp */
	jl .Lfun_490

	movl -0xff8(%rbp),%ecx /* temp */
	
	movl -0xffc(%rbp),%eax /* j */
	addl $1,%eax
	sall $2,%eax
	movslq %eax,%rax
	leaq arr(%rip),%rdi 
	movl %ecx,0(%rdi,%rax,1) /* arr[j+1] */

	addl $1,-0x1000(%rbp) /* i */

.Lfun_400:
	cmpl $10,-0x1000(%rbp) /* i */
	jl .Lfun_500
	
	movl $0,%eax
	leave
	ret


f:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq $0,-0x1000(%rbp) /* thread */

	movl $0,%ecx 
	leaq fun(%rip),%rdx 
	movl $0,%esi 
	leaq -0x1000(%rbp),%rdi 
	call pthread_create
	cmpl $0,%eax
	jne .Lf_400
	
	jmp .Lf_0

.Lf_400:
	//leaq .LC1(%rip),%rdi
	//movl $0,%eax 
	//call printf 

.Lf_0:
	movl $0,%eax
	leave
	ret
