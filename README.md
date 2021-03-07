# Lab 2 CIU - Planetary system

This lab consists in the implementation of a planetary system of revolution using Processing.

Author - Pablo Ortigosa


## Implementation

This assigment was very straight forward the main problem was to create the class that represents the planets, satellites and stars, I decided to call this class AstronomicalObject, it keeps track of:
* Its radius.
* The point or object its orbitating (its parent).
* Its relative position in the orbit.
* Its rotation speed.
* Its translation speed.
* Its name.

Then each object calculates its rotation and translation with the methods rotate() and orbitate(). Finally these objects are showed with the display() method.
The main class just iterates the list of AstronomicalObjects and calls these methods.

## Choices

When the planets orbitate they do not rotate because of this translation, they rotate only because of the rotation speed they have, so if a planet has (0,0,0) rotation speed there would be a part of the planet the viewer would never see. After looking at the planets for some time it didn't feel weird, but now while making this readme I have notice that I was mistaken, however it should be an easy fix, instead of rotating the center of the planets I should push a matrix, translate the system to (0,0,0), then rotate it and finally pop the matrix. Because the next assigment is to improve this one I am going to not change it and do it in the next lab.

## References

https://www.solarsystemscope.com/textures/ used to get the textures

The class material made by the teachers - @otsedom and Daniel.

Processing API.

Java API.

## Final look

![Application](https://github.com/PabloOQ/pr3-CIU/blob/main/gif.gif)
