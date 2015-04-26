%%%%%%
%%%
%%%  Project: Anise 
%%%  Sub:     Inference 
%%%
%%%  Desc:    Test inference file. Given a 3D intensity point (seed) calculates  
%%%           the point with the highest probability of being below
%%%
%%%  Author:  Alexander Baranya (abaranya@gmail.com) - 2014, 2015
%%%           
%%%
%%%%%%

%%% Include extensional DB of points
%%% point(X,Y,Z,I) predicate 
%%%   X,Y,Z : should instantiate integers corresponding to XYZ coordinate in space
%%%   I     : should instantiate integer corresponding intensity value at XYZ point
%:-consult(points_below_test).

%% Your program
point(0,0,1,100).
point(1,1,1,100).

point(0,0,2,100).
point(1,1,2,100).
point(0,1,2,100).
point(2,1,2,100).

point(0,0,3,100).
point(1,1,3,100).
point(2,1,3,100).


point(3,1,4,100).
point(1,2,4,100).
point(2,1,4,100).

point(3,1,5,100).

%%%
%%%
%%%

seed_up(1,1,1).
seed_down(2,1,4).

max(10).
zmax(10).

1.00::below(X,Y,Z) :- point(X,Y,Z,I), seed_up(X,Y,Z).
% Just below
0.95::below(X,Y,Z) :- point(X,Y,Z,I), Z > 0, Z1 is Z - 1, below(X,Y,Z1).

% X side below
0.60::below(X,Y,Z) :- point(X,Y,Z,I), Z > 0, Z1 is Z - 1, X > 0, X1 is X-1, below(X1,Y,Z1).
0.60::below(X,Y,Z) :- point(X,Y,Z,I), Z > 0, Z1 is Z - 1, max(M), X < M, X1 is X+1, below(X1,Y,Z1).

% Y side below
0.60::below(X,Y,Z) :- point(X,Y,Z,I), Z > 0, Z1 is Z - 1, Y > 0, Y1 is Y-1, below(X,Y1,Z1).
0.60::below(X,Y,Z) :- point(X,Y,Z,I), Z > 0, Z1 is Z - 1, max(M), Y < M, Y1 is Y+1, below(X,Y1,Z1).


1.00::over(X,Y,Z) :- point(X,Y,Z,I), seed_down(X,Y,Z).

0.95::over(X,Y,Z) :- point(X,Y,Z,I), zmax(M), Z < M, Z1 is Z + 1, over(X,Y,Z1).

% X side over
0.60::over(X,Y,Z) :- point(X,Y,Z,I), zmax(M), Z < M, Z1 is Z + 1, X > 0, X1 is X-1, over(X1,Y,Z1).
0.60::over(X,Y,Z) :- point(X,Y,Z,I), zmax(M), Z < M, Z1 is Z + 1, max(Mx), X < Mx, X1 is X+1, over(X1,Y,Z1).

% Y side over
0.60::over(X,Y,Z) :- point(X,Y,Z,I), zmax(M), Z < M, Z1 is Z + 1, X > 0, Y1 is Y-1, over(X,Y1,Z1).
0.60::over(X,Y,Z) :- point(X,Y,Z,I), zmax(M), Z < M, Z1 is Z + 1, max(My), Y < My, Y1 is Y+1, over(X,Y1,Z1).



%query(below(X,Y,Z)).
%query(over(X,Y,Z)).
%query(over(1,1,3)).

1.00::test(X,Y,Z) :- below(X,Y,Z), over(X,Y,Z). 
0.5:: test(X,Y,Z) :- below(X,Y,Z).
0.5:: test(X,Y,Z) :- over(X,Y,Z).

query(test(X,Y,Z)).
