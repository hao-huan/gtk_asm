.text

.data
.comm window,8,32
.comm buff,50,32
.comm buff1,50,32

.section .rodata

.LC0:
	.string "Sans"

.LC1:
	.string "123456"

.LC2:
	.string "TRUE"

.LC3:
	.string ""

.LC4:
	.string "%s"

.LC5:
	.string "sure"

.LC6:
	.string "<-"

.LC7:
	.string "%s\n"

.LC8:
	.string "输入数字"

.LC9:
	.string "destroy"

.LC10:
	.string "数字"

.LC11:
	.string "<-"

.LC12:
	.string "clicked"

.LC13:
	.string "X"

.LC14:
	.string "%d"

.LC15:
	.string "pressed"

.LC16:
	.string "activate"

.LC17:
	.string "提交"

.globl main3


.text 
set_widget_font_size:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */
	movl %esi,-0xff8(%rbp) /* size */
	movl %edx,-0xff4(%rbp) /* is_button */

	movq $0,-0xff0(%rbp) /* labelChild */
	movq $0,-0xfe8(%rbp) /* font */
	movl $0,-0xfe0(%rbp) /* fontSize */

	movl -0xff8(%rbp),%eax /* size */
	movl %eax,-0xfe0(%rbp) /* fontSize */

	leaq .LC0(%rip),%rdi
	call pango_font_description_from_string
	movq %rax,-0xfe8(%rbp) /* font */


	movl -0xfe0(%rbp),%eax /* fontSize */
	sall $10,%eax /* fontSize * PANGO_SCALE */
	movl %eax,%esi 
	movq -0xfe8(%rbp),%rdi /* font */
	call pango_font_description_set_size 

	movl -0xff4(%rbp),%eax /* is_button */
	testl %eax,%eax
	je .Lset_widget_font_size_400

	call gtk_bin_get_type
	movq %rax,%rsi 
	movq -0x1000(%rbp),%rdi /* widget */
	call g_type_check_instance_cast 
	movq %rax,%rdi
	call gtk_bin_get_child 
	movq %rax,-0xff0(%rbp) /* labelChild */
	
	jmp .Lset_widget_font_size_390

.Lset_widget_font_size_400:
	movq -0x1000(%rbp),%rax /* widget */
	movq %rax,-0xff0(%rbp) /* labelChild  */

.Lset_widget_font_size_390:
	call gtk_widget_get_type 
	movq %rax,%rsi 
	movq -0xff0(%rbp),%rdi /* labelChild */
	call g_type_check_instance_cast 
	movq -0xfe8(%rbp),%rsi /* font */
	movq %rax,%rdi
	call gtk_widget_modify_font 

	movq -0xfe8(%rbp),%rdi /* font */
	call pango_font_description_free 

	movl $0,%eax
	leave
	ret

