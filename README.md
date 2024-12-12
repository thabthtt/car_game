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

traffic.v: Holds the movemnt for the traffic and tells if the lane is visible or not.

lsfr.v: 

collision_detector.v: Decides if the car collides with the traffic.

vga_driver: 

# Gameplay

# To play the game

1. jkdfjs

2. fdsa

3. fdsa

# Citations

Formatting for our `README.md` is sampled from https://github.com/liamogw/guitar-hero.git

# Conclusions
