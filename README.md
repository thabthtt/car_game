# Project Overview
Authors: Grant Watkins & Troy Thabthimthong

Class: ECE 287 - Digital Systems Design

Project Topic: Continuous Traffic game with increasing difficulty

Description of Project:

The aim of this project is to use the FPGA board to create an ongoing game where the blue block represents a car that is avoiding traffic, the red blocks, via VGA. The game is played by pressing the keys to move the blue block either left or right to avoid the red blocks and as time goes on, the speed at which the red blocks approach the player increases, making the game harder over time.

Background Information:

This game is principally the same as Subway Surfers or Temple Run where the user is stationary and the environment is what is moving and approaching the player. We took that aspect of the game and implemented it as a traffic game where the blue block, the car, is avoiding the traffic, red blocks, that is approaching in a random way and could appear in any of the three lanes that are available to the user to move within. As time within the game goes on, the traffic approaches the user at an increasing speed making the user more urgent and making the game more difficult and engaging for the user. The user presses two keys to move the car left or right to avoid the oncoming traffic and the goal of the game is to not collide with any of the oncoming traffic for as long as possible.

# Project Design

cars_gam_vga.v: This module sets up the clock and instantiates the background.

car_background.v: This module holds all instantiations and basic outline and coloring of the car and the traffic.

my_car_positions.v: This module holds the car positions depending on what input is pressed and and tells the car_background module which lane the car should be drawn in. The car's movement is designed so that if the car is in the left (or right) lane, it must travel through the middle lane to reach the opposite lane.

traffic_controller.v: This module controls the movement of the traffic and determines whether a lane is visible.

traffic_visual.v: This module checks if the traffic is in that lane, if it is, then the traffic block is colored red. 

lsfr.v: This module randomly generates a number based on a seed that is implemented. This code is used to generate the traffic blocks. 

collision_detector.v: This module detects if the car collides with the traffic.

vga_driver: This module implements a VGA driver for a 640x480 resolution. It generates horizontal and vertical sync signals (hsync and vsync) based on the timing parameters, while also keeping track of the current pixel (h_count) and line (v_count) positions.

# Gameplay

# To play the game

1. Make sure all switches are in the off position before you start.

2. Flip SW[9] into the on position then use KEY[1] and KEY[0] to move left and right.

3. Use KEY[1] and KEY[0] and avoid traffic for as long as possible.

4. Once the game ends, flip SW[9] to the off position to turn off the game, or press KEY[3] to reset the game.
   
# Citations

The formatting of our README.md file is based on the template from https://github.com/liamogw/guitar-hero.git

We received the vga_driver, lsfr, traffic_controller, and traffic_visual modules from Liam O'Grady-Walsh and Michael Skidmore, as referenced in the project link above.

# Conclusions
Unfortunately, we were unable to complete our game because we couldn't figure out how to implement the collision module while the lsfr module worked, and vice versa. 
 
Lsfr module working: https://youtube.com/shorts/lO6nqEbiQUU?si=D2uqKx0go5QUwBBA

Collision module working(car movement shown here): https://youtube.com/shorts/KkzICEbJ2gI?si=4Y-N4ZVZLFoBy9Uw

