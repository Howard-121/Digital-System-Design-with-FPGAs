***UPC Code Check***


When people like to return their item, we want to make sure whether the item was dicounted then, so we won't over-refund customers. 
We also want to make sure someone didn’t steal the item, then return the stolen item for cash.

A special method is applied to find shoplifters. Whenever an expensive item is sold, a secret mark is put onto the item. 
With the UPC code and the secret Mark, the system should be able to tell whether the item is discounted and whether the item is stolen. 
The inputs, SW9, SW8, SW7, and SW0 represent signal U, P, C, and Mark respectively, LEDR0 shows discount, and LEDR1 shows the item is stolen.
Moreover, the names of the six items that I made will also be shown on the Hex display.



<p align = "center">
<img src="https://github.com/Howard-121/Digital-System-Design-with-FPGAs/blob/master/UPC%20Check/Images/new%20items.png" width="300" height="150" />
Table 1: Six Items



Results:

![Figure 1: The waveform of UPC code to display](https://github.com/Howard-121/Digital-System-Design-with-FPGAs/blob/master/UPC%20Check/Images/display.png)
Figure 1: The waveform of UPC code to display

