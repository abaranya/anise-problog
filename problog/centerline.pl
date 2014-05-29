%%%%%%
%%%
%%%  Project: Anise 
%%%  Sub:     Inference 
%%%
%%%  Desc:    Test inference file. Calculates centerline path of a round tubular
%%%           structure described by "points" truth values. Values should be 
%%%           "inrange" to be considered inside the tube. path is calculated by 
%%%           means of "ruote" predicate starting from a "seed" point that stablish 
%%%           some point inside a given slide of the volume.
%%%
%%%  Author:  Alexander Baranya - 2014
%%%           
%%%
%%%%%%

%%% Include extensional DB of points
%%% point(X,Y,Z,I) predicate 
%%%   X,Y,Z : should instantiate integers corresponding to XYZ coordinate in space
%%%   I     : should instantiate integer corresponding intensity value at XYZ point
:-consult(points).

%%% Include extensional DB of points to be known inside the tube
%%% known(X,Y,Z) predicate 
%%%   X,Y,Z : should instantiate integers corresponding to XYZ coordinate in space

:-consult(known).
