#Game Class
#Play method that runs everything
#Turn method that handles turns

#Board Class
#Board will be an array of arrays
# => Last array in board is the MasterCode
#Set line method
#Check/compare with MasterCode
#Inserts key pegs
#Render

#Player Class
#Asks for line
#Validate the line

#Include CodeBreakerModule
#Generate guess

#Include CodeMakerModule
#Generate Code

#Human < Player

#Computer < Player

#Peg
#Color

#CodePeg < Peg
#Check: Is this a valid color?

#KeyPeg < Peg
#Check: Is this a valid color?


* Game Class
** Initialize
*** Instantiate Players
*** Instantiate Board
*** Instantiate Pegs

* Board Class
** Initialize

* Player
** Initialize
*** Instantiate Pegs
** Method to create pegs

* CodeMaker
** Initialize
*** Instantiate MasterCode