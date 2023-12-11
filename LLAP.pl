:- include('KB.pl').

helper(s0, Food, Materials, Energy, 0, 0):-
    food(Food), 
    materials(Materials), 
    energy(Energy).


helper(S, Food, Materials, Energy, B1, B2):-
    S = result(Result, S0),
    helper(S0,FoodBase,MaterialsBase,EnergyBase,Build1NewState,Build2NewState),
    (
        (Result = b1,build1(Build1Food,Build1Materials,Build1Energy), FoodBase >= Build1Food,MaterialsBase >= Build1Materials,EnergyBase >= Build1Energy,
        Food is FoodBase - Build1Food, Materials is MaterialsBase - Build1Materials, Energy is EnergyBase - Build1Energy, B1 = 1, B2 = Build2NewState);
     
        (Result = b2,build2(Build1Food,Build1Materials,Build1Energy),FoodBase >= Build1Food,MaterialsBase >= Build1Materials,EnergyBase >= Build1Energy,
        Food is FoodBase - Build1Food, Materials is MaterialsBase - Build1Materials, Energy is EnergyBase - Build1Energy, B1 = Build1NewState, B2 = 2);
     
        (Result= reqf, Food is FoodBase + 1, Materials = MaterialsBase, Energy = EnergyBase, B1 = Build1NewState, B2 = Build2NewState);
     
        (Result= reqm, Food = FoodBase, Materials is MaterialsBase + 1, Energy = EnergyBase, B1 = Build1NewState, B2 = Build2NewState);
     
        (Result= reqe, Food = FoodBase, Materials = MaterialsBase, Energy is EnergyBase + 1, B1 = Build1NewState, B2 = Build2NewState)
    ).


ids(S,L):-
    (call_with_depth_limit(helper(S,_,_,_,1,2),L,R), number(R));
    (call_with_depth_limit(helper(S,_,_,_,1,2),L,R), R=depth_limit_exceeded,
    L1 is L+1, ids(S,L1)).


goal(S):-
  ids(S,0).