chang_background:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* widget */
	movl %esi,-0xff8(%rbp) /* w */
	movl %edx,-0xff4(%rbp) /* h */
	movq %rcx,-0xff0(%rbp) /* path */

	movq $0,-0xfe8(%rbp) /* src_pixbuf */
	movq $0,-0xfe0(%rbp) /* dst_pixbuf */
	movq $0,-0xfd8(%rbp) /* pixmap */

	movl $1,%esi
	movq -0x1000(%rbp),%rdi  /* widget */
	call gtk_widget_set_app_paintable 

	movq -0x1000(%rbp),%rdi  /* widget */
	call gtk_widget_realize 

	movq -0x1000(%rbp),%rdi  /* widget */
	call gtk_widget_queue_draw 

	movl $0,%esi
	movq -0xff0(%rbp),%rdi /* path */
	call gdk_pixbuf_new_from_file 
	movq %rax,-0xfe8(%rbp) /* src_pixbuf */

	movl $2,%ecx /* GDK_INTERP_BILINEAR */
	movl -0xff4(%rbp),%edx /* h */
	movl -0xff8(%rbp),%esi /* w */
	movq -0xfe8(%rbp),%rdi /* src_pixbuf */
	call gdk_pixbuf_scale_simple 
	movq %rax,-0xfe0(%rbp) /* dst_pixbuf */

	movl $128,%ecx
	movl $0,%edx 
	leaq -0xfd8(%rbp),%rsi /* pixmap */
	movq -0xfe0(%rbp),%rdi /* dst_pixbuf */
	call gdk_pixbuf_render_pixmap_and_mask

	movl $0,%edx
	movq  -0xfd8(%rbp),%rsi /* pixmap */

	movq -0x1000(%rbp),%rdi  /* widget */
	movq 80(%rdi),%rdi /* widget->window */
	call gdk_window_set_back_pixmap 

	movq -0xfe8(%rbp),%rdi /* src_pixbuf */
	call g_object_unref
	movq -0xfe0(%rbp),%rdi /* dst_pixbuf */
	call g_object_unref
	movq -0xfd8(%rbp),%rdi /* pixmap */
	call g_object_unref
	
	movl $0,%eax
	leave
	ret

enter_callback:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp
	
	movq %rdi,-0x1000(%rbp) /* widget */
	movq %rsi,-0xff8(%rbp) /* entry */

	movq $0,-0xff0(%rbp) /* entry_text */

	call gtk_entry_get_type 
	movq %rax,%rsi
	movq -0xff8(%rbp),%rdi /* entry */
	call g_type_check_instance_cast 
	movq %rax,%rdi
	call gtk_entry_get_text 
	movq %rax,-0xff0(%rbp) /* entry_text */

	leaq .LC1(%rip),%rsi /* */
	movq -0xff0(%rbp),%rdi /* entry_text */
	call strcmp 
	cmpl $0,%eax
	jne .Lenter_callback_400

	call gtk_entry_get_type
	movq %rax,%rsi 
	movq -0xff8(%rbp),%rdi /* entry */
	call g_type_check_instance_cast 
	movl $1,%esi
	movq %rax,%rdi
	call gtk_entry_set_visibility 

	leaq .LC2(%rip),%rdi
	call g_print 

	jmp .Lenter_callback_0

.Lenter_callback_400:
	call gtk_entry_get_type 
	movq %rax,%rsi
	movq -0xff8(%rbp),%rdi /* entry */
	call g_type_check_instance_cast 
	leaq .LC3(%rip),%rsi
	movq %rax,%rdi 
	call gtk_entry_set_text 

.Lenter_callback_0:
	movl $0,%eax
	leave
	ret

deal_pressed:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp

	movq %rdi,-0x1000(%rbp) /* button */
	movq %rsi,-0xff8(%rbp) /* entry */

	movl $0,-0xff0(%rbp) /* buf */
	movl $0,-0xfe0(%rbp) /* buf1 */
	movl $0,-0xfd0(%rbp) /* num */
	movq $0,-0xfc8(%rbp) /* text */
	movq $0,-0xfc0(%rbp) /* but */

	call gtk_entry_get_type 
	movq %rax,%rsi
	movq -0xff8(%rbp),%rdi /* entry */
	call g_type_check_instance_cast
	movl $0,%esi
	movq %rax,%rdi
	call gtk_entry_set_visibility 

	call gtk_entry_get_type 
	movq %rax,%rsi
	movq -0xff8(%rbp),%rdi /* entry */
	call g_type_check_instance_cast 
	movq %rax,%rdi
	call gtk_entry_get_text 
	movq %rax,-0xfc8(%rbp) /* text */

	movq -0x1000(%rbp),%rdi /* button */
	call gtk_button_get_label 
	movq %rax,-0xfc0(%rbp) /* but */

	movq -0xfc8(%rbp),%rdx /* text */
	leaq .LC4(%rip),%rsi
	leaq -0xff0(%rbp),%rdi /* buf */
	call sprintf 

	leaq .LC5(%rip),%rsi
	movq -0xfc0(%rbp),%rdi /* but */
	call strcmp 

	cmpl $0,%eax
	jne .Ldeal_pressed_400


	leaq .LC1(%rip),%rsi
	leaq -0xff0(%rbp),%rdi /* buf */
	call strcmp 
	cmpl $0,%eax
	jne .Ldeal_pressed_450

	call gtk_entry_get_type
	movq %rax,%rsi 
	movq -0xff8(%rbp),%rdi /* entry */
	call g_type_check_instance_cast
	movl $1,%esi
	movq %rax,%rdi 
	call gtk_entry_set_visibility

	leaq .LC2(%rip),%rdi
	call g_print 

	jmp .Ldeal_pressed_401

