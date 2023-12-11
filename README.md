Assignment 2 AI using prolog

The project used several fluents that represent our problems initial state and these fluents are:
food(Food): Represents the amount of available food.
materials(Materials): Represents the amount of available materials.
energy(Energy): Represents the amount of available energy.
build1(F, M, E): Represents the amount of food, material, and energy build 1 needs
build2(F, M, E): Represents the amount of food, material, and energy build 2 needs
It also used multiple predicates which are:
helper(s0, Food, Materials, Energy, 0, 0). (base case)
helper(S, Food, Materials, Energy, B1, B2).
ids(S,L).
goal(S).
The goal of our search problem is to find a way to complete both builds 1 and 2 once each. What the prolog code does is it first calls the predicate goal(S), where S is our state that we want to reach, which will then call ids(S,0) zero being depth of zero.
The predicate ids(S,L) is defined to perform iterative deepening search by repeatedly calling the helper predicate with increasing depth limits until a solution is found or the depth limit is exceeded. The depth limit is incremented in each iteration.
There are two definitions for the helper predicate. The first one is the base case that sets the food, materials, and energy to their value. And sets B1 and B2 to 0 indicating they have not been done yet. B1 and B2 are values to keep track of whether or not the builds have been performed or not. The recursive case of helper, it first decomposes the state S into a result and the previous state, It then recursively calls helper on the previous state and obtains the updated values for FoodBase, MaterialsBase, EnergyBase, Build1NewState, and Build2NewState. If the result is b1, it will check if there are enough of our resources to perform the build and then update the resource quantities and set the values of B1 to 1 indicating it has been performed, and B2 remains the same as it was. The same thing is done for the result b2. If the result is request food or material or energy the requested resource value is incremented and the rest of the values remain the same.
The successor state axioms are implemented in the helper predicate. The axioms define how the state changes after each action. A summary of the points:
Build 1 (Result = b1):
If the result is a build action (b1), and the resources allow, it deducts the required resources for build1 from the current state. B1 is set to 1, and B2 takes the value of the next state.
Build 2 (Result = b2):
If the result is a build action (b2), and the resources allow, it deducts the required resources for build2 from the current state. B1 takes the value of the current state, and B2 is set to 2.
Resource Acquisition (Result = reqf, Result = reqm, Result = reqe):
If the result is a resource acquisition action (reqf, reqm, reqe), it adds one unit of the respective resource to the current state. B1 and B2 take the values of the next state.
