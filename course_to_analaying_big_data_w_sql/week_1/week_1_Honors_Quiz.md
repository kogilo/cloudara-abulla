Week 1 Honors Quiz
LATEST SUBMISSION GRADE
100%

1.Question 1
Which of the following will correctly start Beeline on the VM? Check all that apply.


beeline -connect hive2 -n training -p training


beeline -u hive2 -n training -p training


beeline -u jdbc:hive2://localhost:10000 -n training -p training

Correct
Correct. This specifies the URL for connecting to the Hive server, and includes the optional credentials (username and password).


beeline -connect hive2


beeline -connect jdbc:hive2://localhost:10000


beeline -u hive2


beeline -connect jdbc:hive2://localhost:10000 -n training -p training


beeline -u jdbc:hive2://localhost:10000

Correct
Correct. This specifies the URL for connecting to the Hive server.

1 / 1 point

2.Question 2
Which pair of statements allow you to start and quit Impala Shell?


impala-shell -u jdbc:hive2://localhost:10000 and quit;


impala shell -u jdbc:hive2://localhost:10000 and !quit


impala shell and quit;


impala-shell -u jdbc:hive2://localhost:10000 and !quit


impala shell -u jdbc:hive2://localhost:10000 and quit;


impala shell and !quit


impala-shell and quit;


impala-shell and !quit

Correct
Correct. Impala Shell is started by the hyphenated impala-shell with no need to specify a connector, and exited using a quit command with a semicolon.
