
.text
.globl draw_brush 




.text
.globl main

scribble_configure_event:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %fs:40,%rax
	movq %rax,-0x1000(%rbp)

	movq %rdi,-0xff8(%rbp) /* widget */
	movq %rsi,-0xff0(%rbp) /* event */
	movq %rdx,-0xfe8(%rbp) /* data */

	movq pixmap(%rip),%rax 
	testq %rax,%rax
	je .Lscribble_configure_event_400

	movl $80,%esi
	movq pixmap(%rip),%rdi
	movl $0,%eax
	call g_type_check_instance_cast
	movq %rax,%rdi
	movl $0,%eax
	call g_object_unref

.Lscribble_configure_event_400:


	movl $-1,%ecx 
	movq -0xff8(%rbp),%rdi /* widget */
	leaq 72(%rdi),%rdi /* widget->allocation */
	movl 4(%rdi),%edx /* widget->allocation.height */
	movl 0(%rdi),%esi /* widget->allocation.width */

	movq -0xff8(%rbp),%rdi /* widget */
	movq 80(%rdi),%rdi /* widget->window */
	movl $0,%eax
	call gdk_pixmap_new
	movq %rax,pixmap(%rip)

	movq -0xff8(%rbp),%rdi /* widget */
	leaq 72(%rdi),%rdi /* widget->allocation */
	movl 4(%rdi),%eax /* widget->allocation.height */
	movslq %eax,%rax
	pushq %rax
	movl 0(%rdi),%r9d /* widget->allocation.width */
	movl $0,%r8d
	movl $0,%ecx 
	movl $1,%edx
	movq -0xff8(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi
	movq 872(%rdi),%rsi /* widget->style->white_gc */
	movq pixmap(%rip),%rdi
	movl $0,%eax
	call gdk_draw_rectangle

	movl $1,%eax
	movq -0x1000(%rbp),%rcx
	xorq %fs:40,%rcx
	je .Lscribble_configure_event_0
	movl $0,%eax
	call __stack_chk_fail 

.Lscribble_configure_event_0:
	leave
	ret

scribble_expose_event:
	pushq %rbp
	movq %rsp,%rbp

	pushq %r15
	pushq %r14
	pushq %r13
	pushq %r12
	pushq %rbx

	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */
	movq %rsi,-0xff8(%rbp) /* event */
	movq %rdx,-0xff0(%rbp) /* data */
	
	movq -0xff8(%rbp),%rdi /* event */
	leaq 20(%rdi),%rdi /* event->area */

	movl 12(%rdi),%eax /* event->area.height */
	movl %eax,%r15d
	
	movl 8(%rdi),%eax /* event->area.width */
	movl %eax,%r14d

	movl 4(%rdi),%eax /* event->area.y*/
	movl %eax,%r13d

	movl 0(%rdi),%eax /* event->area.x */
	movl %eax,%r12d

	movl 0(%rdi),%r9d /* event->area.x */
	movl 4(%rdi),%r8d /* event->area.y */
	movl 0(%rdi),%ecx /* event->area.x */

	movq pixmap(%rip),%rbx

	call gtk_widget_get_type
	movq %rax,%rsi 
	movq -0x1000(%rbp),%rdi /* widget */
	call g_type_check_instance_cast 

	movq -0xff8(%rbp),%rdi /* event */
	leaq 20(%rdi),%rdi /* event->area */

	pushq %r15
	pushq %r14 
	pushq %r13 
	movl 0(%rdi),%r9d /* event->area.x */
	movl 4(%rdi),%r8d /* event->area.y */
	movl 0(%rdi),%ecx /* event->area.x */

	movq pixmap(%rip),%rdx 

	movq %rax,%rdi
	movl 34(%rdi),%eax
	sall $3,%eax
	movslq %eax,%rax

	movq -0x1000(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	leaq 544(%rdi),%rdi /* widget->style->fg_gc */
	movq 0(%rdi,%rax,1),%rsi /* widget->style->fg_gc[GTK_WIDGET_STATE(widget)] */

	movq -0x1000(%rbp),%rdi /* widget */
	movq 80(%rdi),%rdi /* widget->window */

	call gdk_draw_drawable
	addq $24,%rsp

	movl	$0, %eax
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	leave
	ret

draw_brush:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */
	movsd %xmm0,-0xff8(%rbp) /* x */
	movsd %xmm1,-0xff0(%rbp) /* y */

	movl $0,-0xfe0(%rbp) /* update_rect */

	movsd -0xff8(%rbp),%xmm0 /* x */
	subsd .LC1(%rip),%xmm0 /* 3 */
	cvtsd2si %xmm0,%eax 

	leaq -0xfe0(%rbp),%rdi /* */
	movl %eax,0(%rdi) /* update_rect.x */

	movsd -0xff0(%rbp),%xmm0 /* y */
	subsd .LC1(%rip),%xmm0 /* 3 */
	cvtsd2si %xmm0,%eax
	movl %eax,4(%rdi)  /* update_rect.y */

	movl $6,8(%rdi) /* update_rect.width */
//	movl $36,8(%rdi) /* update_rect.width */
	movl $6,12(%rdi) /* update_rect.height */
//	movl $36,12(%rdi) /* update_rect.height */


	leaq -0xfe0(%rbp),%rdi /* update_rect */
	movl 12(%rdi),%eax /*update_rect.height */
	movslq %eax,%rax
	pushq %rax 
	movl 8(%rdi),%r9d /* update_rect.width */
	movl 4(%rdi),%r8d /* update_rect.y */
	movl 0(%rdi),%ecx /* update_rect.x */

	movl $1,%edx 

	movq -0x1000(%rbp),%rdi /* widget */
	movq 48(%rdi),%rdi /* widget->style */
	movq 864(%rdi),%rsi /* widget->style->black_gc */
	
	movq pixmap(%rip),%rdi 
	movl $0,%eax
	call gdk_draw_rectangle 
	

	movl $0,%edx 
	leaq -0xfe0(%rbp),%rsi /* update_rect */

	movq -0x1000(%rbp),%rdi /* widget */
	movq 80(%rdi),%rdi /* widget->window */
	movl $0,%eax
	call gdk_window_invalidate_rect

	movl $0,%eax
	leave
	ret

scribble_button_press_event:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */
	movq %rsi,-0xff8(%rbp) /* event */
	movq %rdx,-0xff0(%rbp) /* data */

	movq pixmap(%rip),%rax /* */
	cmpq $0,%rax
	jne .Lscribble_button_press_event_400
	movl $0,%eax 
	jmp .Lscribble_button_press_event_0 

.Lscribble_button_press_event_400:
	movq -0xff8(%rbp),%rdi /* event */
	cmpl $1,52(%rdi) /* event->button */
	jne .Lscribble_button_press_event_390

	movq -0xff8(%rbp),%rdi /* event */
	movsd 32(%rdi),%xmm1  /* event->y */
	movsd 24(%rdi),%xmm0 /* event->x */
	movq -0x1000(%rbp),%rdi /* widget */
	movl $0,%eax
	call draw_brush

.Lscribble_button_press_event_390:
	movl $1,%eax
.Lscribble_button_press_event_0:
	leave
	ret

scribble_motion_notify_event:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */
	movq %rsi,-0xff8(%rbp) /* event */
	movq %rdx,-0xff0(%rbp) /* data */
	
	movl $0,-0xfe0(%rbp) /* x */
	movl $0,-0xfdc(%rbp) /* y */
	movl $0,-0xfd8(%rbp) /* state */
	
	cmpq $0,pixmap(%rip)
	jne .Lscribble_motion_notify_event_400

	movl $0,%eax
	jmp .Lscribble_motion_notify_event_0

.Lscribble_motion_notify_event_400:
	leaq -0xfd8(%rbp),%rcx /* state */
	leaq -0xfdc(%rbp),%rdx /* y */
	leaq -0xfe0(%rbp),%rsi /* x */
	
	movq -0xff8(%rbp),%rdi /* event */
	movq 8(%rdi),%rdi /* event->window */
	movl $0,%eax
	call gdk_window_get_pointer 

	movl -0xfd8(%rbp),%eax /* state */
	andl $256,%eax
	testl %eax,%eax
	je .Lscribble_motion_notify_event_1

	movl -0xfdc(%rbp),%edx /* y */
	movl -0xfe0(%rbp),%esi /* x */
	movq -0x1000(%rbp),%rdi  /* widget */
	movl $0,%eax 
	call draw_brush 

.Lscribble_motion_notify_event_1:
	movl $1,%eax
.Lscribble_motion_notify_event_0:
	leave
	ret

checkerboard_expose:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* da  */
	movq %rsi,-0xff8(%rbp) /* event */
	movq %rdx,-0xff0(%rbp) /* data */

	movl $0,-0xfe0(%rbp) /* i */
	movl $0,-0xfdc(%rbp) /* j */
	movl $0,-0xfd8(%rbp) /* xcount */
	movl $0,-0xfd4(%rbp) /* ycount */

	movq $0,-0xfd0(%rbp) /* gc1 */
	movq $0,-0xfc8(%rbp) /* gc2 */
	movl $0,-0xfc0(%rbp) /* color */
	movq $0,-0xf80(%rbp) /* gc */

	movq -0x1000(%rbp),%rdi /* da */
	movq 80(%rdi),%rdi /* da->window */
	movl $0,%eax
	call gdk_gc_new 
	movq %rax,-0xfd0(%rbp) /* gc1 */

	leaq -0xfc0(%rbp),%rdi /* color */
	movw $30000,0(%rdi) /* color.red */
	movw $0,2(%rdi) /* color.green */
	movw $30000,4(%rdi) /* color.blue */

	leaq -0xfc0(%rbp),%rsi /* color */
	movq -0xfd0(%rbp),%rdi /* gc1 */
	movl $0,%eax
	call gdk_gc_set_rgb_fg_color

	movq -0x1000(%rbp),%rdi /* da */
	movq 80(%rdi),%rdi /* da->window */
	movl $0,%eax
	call gdk_gc_new 
	movq %rax,-0xfc8(%rbp) /* gc2 */

	leaq -0xfc0(%rbp),%rdi /* color */
	movw $65535,0(%rdi) /* color.red */
	movw $65535,2(%rdi) /* color.green */
	movw $65535,4(%rdi) /* color.blue */

	leaq -0xfc0(%rbp),%rsi /* color */
	movq -0xfc8(%rbp),%rdi /* gc2 */
	call gdk_gc_set_rgb_fg_color 

	movl $0,-0xfd8(%rbp) /* xcount */
	movl $2,-0xfe0(%rbp) /* i */

	jmp .Lcheckerboard_expose_400

.Lcheckerboard_expose_500:
	movl $2,-0xfdc(%rbp) /* j */

	movl -0xfd8(%rbp),%eax /* xcount */
	movl $2,%ebx
	xorq %rdx,%rdx
	idivl %ebx
	movl %edx,-0xfd4(%rbp) /* ycount */

	jmp .Lcheckerboard_expose_410

.Lcheckerboard_expose_490:
//	movq $0,-0xf80(%rbp) /* gc */


	movl -0xfd4(%rbp),%eax /* ycount */
	movl $2,%ebx
	xorq %rdx,%rdx
	idivl %ebx
	testl %edx,%edx
	je .Lcheckerboard_expose_485
	movq -0xfd0(%rbp),%rax /* gc1 */
	movq %rax,-0xf80(%rbp) /* gc */

	jmp .Lcheckerboard_expose_480

.Lcheckerboard_expose_485:
	movq -0xfc8(%rbp),%rax /* gc2 */
	movq %rax,-0xf80(%rbp) /* gc */
	
.Lcheckerboard_expose_480:
	pushq $10
	movl $10,%r9d 
	movl -0xfdc(%rbp),%r8d /* j */
	movl -0xfe0(%rbp),%ecx /* i */
	movl $1,%edx 
	movq -0xf80(%rbp),%rsi /* gc */
	movq -0x1000(%rbp),%rdi /* da */
	movq 80(%rdi),%rdi /* da->window */
	movl $0,%eax
	call gdk_draw_rectangle 

	movl -0xfdc(%rbp),%eax /* j */
	addl $10,%eax
	addl $2,%eax
	movl %eax,-0xfdc(%rbp) /* j */

	addl $1,-0xfd4(%rbp) /* ycount */

.Lcheckerboard_expose_410:
	movq -0x1000(%rbp),%rdi /* da */
	leaq 64(%rdi),%rdi /* da->allocation */
	movl 12(%rdi),%eax /*da->allocation.height */
	cmpl -0xfdc(%rbp),%eax /* j */
	jg .Lcheckerboard_expose_490

	addl $12,-0xfe0(%rbp) /* i */
	addl $1,-0xfd8(%rbp) /* xcount */

.Lcheckerboard_expose_400:
	movq -0x1000(%rbp),%rdi /* da */
	leaq 64(%rdi),%rdi  /* da->allocation */
	movl 8(%rdi),%eax  /* da->allocation.width */
	cmpl -0xfe0(%rbp),%eax /* i */
	jg .Lcheckerboard_expose_500

	movl $80,%esi
	movq -0xfd0(%rbp),%rdi  /* gc1 */
	call g_type_check_instance_cast 
	movq %rax,%rdi
	call g_object_unref 

	movl $80,%esi
	movq -0xfc8(%rbp),%rdi  /* gc2 */
	call g_type_check_instance_cast 
	movq %rax,%rdi
	call g_object_unref 

	movl $1,%eax
	leave
	ret

deal_pressed:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

//	call f
	call main3
	
	movl $0,%eax
	leave
	ret

deal_run:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	call f
	
	movl $0,%eax
	leave
	ret


main:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movl %edi,-0x1000(%rbp) /* argc */
	movq %rsi,-0xff8(%rbp) /* argv */


//	call test 

	movq $0,-0xff0(%rbp) /* frame */
	movq $0,-0xfe8(%rbp) /* vbox */
	movq $0,-0xfe0(%rbp) /* da */
	movq $0,-0xfd8(%rbp) /* label */
	movq $0,-0xfd0(%rbp) /* table */
	movq $0,-0xfc8(%rbp) /* but */
	movq $0,-0xfc0(%rbp) /* but1 */

	leaq -0xff8(%rbp),%rsi /* argv */
	leaq -0x1000(%rbp),%rdi /* argc */
	movl $0,%eax
	call gtk_init

//	call main2

//	call f 

	movl $1,%edx 
	movl $2,%esi 
	movl $2,%edi 
	call gtk_table_new 
	movq %rax,-0xfd0(%rbp) /* table */




	movl $0,%edi
	call gtk_window_new
	movq %rax,window(%rip)

	call gtk_window_get_type 
	movq %rax,%rsi
	movq window(%rip),%rdi 
	call g_type_check_instance_cast 
	leaq .LC16(%rip),%rsi
	movq %rax,%rdi
	call gtk_window_set_title

	movl $80,%esi
	movq window(%rip),%rdi
	call g_type_check_instance_cast 
	movl $0,%r9d
	movl $0,%r8d 
	movl $0,%ecx 
	movq gtk_main_quit@GOTPCREL(%rip),%rdx
	leaq .LC3(%rip),%rsi
	movq %rax,%rdi
	call g_signal_connect_data 


	call gtk_container_get_type
	movq %rax,%rsi
	movq window(%rip),%rdi
	call g_type_check_instance_cast 
	movl $10,%esi
	movq %rax,%rdi 
	movl $0,%eax
	call gtk_container_set_border_width 

	movl $8,%esi
	movl $0,%edi 
	call gtk_vbox_new 
	movq %rax,-0xfe8(%rbp) /* vbox */

	leaq .LC17(%rip),%rdi
	call gtk_button_new_with_label
	movq %rax,-0xfc8(%rbp) /* but */

	leaq .LC15(%rip),%rdi
	call gtk_button_new_with_label
	movq %rax,-0xfc0(%rbp) /* but1 */



//	call gtk_box_get_type
//	movq %rax,%rsi
//	movq -0xfe8(%rbp),%rdi /* vbox */
//	call g_type_check_instance_cast 
//	movl $5,%r8d
//	movl $1,%ecx 
//	movl $1,%edx 
//	movq -0xfc8(%rbp),%rsi /* but  */
//	movq %rax,%rdi
//	call gtk_box_pack_start 




	call gtk_container_get_type 
	movq %rax,%rsi
	movq -0xfe8(%rbp),%rdi /* vbox */
	call g_type_check_instance_cast 
	movl $8,%esi
	movq %rax,%rdi 
	call gtk_container_set_border_width

	call gtk_container_get_type 
	movq %rax,%rsi 
	movq window(%rip),%rdi 
	call g_type_check_instance_cast 

	movq -0xfe8(%rbp),%rsi /* vbox */
	movq %rax,%rdi
	call gtk_container_add 

	movl $0,%edi
	call gtk_label_new 
	movq %rax,-0xfd8(%rbp) /* label */

	call gtk_label_get_type
	movq %rax,%rsi 
	movq -0xfd8(%rbp),%rdi 
	call g_type_check_instance_cast 
	leaq .LC4(%rip),%rsi
	movq %rax,%rdi
	call gtk_label_set_markup 



	movl $0,%edi 
	call gtk_frame_new 
	movq %rax,-0xff0(%rbp) /* frame */

	call gtk_frame_get_type
	movq %rax,%rsi 
	movq -0xff0(%rbp),%rdi /* frame */
	call g_type_check_instance_cast 
	movl $1,%esi 
	movq %rax,%rdi 
	call gtk_frame_set_shadow_type 

	call gtk_box_get_type
	movq %rax,%rsi
	movq -0xfe8(%rbp),%rdi /* vbox */
	call g_type_check_instance_cast 	
	movl $0,%r8d
	movl $1,%ecx 
	movl $1,%edx 
	movq -0xff0(%rbp),%rsi /* frame */
	movq %rax,%rdi
	call gtk_box_pack_start 


	call gtk_box_get_type
	movq %rax,%rsi
	movq -0xfe8(%rbp),%rdi /* vbox */
	call g_type_check_instance_cast 
	movl $5,%r8d
	movl $1,%ecx 
	movl $1,%edx 
	movq -0xfd0(%rbp),%rsi /* table  */
	movq %rax,%rdi
	call gtk_box_pack_start 


	movl $0,%r9d
	movl $0,%r8d
	movq $0,%rcx /* entry */
	leaq deal_pressed(%rip),%rdx 
	leaq .LC14(%rip),%rsi
	movq -0xfc0(%rbp),%rdi /* but1 */
	call g_signal_connect_data 

	movl $0,%r9d
	movl $0,%r8d
	movq $0,%rcx /* entry */
	leaq deal_run(%rip),%rdx 
	leaq .LC14(%rip),%rsi
	movq -0xfc8(%rbp),%rdi /* but */
	call g_signal_connect_data 




	call gtk_drawing_area_new 
	movq %rax,-0xfe0(%rbp) /* da */	

	movl $800,%edx
	movl $2000,%esi 
	movq -0xfe0(%rbp),%rdi /* da */
	call gtk_widget_set_size_request

	call gtk_container_get_type 
	movq %rax,%rsi
	movq -0xff0(%rbp),%rdi /* frame */
	call g_type_check_instance_cast 
	movq -0xfe0(%rbp),%rsi /* da */
	movq %rax,%rdi
	call gtk_container_add 
	
	movl $0,%r9d
	movl $0,%r8d 
	movl $0,%ecx 
	leaq scribble_expose_event(%rip),%rdx 
	leaq .LC5(%rip),%rsi
	movq -0xfe0(%rbp),%rdi /* da */
	call g_signal_connect_data 

	movl $0,%r9d
	movl $0,%r8d 
	movl $0,%ecx 
	leaq scribble_configure_event(%rip),%rdx 
	leaq .LC6(%rip),%rsi
	movq -0xfe0(%rbp),%rdi /* da */
	call g_signal_connect_data 

	movl $0,%r9d
	movl $0,%r8d 
	movl $0,%ecx 
	leaq scribble_motion_notify_event(%rip),%rdx 
	leaq .LC7(%rip),%rsi
	movq -0xfe0(%rbp),%rdi /* da */
	call g_signal_connect_data 

	movl $0,%r9d
	movl $0,%r8d 
	movl $0,%ecx 
	leaq scribble_button_press_event(%rip),%rdx 
	leaq .LC8(%rip),%rsi
	movq -0xfe0(%rbp),%rdi /* da */
	call g_signal_connect_data 

	movq -0xfe0(%rbp),%rdi /* da */
	call gtk_widget_get_events 
	orl $8192,%eax /* GDK_LEAVE_NOTIFY_MASK*/
	orl $256,%eax /*GDK_BUTTON_PRESS_MASK */
	orl $4,%eax  /*GDK_POINTER_MOTION_MASK */
	orl $8,%eax /*GDK_POINTER_MOTION_HINT_MASK */
	movl %eax,%esi
	movq -0xfe0(%rbp),%rdi /* da */
	call gtk_widget_set_events 



	call gtk_table_get_type
	movq %rax,%rsi
	movq -0xfd0(%rbp),%rdi /* table */
	call g_type_check_instance_cast 
	movq %rax,%rbx

	movl $1,%r9d 
	movl $0,%r8d 
	movl $1,%ecx
	movl $0,%edx 
	movq -0xfc0(%rbp),%rsi /* but1 */
	movq %rbx,%rdi
	call gtk_table_attach_defaults 


	call gtk_table_get_type
	movq %rax,%rsi
	movq -0xfd0(%rbp),%rdi /* table */
	call g_type_check_instance_cast 
	movq %rax,%rbx

	movl $1,%r9d 
	movl $0,%r8d 
	movl $2,%ecx
	movl $1,%edx 
	movq -0xfc8(%rbp),%rsi /* but1 */
	movq %rbx,%rdi
	call gtk_table_attach_defaults 




//	call gtk_container_get_type 
//	movq %rax,%rsi
//	movq window(%rip),%rdi /* window */
//	call g_type_check_instance_cast 
//	movq -0xfd0(%rbp),%rsi /* table */
//	movq %rax,%rdi
//	call gtk_container_add 



//	movq -0xfe0(%rbp),%rdx /* da */
//	leaq time_handler(%rip),%rsi
//	movl $100,%edi
//	call g_timeout_add 

	movq -0xfe0(%rbp),%rdx /* da */
	leaq test2(%rip),%rsi
	movl $100,%edi
	call g_timeout_add 


//	movq -0xfe0(%rbp),%rdx /* da */
//	leaq th(%rip),%rsi
//	movl $100,%edi
//	call g_timeout_add 



	movq window(%rip),%rdi
	call gtk_widget_show_all 

	call gtk_main

	movl $0,%eax
	leave
	ret
