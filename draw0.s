
.text
.globl draw0,draw1,itoa


.section .rodata

.LC0: 
	.string "x1=%d,y1=%d\n"

.LC1: 
	.string "x2=%d,y2=%d\n"

.LC2:
	.string "rect_address=%ld\n"

.LC3:
	.string "id=%ld\n"

.text


draw1:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */
	movq $0,-0xf70(%rbp) /* node */

	
	movq -0x1000(%rbp),%rsi /* widget */

	leaq thead(%rip),%rdi
	movq 0(%rdi),%rdi 
	cmpq $0,%rdi
	je .Ldraw1_1

	movq %rdi,-0xf70(%rbp) /* node */

	movq 66(%rdi),%rsi /* id */
	leaq .LC3(%rip),%rdi 
	movl $0,%eax 
	call printf 

	movq -0xf70(%rbp),%rdi /*node*/

	movl 24(%rdi),%ecx /* type */
	cmpl $1,%ecx
	jne .Ldraw1_500

	/* 数字 */
	call draw_num 

	jmp .Ldraw1_200

.Ldraw1_500:
	movl 24(%rdi),%ecx
	cmpl $2,%ecx
	jne .Ldraw1_480
	/* 箭头 */
	movq -0xf70(%rbp),%rdi /* node */
	movq 28(%rdi),%rdi /* rect */

	movq %rdi,%rsi 
	leaq .LC2(%rip),%rdi
	movl $0,%eax 
	call printf 

	movq -0xf70(%rbp),%rdi /* node */
	movq 28(%rdi),%rdi /* rect */

	movl 4(%rdi),%edx  /* y2 */
	movl 0(%rdi),%esi  /* x2 */
	leaq .LC0(%rip),%rdi
	movl $0,%eax 
	call printf 

	movq -0xf70(%rbp),%rdi /* node */
	movq 28(%rdi),%rdi /* rect */

	movl 12(%rdi),%edx  /* y1 */
	movl 8(%rdi),%esi  /* x1 */
	leaq .LC1(%rip),%rdi
	movl $0,%eax 
	call printf 

	movq -0xf70(%rbp),%rdi /* node */
	movq 28(%rdi),%rdi /* rect */

	movl 12(%rdi),%r8d  /* y2 */
	movl 8(%rdi),%ecx /* x2 */
	movl 4(%rdi),%edx /* y1 */
	movl 0(%rdi),%esi /* x1 */
	movq -0x1000(%rbp),%rdi /* widget */
	call draw_arrow 

	jmp .Ldraw1_200

.Ldraw1_480:
	movl 24(%rdi),%ecx
	cmpl $3,%ecx
	jne .Ldraw1_480

	call draw_num 

.Ldraw1_200:
	leaq thead(%rip),%rsi
	movq -0xf70(%rbp),%rdi /* node */
	call del_fun 


	movq -0x1000(%rbp),%rdi /* widget */
	call gtk_widget_queue_draw 



.Ldraw1_1:
	movl $0,%eax
	leave
	ret