.Ldeal_pressed_450:
	movl $0,%eax
	movslq %eax,%rax 
	leaq -0xff0(%rbp),%rdi /* buf */
	movb $0,0(%rdi,%rax,1) /* buf[0] */

.Ldeal_pressed_401:
	jmp .Ldeal_pressed_380
.Ldeal_pressed_400:
	leaq .LC6(%rip),%rsi 
	movq -0xfc0(%rbp),%rdi /* but */
	call strcmp 
	cmpl $0,%eax
	jne .Ldeal_pressed_390
	leaq -0xff0(%rbp),%rdi /* buf */
	call strlen 
	movl %eax,-0xfd0(%rbp) /* num */

	movl -0xfd0(%rbp),%eax /* num */
	subl $1,%eax
	movslq %eax,%rax 
	leaq -0xff0(%rbp),%rdi /* buf */
	movb $0,0(%rdi,%rax,1) /* buf[num-1] */

	jmp .Ldeal_pressed_380

.Ldeal_pressed_390:
	movq -0xfc0(%rbp),%rdx /* but */
	leaq .LC4(%rip),%rsi
	leaq -0xfe0(%rbp),%rdi /* buf1 */
	call sprintf

.Ldeal_pressed_380:

	leaq -0xfe0(%rbp),%rsi /* buf1 */
	leaq -0xff0(%rbp),%rdi /* buf */
	call strcat 
	movq %rax,%rbx

	call gtk_entry_get_type 
	movq %rax,%rsi
	movq -0xff8(%rbp),%rdi /* entry */
	call g_type_check_instance_cast 
	movq %rbx,%rsi
	movq %rax,%rdi 
	call gtk_entry_set_text 

	leaq -0xff0(%rbp),%rsi /* buf */
	leaq .LC7(%rip),%rdi
	call g_print 

	movl $0,%eax
	leave
	ret


deal_submit:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp
	movq %rdi,-0x1000(%rbp) /* button */
	movq %rsi,-0xff8(%rbp)  /* entry */
	movq $0,-0xff0(%rbp) /* text */
	movl $0,-0xfe8(%rbp) /* i */
	movq $0,-0xfe0(%rbp) /* node */


	movl $120,%edx 
	movl $0,%esi 
	leaq p_arr(%rip),%rdi 
	call memset 

	movl $0,-0xfe8(%rbp) /* i */
	jmp .Ldeal_submit_400

.Ldeal_submit_500:
	call gtk_entry_get_type 
	movq %rax,%rsi

	movl -0xfe8(%rbp),%eax /* i */
	sall $3,%eax
	movslq %eax,%rax
	movq -0xff8(%rbp),%rdi /* entry */
	movq 0(%rdi,%rax,1),%rdi /* entry[i] */
	call g_type_check_instance_cast 
	movq %rax,%rdi
	call gtk_entry_get_text 
	movq %rax,-0xff0(%rbp) /* text */

	movq -0xff0(%rbp),%rdi /* text */
	call atoi 
	movl %eax,%ebx

        movl -0xfe8(%rbp),%eax /* i */
	sall $2,%eax 
	movslq %eax,%rax
	leaq arr(%rip),%rdi
	movl %ebx,0(%rdi,%rax,1) /* arr[i]  */



