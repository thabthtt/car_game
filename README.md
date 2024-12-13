# Project Overview
Authors: Grant Watkins & Troy Thabthimthong

Class: ECE 287 - Digital Systems Design

Project Topic: Continuous Traffic game with increasing difficulty

Description of Project:

The aim of this project is to use the FPGA board to create an ongoing game where the blue block impersonates a car that is avoiding traffic, the red blocks, via VGA. The game is played by pressing the keys to move the blue block either left or right to avoid thered blocks and as time goes on, the speed of the red blocks approaching the player increases, making the game harder as time goes on.

Background Information:

This game is principally the same as Subway Surfers or Temple Run where the user is stationary and the environment is what is moving and approaching the player. We took that aspect of the game and implemented it as a traffic game where the blue block, the car, is avoiding the traffic, red blocks, that is approaching in a random way and could appear in any of the three lanes that are available to the user to move within. As time within the game goes on, the traffic approaches the user at an increasing speed making the user mroe urgent and making the game more difficult and engaging for the user. The user presses two keys to move the car either to the left or the right to avoid the oncoming traffic and the goal of the game is to not collide with any of the oncoming traffic for as long as possible.

# Project Design

cars_gam_vga.v: Sets up the clock and instantiates the backgroud.

car_background.v: Holds all insantiations and basic outline and coloring of the car and the traffic.

my_car_positions.v: Holds Car positions.

traffic_controller.v: Holds the movemnt for the traffic and tells if the lane is visible or not.

traffic_visual.v

lsfr.v: 

collision_detector.v: Decides if the car collides with the traffic.

vga_driver: Sets up h_count and v_count for the traffic part of the game

# Gameplay

# To play the game

1. Make sure all switches arre in the off position before you start.

2. Flip SW9 into the on position then use KEY[1] and KEY[0] to move left and right.

3. Use KEY[1] and KEY[0] and avoid traffic for as long as possible.

4. Once the game ends, flip SW9 back into the off position to turn off the game or press KEY[3] to reset the game.

# Citations

Formatting for our `README.md` is sampled from https://github.com/liamogw/guitar-hero.git

Code for the traffic and  

# Conclusions
