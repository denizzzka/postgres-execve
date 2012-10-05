postgres-execve
===============

PostgreSQL execve() function on plpythonu

It can be used for calling external programs from the server side code.
It is fairly safe if you carefully checking rights to call of this function and arguments.
The best scenario is to create functions with hardcoded arguments which calls this function.