//	movl $20,%edi
//	call malloc 
//	movq %rax,-0xfe0(%rbp) /* node */
//
//	movq -0xfe0(%rbp),%rdi /* node */
//	movl -0xfe8(%rbp),%eax /* i */
//	imull $120,%eax
//	movl %eax,0(%rdi) /* rect.x */
//
//	movl $20,4(%rdi) /* rect.y */
//	movl $100,8(%rdi) /* rect.width */
//	movl $100,12(%rdi) /* rect.height */
//	movl %ebx,16(%rdi) /* node->data */
//
//	movq -0xfe0(%rbp),%rcx /* node */
//
//	movl -0xfe8(%rbp),%eax /* i */
//	sall $3,%eax 
//	movslq %eax,%rax
//	leaq p_arr(%rip),%rdi
//	movq %rcx,0(%rdi,%rax,1) /* p_arr[i]  */


	addl $1,-0xfe8(%rbp) /* i */
.Ldeal_submit_400:
	cmpl $10,-0xfe8(%rbp) /* i */
	jl .Ldeal_submit_500


//	movl $16,%edi 
//	call malloc 
//	movq %rax,-0xff0(%rbp) /* rect */
//
//	movq -0xff0(%rbp),%rdi /* rect */
//	movl $0,0(%rdi) /* rect.x */
//	movl $137,4(%rdi) /* rect.y */
//	movl $1180,8(%rdi) /* rect.width */
//	movl $30,12(%rdi) /* rect.height */
//
//	leaq p_arr1(%rip),%rdi
//	movq -0xff0(%rbp),%rax /* rect */
//	movq %rax,0(%rdi) /* p_arr[1]  */ 
//
//
//	movl $16,%edi 
//	call malloc 
//	movq %rax,-0xff0(%rbp) /* rect */
//
//	movq -0xff0(%rbp),%rdi /* rect */
//	movl $10,0(%rdi) /* rect.x */
//	movl $137,4(%rdi) /* rect.y */
//	movl $30,8(%rdi) /* rect.width */
//	movl $30,12(%rdi) /* rect.height */
//
//	leaq p_arr2(%rip),%rdi
//	movq -0xff0(%rbp),%rax /* rect */
//	movq %rax,0(%rdi) /* p_arr2  */ 




	movl $0,%eax
	leave
	ret

