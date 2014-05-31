%%%%%%
%%%
%%%  Project: Anise 
%%%  Sub:     reduce.pl 
%%%
%%%  Desc:    Inference file. Produces the set of points that follow a track around
%%%           an specified radix.
%%%
%%%  Author:  Alexander Baranya - 2014
%%%           
%%%
%%%%%%

%%% Load the set of points.
:-consult(points).

%%% Load the track
:-consult(vessel_track).

%%% Specify the radix
%%% Ri = (z / Nz) * (Rmayor - Rmenor) + Rmenor
%%% Now fixed Ri = 28
radix(_,28).

%%% Calculates 
inside(X1,X2,Z):- radix(Z,R), X1 => X2 - R , X1 =< X2 + R. 

%%% Just for testing
tpoint(X,Y,Z):- point(X,Y,0)


%%%
rpoint(X,Y,Z):-tpoint(X,Y,Z), vessel_track(X,Y,Z).
rpoint(X,Y,Z):-tpoint(X,Y,Z), inside(X1,X,Z), vessel_track(X,_,Z).


%%%
query(rpoint(X,Y,Z)).