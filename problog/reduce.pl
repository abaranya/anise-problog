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

%%%
euclid(X1,X2,Y1,Y2,D):- D is sqrt(abs(X1-X2)**2 + abs(Y1-Y2)**2).

%%% Calculates 
inside(X,Y,Z):- radix(Z,R), vessel_track(X1,Y1,Z), euclid(X,X1,Y,Y1,D), D =< R. 

%%% Just for testing
tpoint(X,Y,Z):- point(X,Y,Z,_).  %Shouldn't be more than 1 intensity value I per point


%%%
rpoint(X,Y,Z):-tpoint(X,Y,Z), vessel_track(X,Y,Z).
rpoint(X,Y,Z):-tpoint(X,Y,Z), inside(X,Y,Z).