draw_rect_red:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi, -0x1000(%rbp) /* update_rect*/
	movq %rsi,-0xff8(%rbp) /* widget */

	movq -0x1000(%rbp),%rdi /* update_rect*/

	movl 12(%rdi),%eax /*update_rect.height */
	movslq %eax,%rax
	pushq %rax 
	movl 8(%rdi),%r9d /* update_rect.width */
	movl 4(%rdi),%r8d /* update_rect.y */
	movl 0(%rdi),%ecx /* update_rect.x */

	movl $1,%edx 

	movq -0xff8(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 792(%rdi),%rsi /* widget->style->black_gc */
	
	movq pixmap(%rip),%rdi 
	call gdk_draw_rectangle 

	movl $0,%edx 
	movq -0x1000(%rbp),%rsi /* update_rect */

	movq -0xff8(%rbp),%rdi /* widget */
	movq 80(%rdi),%rdi /* widget->window */
	call gdk_window_invalidate_rect


	movl $0,%eax
	leave
	ret 


draw_circle:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi, -0x1000(%rbp) /* update_rect*/
	movq %rsi,-0xff8(%rbp) /* widget */

	movq -0x1000(%rbp),%rdi /* update_rect*/
//	0(%rdi)  rect.x
//	4(%rdi)  rect.y 

	pushq $23040
	pushq $0
	pushq $30
	movl $30,%r9d 
//	movl $600,%r8d 
//	movl $600,%ecx
	movl 4(%rdi),%r8d 
	movl 0(%rdi),%ecx

	movl $1,%edx

	movq -0xff8(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 792(%rdi),%rsi /* widget->style->black_gc */

	movq pixmap(%rip),%rdi
	call gdk_draw_arc 


	movq -0xff8(%rbp),%rdi /* widget */
	call gtk_widget_queue_draw 


	movl $0,%eax
	leave
	ret 



draw_line:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi, -0x1000(%rbp) /* update_rect*/
	movq %rsi,-0xff8(%rbp) /* widget */

	movq -0x1000(%rbp),%rdi /* update_rect*/

	movl $1,%r8d 
	movl $1,%ecx 
	movl $0,%edx 
	movl $5,%esi 

	movq -0xff8(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 792(%rdi),%rdi /* widget->style->black_gc */

	call gdk_gc_set_line_attributes

	movq -0x1000(%rbp),%rdi /* update_rect*/

	movl 12(%rdi),%ecx /* y2 */
	movl 8(%rdi),%edx /* x2 */

	movl 4(%rdi),%r9d /* y1 */
	movl 0(%rdi),%r8d /* x1 */

	movq -0xff8(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 792(%rdi),%rsi /* widget->style->black_gc */
	
	movq pixmap(%rip),%rdi 
	call gdk_draw_line 

	movq -0xff8(%rbp),%rdi /* widget */
	call gtk_widget_queue_draw 

	movl $0,%eax
	leave
	ret 




draw_rect:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* node */
	movq %rsi,-0xff8(%rbp) /* widget */

	movq -0x1000(%rbp),%rdi 
	movq 28(%rdi),%rdi /* update_rect*/

	movl 12(%rdi),%eax /*update_rect.height */
	movslq %eax,%rax
	pushq %rax 
	movl 8(%rdi),%r9d /* update_rect.width */
	movl 4(%rdi),%r8d /* update_rect.y */
	movl 0(%rdi),%ecx /* update_rect.x */

	movl $1,%edx 

	movq -0xff8(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 800(%rdi),%rsi /* widget->style->black_gc */
	
	movq pixmap(%rip),%rdi 
	call gdk_draw_rectangle 

	movl $0,%edx 
	movq -0x1000(%rbp),%rdi 
	movq 28(%rdi),%rsi /* update_rect */

	movq -0xff8(%rbp),%rdi /* widget */
	movq 80(%rdi),%rdi /* widget->window */
	call gdk_window_invalidate_rect

	movl $0,%eax
	leave
	ret 


draw_num:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* node */
	movq %rsi,-0xff8(%rbp) /* widget */

	movq $0,-0xfe8(%rbp) /* font */
	movl $0,-0xf10(%rbp) /* data */
	movq $0,-0xf90(%rbp) /* layout */
	movq $0,-0xf88(%rbp) /* rect */
	movq $0,-0xf70(%rbp) /* line */


	movq -0x1000(%rbp),%rdi /* node */
	movl 0(%rdi),%eax
	movl %eax,-0xf10(%rbp) /* data */


	leaq .LC13(%rip),%rdi
	call pango_font_description_from_string
	movq %rax,-0xfe8(%rbp) /* font */

	movl $20,%eax /* fontSize */
	sall $10,%eax /* fontSize * PANGO_SCALE */
	movl %eax,%esi 
	movq -0xfe8(%rbp),%rdi /* font */
	call pango_font_description_set_size 


	movq -0x1000(%rbp),%rdi 
	movq 28(%rdi),%rdi /* update_rect*/

	movl 12(%rdi),%eax /*update_rect.height */
	movslq %eax,%rax
	pushq %rax 
	movl 8(%rdi),%r9d /* update_rect.width */
	movl 4(%rdi),%r8d /* update_rect.y */
	movl 0(%rdi),%ecx /* update_rect.x */

	movl $1,%edx 

	movq -0xff8(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 800(%rdi),%rsi /* widget->style->black_gc */
	
	movq pixmap(%rip),%rdi 
	call gdk_draw_rectangle 

	movl $0,%edx 
	movq -0x1000(%rbp),%rdi 
	movq 28(%rdi),%rsi /* update_rect */

	movq -0xff8(%rbp),%rdi /* widget */
	movq 80(%rdi),%rdi /* widget->window */
	call gdk_window_invalidate_rect

	leaq buffer(%rip),%rsi 
	movl -0xf10(%rbp),%edi /* data */
	call itoa 

	leaq buffer(%rip),%rdi /* str */
	call strlen 
	pushq %rax 
	leaq buffer(%rip),%r9 /* str */

	leaq buffer(%rip),%rsi 
	movq -0xff8(%rbp),%rdi /* widget */
	call gtk_widget_create_pango_layout
	movq %rax,-0xf90(%rbp) /* layout */

	movq -0xfe8(%rbp),%rsi /* font */
	movq -0xf90(%rbp),%rdi /* layout */
	call pango_layout_set_font_description 

	movq -0xf90(%rbp),%r8 /* layout */

	movq -0x1000(%rbp),%rdi 
	movq 28(%rdi),%rdi /* update_rect */


	movl 8(%rdi),%eax /* update_rect.width */
	movl 12(%rdi),%eax /*update_rect.height */

	movl 4(%rdi),%ecx /* update_rect.y */
	movl 12(%rdi),%eax /* rect.height */
	movl $3,%ebx
	xorq %rdx,%rdx
	idivl %ebx 
	addl %eax,%ecx  /* y */
	

	movl 0(%rdi),%esi /* update_rect.x */
	movl 8(%rdi),%eax /* rect.width */
	movl $3,%ebx
	xorq %rdx,%rdx
	idivl %ebx 
	addl %esi,%eax  
	movl %eax,%edx  /* x */

	movq -0xff8(%rbp),%rdi /* gw */
	movq 48(%rdi),%rdi /* gw->style */
	movq 864(%rdi),%rsi  /* gw->style->black_gc */

	movq pixmap(%rip),%rdi
	call gdk_draw_layout 


/*****************************************/
	movq -0x1000(%rbp),%rdi /* node */
	leaq 36(%rdi),%rsi 
	movq -0xff8(%rbp),%rdi /* widget */
	call gtk_widget_create_pango_layout
	movq %rax,-0xf90(%rbp) /* layout */

	movq -0xfe8(%rbp),%rsi /* font */
	movq -0xf90(%rbp),%rdi /* layout */
	call pango_layout_set_font_description 

	movq -0xf90(%rbp),%r8 /* layout */

	movq -0x1000(%rbp),%rdi 
	movq 28(%rdi),%rdi /* update_rect */


	movl 8(%rdi),%eax /* update_rect.width */
	movl 12(%rdi),%eax /*update_rect.height */

	movl 4(%rdi),%ecx /* update_rect.y */
	subl $40,%ecx
		

	movl 0(%rdi),%esi /* update_rect.x */
	subl $30,%esi
	movl 8(%rdi),%eax /* rect.width */
	movl $3,%ebx
	xorq %rdx,%rdx
	idivl %ebx 
	addl %esi,%eax  
	movl %eax,%edx  /* x */

	movq -0xff8(%rbp),%rdi /* gw */
	movq 48(%rdi),%rdi /* gw->style */
	movq 864(%rdi),%rsi  /* gw->style->black_gc */

	movq pixmap(%rip),%rdi
	call gdk_draw_layout 
/*****************************************/






	movq -0xfe8(%rbp),%rdi /* font */
	call pango_font_description_free 


	movl $0,%eax
	leave
	ret 



itoa:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp
	
	movl %edi,-0x1000(%rbp) /* x */
	movq %rsi,-0xff8(%rbp) /* s */

	movl $0,-0xff0(%rbp) /* v */
	movl $0,-0xfec(%rbp) /* xx */
	movl $0,-0xfe8(%rbp) /* i */
	movl $0,-0xfe4(%rbp) /* j */
	movl $0,-0xfe0(%rbp) /* n */

	movb $0,-0xfd8(%rbp) /* c */

	movl -0x1000(%rbp),%edi /* x */
	call abs
	movl %eax,-0xfec(%rbp) /* xx */

	jmp .Litoa_400

.Litoa_500:
	movl -0xfec(%rbp),%eax /* xx */
	movl $10,%ebx
	xorq %rdx,%rdx
	idivl %ebx
	movl %edx,-0xff0(%rbp) /* v */

	movl -0xff0(%rbp),%eax /* v */
	addl $('0'),%eax
	movl %eax,%ecx

	movl -0xfe0(%rbp),%eax /* n */
	movslq %eax,%rax 
	movq -0xff8(%rbp),%rdi /* s */
	movl %ecx,0(%rdi,%rax,1) /* s[n] */

	addl $1,-0xfe0(%rbp) /* n */

	movl -0xfec(%rbp),%eax /* xx */
	subl -0xff0(%rbp),%eax /* v */
	movl $10,%ebx
	xorq %rdx,%rdx
	idivl %ebx
	movl %eax,-0xfec(%rbp) /* xx */
	
	cmpl $0,-0xfec(%rbp) /* xx */
	jne .Litoa_400
	 
	jmp .Litoa_380 /* break */

.Litoa_400:
	jmp .Litoa_500

.Litoa_380:
	cmpl $0,-0x1000(%rbp) /* x */
	jge .Litoa_350


	movl -0xfe0(%rbp),%eax /* n */
	movslq %eax,%rax 
	movq -0xff8(%rbp),%rdi /* s */
	movb $('-'),0(%rdi,%rax,1) /* s[n] */
	
	addl $1,-0xfe0(%rbp) /* n */

.Litoa_350:
	movl $0,-0xfe8(%rbp) /* i */
	jmp .Litoa_300

.Litoa_340:
	movl -0xfe8(%rbp),%eax /* i */
	movslq %eax,%rax 
	movq -0xff8(%rbp),%rdi /* s */
	movb 0(%rdi,%rax,1),%al /* s[i] */
	movb %al,-0xfd8(%rbp) /* c */

	movl -0xfe0(%rbp),%eax /* n */
	subl $1,%eax
	subl -0xfe8(%rbp),%eax /* i */
	movslq %eax,%rax 
	movq -0xff8(%rbp),%rdi /* s */
	movb 0(%rdi,%rax,1),%cl /* s[n-i-1] */

	movl -0xfe8(%rbp),%eax /* i */
	movslq %eax,%rax 
	movq -0xff8(%rbp),%rdi /* s */
	movb %cl,0(%rdi,%rax,1) /* s[i] */

	movb -0xfd8(%rbp),%cl /* c */

	movl -0xfe0(%rbp),%eax /* n */
	subl $1,%eax
	subl -0xfe8(%rbp),%eax /* i */
	movslq %eax,%rax
	movq -0xff8(%rbp),%rdi /* s */
	movb %cl,0(%rdi,%rax,1) /* s[n-i-1] */

	addl $1,-0xfe8(%rbp) /* i */

.Litoa_300:
	movl -0xfe0(%rbp),%eax /* n */
	sarl $1,%eax
	cmpl -0xfe8(%rbp),%eax /* i */
	jg .Litoa_340


	movl -0xfe0(%rbp),%eax /* n */
	movslq %eax,%rax
	movq -0xff8(%rbp),%rdi /* s */
	movb $0,0(%rdi,%rax,1) /* s[n] */

	movl $0,%eax
	leave
	ret