main3:
	pushq %rbp
	movq %rsp,%rbp
	subq $0x1000,%rsp
	
	movl %edi,-0x1000(%rbp) /* argc */
	movq %rsi,-0xff8(%rbp) /* argv */
	movl $0,-0xff0(%rbp) /* i */
	movl $0,-0xfe0(%rbp) /* buf */
	movq $0,-0xfd0(%rbp) /* button */
	movq $0,-0xfc8(%rbp) /* window */
	movq $0,-0xfc0(%rbp) /* table */
	movq $0,-0xfb8(%rbp) /* pass[i] */
	movq $0,-0xfb0(%rbp) /* entry[i] */
	movq $0,-0xfa8(%rbp) /* button1 */
	movq $0,-0xfa0(%rbp) /* button2 */
	movq $0,-0xf98(%rbp) /* but2 */

	movq $0,-0xf88(%rbp) /* pass1 */
	movq $0,-0xf80(%rbp) /* pass2 */
	movq $0,-0xf78(%rbp) /* pass3 */
	movq $0,-0xf70(%rbp) /* pass4 */
	movq $0,-0xf68(%rbp) /* pass5 */
	movq $0,-0xf60(%rbp) /* pass6 */
	movq $0,-0xf58(%rbp) /* pass7 */
	movq $0,-0xf50(%rbp) /* pass8 */
	movq $0,-0xf48(%rbp) /* pass9 */
	movq $0,-0xf40(%rbp) /* pass10  */

	movq $0,-0xf38(%rbp) /* entry1 */
	movq $0,-0xf30(%rbp) /* entry2 */
	movq $0,-0xf28(%rbp) /* entry3 */
	movq $0,-0xf20(%rbp) /* entry4 */
	movq $0,-0xf18(%rbp) /* entry5 */
	movq $0,-0xf10(%rbp) /* entry6 */
	movq $0,-0xf08(%rbp) /* entry7 */
	movq $0,-0xf00(%rbp) /* entry8 */
	movq $0,-0xef8(%rbp) /* entry9 */
	movq $0,-0xef0(%rbp) /* entry10 */
	

	leaq -0xff8(%rbp),%rsi /* argv */
	leaq -0x1000(%rbp),%rdi /* argc */
	call gtk_init 

	movl $0,%edi
	call gtk_window_new 
	movq %rax,-0xfc8(%rbp) /* window */

	call gtk_window_get_type
	movq %rax,%rsi
	movq -0xfc8(%rbp),%rdi /* window */
	call g_type_check_instance_cast 
	leaq .LC8(%rip),%rsi
	movq %rax,%rdi
	call gtk_window_set_title 

	movl $0,%r9d
	movl $0,%r8d
	movl $0,%ecx
	movq gtk_main_quit@GOTPCREL(%rip),%rdx 
	leaq .LC9(%rip),%rsi 
	movq -0xfc8(%rbp),%rdi /* window */
	call g_signal_connect_data 

	movl $480,%edx
	movl $800,%esi 
	movq -0xfc8(%rbp),%rdi /* window */
	call gtk_widget_set_size_request 

	call gtk_window_get_type
	movq %rax,%rsi
	movq -0xfc8(%rbp),%rdi /* window */
	call g_type_check_instance_cast 
	movl $0,%esi
	movq %rax,%rdi
	call gtk_window_set_resizable

	leaq .LC17(%rip),%rdi /* buf */
	call gtk_button_new_with_label
	movq %rax,-0xfd0(%rbp) /* button */

	call gtk_window_get_type 
	movq %rax,%rsi
	movq -0xfc8(%rbp),%rdi /* window */
	call g_type_check_instance_cast 
	movl $1,%esi
	movq %rax,%rdi
	call gtk_window_set_position

	movl $1,%edx 
	movl $7,%esi 
	movl $12,%edi 
	call gtk_table_new 
	movq %rax,-0xfc0(%rbp) /* table */

	call gtk_table_get_type 
	movq %rax,%rsi 
	movq -0xfc0(%rbp),%rdi /* table */
	call g_type_check_instance_cast 
	movq %rax,%rdi  

	movl -0xff0(%rbp),%eax /* i */
	movl %eax,%r8d
	movl %eax,%r9d 
	addl $6,%r9d 
	addl $4,%r8d 
	movl $6,%ecx 
	movl $4,%edx 
	movq -0xfd0(%rbp),%rsi /* button */
	call gtk_table_attach_defaults 

	movl $0,%r9d
	movl $0,%r8d
	leaq -0xf38(%rbp),%rcx /* entry */
	leaq deal_submit(%rip),%rdx 
	leaq .LC15(%rip),%rsi
	movq -0xfd0(%rbp),%rdi /* button */
	call g_signal_connect_data 

	movl $0,-0xff0(%rbp) /* i */
	jmp .Lmain3_400

