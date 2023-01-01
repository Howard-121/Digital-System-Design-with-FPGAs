***Tug of War***


Tug of War is a game to compete which player can press the 
button faster. There are two input buttons, KEY0 and KEY3, 
for players to press. The whole play field is shown by 
LEDR[9:1]. As the game is reset, only the center LED 
(LEDR[5]) is on. If the KEY0 is press once, the light will move 
to the right by one LED light. If the KEY3 is press once, the 
light will move to the left by one LED light as well. So the LED 
light will go back and forth during the game until the light 
touches the end of either side (LEDR[0] or LEDR[9]). Once the 
game is over, the winner's number (1 or 2) will be displayed on 
the HEX0.



![Figure 1: Block Diagram of the Entire System](https://github.com/Howard-121/Digital-System-Design-with-FPGAs/blob/master/Tug%20of%20War/Images/tug%20of%20war%20block%20diagram.jpg)
Figure 1: Block Diagram of the Entire System


![Figure 2: Block Diagram of Playfield](https://github.com/Howard-121/Digital-System-Design-with-FPGAs/blob/master/Tug%20of%20War/Images/playfield%20block%20diagram.jpg)
Figure 2: Block Diagram of Playfield



Results:


![Figure 3: Simulation of Tug of War](https://github.com/Howard-121/Digital-System-Design-with-FPGAs/blob/master/Tug%20of%20War/Images/tug%20of%20war.png)
Figure 3: Simulation of Tug of War
