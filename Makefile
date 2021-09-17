main: a.o inc.o draw0.o arrow.o  test.o test2.o  thread1.o thread2.o newwindow.o map.o 
	./a.sh

a.o:  
	as -o a.o -L  -g   main.s

inc.o:
	as -o inc.o -L -g inc.s

draw0.o:
	as -o draw0.o -L -g draw0.s

test.o:
	as -o test.o -L -g test.s

test2.o:
	as -o test2.o -L -g test2.s

thread1.o:
	as -o thread1.o -L -g thread1.s 

thread2.o:
	as -o thread2.o -L -g thread2.s 


newwindow.o:
	as -o newwindow.o -L -g newwindow.s 

map.o:
	as -o map.o -L -g map.s

arrow.o:
	as -o arrow.o -L -g arrow.s

clean: 
	rm inc.o arrow.o newwindow.o test.o map.o draw0.o test2.o  thread1.o thread2.o a.o a.out
