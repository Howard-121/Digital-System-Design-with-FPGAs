***Tug of War with LFSR***


Instead of competing with humans, 
the goal is to make a robot by LFSR to play with us. 
The 10-bit LFSR generates a 10-bit random number each cycle. 
There is also a comparator holding a certain number, 
which is decided by the inputs (SW[8:0]). If the comparator 
realizes the random number from LFSR is smaller than the number we set, 
it will send a signal to the game, which means the robot presses the button. 
Besides, we have to win the game by winning 7 rounds faster than the opponent. 
The HEX0 and HEX5 will display how many rounds the players have win respectively.



Results:


![Figure 1: Simulation of Cyberwar1](https://github.com/Howard-121/Digital-System-Design-with-FPGAs/blob/master/Tug%20with%20LFSR/Images/cyberwar1.png)
Figure 1: Simulation of Cyberwar1


![Figure 2: Simulation of Cyberwar2](https://github.com/Howard-121/Digital-System-Design-with-FPGAs/blob/master/Tug%20with%20LFSR/Images/cyberwar2.png)
Figure 2: Simulation of Cyberwar2


![Figure 3: Simulation of Cyberwar3](https://github.com/Howard-121/Digital-System-Design-with-FPGAs/blob/master/Tug%20with%20LFSR/Images/cyberwar3.png)
Figure 3: Simulation of Cyberwar3


