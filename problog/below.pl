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

point(0,0,1,100).
point(0,0,2,100).
point(0,0,3,100).
point(1,1,1,100).
point(1,1,2,100).
point(1,1,3,100).
point(1,2,4,100).
point(2,1,4,100).

%%% 
%%% 
%%%   

seed(1,1,1).

someseed :- seed(1,1,1).

query(someseed).
