=begin
Five-guess algorithm[edit]
In 1977, Donald Knuth demonstrated that the codebreaker can solve the pattern in five moves or fewer, using an algorithm that progressively reduced the number of possible patterns.[9] The algorithm works as follows:

Create the set S of 1296 possible codes, 1111,1112,.., 6666.
Start with initial guess 1122 (Knuth gives examples showing that some other first guesses such as 1123, 1234 do not win in five tries on every code).
Play the guess to get a response of colored and white pegs.
If the response is four colored pegs, the game is won, the algorithm terminates.
Otherwise, remove from S any code that would not give the same response if it (the guess) were the code.
Apply minimax technique to find a next guess as follows: For each possible guess, that is, any unused code of the 1296 not just those in S, calculate how many possibilities in S would be eliminated for each possible colored/white peg score. The score of a guess is the minimum number of possibilities it might eliminate from S. From the set of guesses with the maximum score, select one as the next guess, choosing a member of S whenever possible. (Knuth follows the convention of choosing the guess with the least numeric value e.g. 2345 is lower than 3456. Knuth also gives an example showing that in some cases no member of S will be among the highest scoring guesses and thus the guess cannot win on the next turn, yet will be necessary to assure a win in five.)
Repeat from step 3.
=end

# Create the set of all possible codes.

# Send guess of "AABB"