.Lmain3_500:
	movl $50,%edx
	movl $0,%esi 
	leaq buff(%rip),%rdi 
	call memset 

	movl $50,%edx
	movl $0,%esi 
	leaq buff1(%rip),%rdi 
	call memset 

	leaq .LC10(%rip),%rsi 
	leaq buff(%rip),%rdi 
	call strcat 
	
	movl -0xff0(%rbp),%edx /* i */
	leaq .LC14(%rip),%rsi 
	leaq buff1(%rip),%rdi /* buf */
	call sprintf 

	leaq buff1(%rip),%rsi
	leaq buff(%rip),%rdi 
	call strcat 

	movq %rax,%rdi
	call gtk_label_new 
	movq %rax,%rbx 

	movl -0xff0(%rbp),%eax /* i */
	sall $3,%eax
	movslq %eax,%rax 
	leaq -0xf88(%rbp),%rdi /* text */
	movq %rbx,0(%rdi,%rax,1) /* text[i] */
	movq 0(%rdi,%rax,1),%rax /* text[i] */
	movq %rax,-0xfb8(%rbp)  /* text[i] */

	movl $0,%edx
	movl $30,%esi
	movq -0xfb8(%rbp),%rdi /* text[i]  */
	call set_widget_font_size 

	call gtk_entry_new 
	movq %rax,%rbx

	movl -0xff0(%rbp),%eax /* i */
	sall $3,%eax
	movslq %eax,%rax 
	leaq -0xf38(%rbp),%rdi /* entry */
	movq %rbx, 0(%rdi,%rax,1) /* entry[i] */
	movq 0(%rdi,%rax,1),%rax /* entry[i] */
	movq %rax,-0xfb0(%rbp) /* entry[i] */

	movl $0,%edx
	movl $20,%esi
	movq -0xfb0(%rbp),%rdi /* entry[i] */
	call set_widget_font_size 

	call gtk_entry_get_type
	movq %rax,%rsi
	movq -0xfb0(%rbp),%rdi /* entry[i] */
	call g_type_check_instance_cast 
	movl $6,%esi
	movq %rax,%rdi
	call gtk_entry_set_max_length
	
	call gtk_table_get_type 
	movq %rax,%rsi 
	movq -0xfc0(%rbp),%rdi /* table */
	call g_type_check_instance_cast 
	movq %rax,%rdi  

	movl -0xff0(%rbp),%eax /* i */
	movl %eax,%r8d
	movl %eax,%r9d 
	addl $1,%r9d 
	addl $0,%r8d 
	movl $2,%ecx 
	movl $0,%edx 
	movq -0xfb8(%rbp),%rsi /* text[i] */
	call gtk_table_attach_defaults 

	call gtk_table_get_type 
	movq %rax,%rsi 
	movq -0xfc0(%rbp),%rdi /* table */
	call g_type_check_instance_cast 
	movq %rax,%rdi
	movl -0xff0(%rbp),%eax /* i */
	movl %eax,%r8d
	movl %eax,%r9d 
	addl $1,%r9d 
	addl $0,%r8d 
	movl $3,%ecx 
	movl $2,%edx 
	movq -0xfb0(%rbp),%rsi /* entry[i] */
	call gtk_table_attach_defaults 

	call gtk_entry_get_type 
	movq %rax,%rsi
	movq -0xfb0(%rbp),%rdi /* entry[i] */
	call g_type_check_instance_cast 
	movl $1,%esi
	movq %rax,%rdi
	call gtk_entry_set_visibility 


	addl $1,-0xff0(%rbp) /* i */

.Lmain3_400:
	cmpl $10,-0xff0(%rbp) /* i */
	jl .Lmain3_500

	movl $0,%r9d
	movl $0,%r8d
	movq -0xfb0(%rbp),%rcx /* entry */
	leaq enter_callback(%rip),%rdx 
	leaq .LC16(%rip),%rsi 
	movq -0xfb0(%rbp),%rdi /* entry */
	call g_signal_connect_data 

	call gtk_container_get_type 
	movq %rax,%rsi
	movq -0xfc8(%rbp),%rdi /* window */
	call g_type_check_instance_cast 
	movq -0xfc0(%rbp),%rsi /* table */
	movq %rax,%rdi
	call gtk_container_add 

	movq -0xfc8(%rbp),%rdi /* window */
	call gtk_widget_show_all 

	call gtk_main

	movl $0,%eax
	leave
	ret
