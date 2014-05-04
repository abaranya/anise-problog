point(1,1,1,50).
point(1,2,1,50).
point(1,3,1,50).
point(1,4,1,50).
point(1,5,1,50).
point(2,1,1,50).
point(2,2,1,50).
point(2,3,1,50).
point(2,4,1,50).
point(2,5,1,50).
point(3,1,1,50).
point(3,2,1,50).
point(3,3,1,150).
point(3,4,1,150).
point(3,5,1,50).
point(4,1,1,50).
point(4,2,1,50).
point(4,3,1,150).
point(4,4,1,150).
point(4,5,1,50).
point(5,1,1,50).
point(5,2,1,50).
point(5,3,1,50).
point(5,4,1,50).
point(5,5,1,50).

point(1,1,2,50).
point(1,2,2,50).
point(1,3,2,50).
point(1,4,2,50).
point(1,5,2,50).
point(2,1,2,50).
point(2,2,2,50).
point(2,3,2,50).
point(2,4,2,50).
point(2,5,2,50).
point(3,1,2,50).
point(3,2,2,50).
point(3,3,2,50).
point(3,4,2,50).
point(3,5,2,50).
point(4,1,2,50).
point(4,2,2,50).
point(4,3,2,50).
point(4,4,2,150).
point(4,5,2,150).
point(5,1,2,50).
point(5,2,2,50).
point(5,3,2,50).
point(5,4,2,150).
point(5,5,2,150).


point(10,1,2,150).
point(10,2,2,50).
point(10,3,2,50).
point(10,4,2,150).
point(10,5,2,150).
point(10,6,2,150).
point(10,7,2,150).
point(10,8,2,150).
point(10,9,2,150).
point(10,10,2,50).
point(10,11,2,150).
point(10,12,2,150).


seed(4,4,1).

0.99::inrange(X,Y,Z) <- point(X,Y,Z,I), I > 100.
0.10::inrange(X,Y,Z) <- point(X,Y,Z,I), I =< 100.

inr(X,Y,Z) :- point(X,Y,Z,I), I > 100.

0.99::not_inrange(X,Y,Z) <- point(X,Y,Z,I), I =< 100.
0.10::not_inrange(X,Y,Z) <- point(X,Y,Z,I), I > 100.

1.00::path(X,Y,Z) <- point(X,Y,Z,I),seed(X,Y,Z).
0.90::path(X,Y,Z) <- point(X,Y,Z,I), Z > 0, T is Z-1, path(X,Y,T).
0.50::path(X,Y,Z) <- point(X,Y,Z,I), Z > 0, Y > 0, T is Z-1, D is Y-1 , path(X,D,T).
0.50::path(X,Y,Z) <- point(X,Y,Z,I), Z > 0, T is Z-1, D is Y+1 , path(X,D,T).
0.50::path(X,Y,Z) <- point(X,Y,Z,I), Z > 0, X > 0, T is Z-1, D is X-1 , path(D,Y,T).
0.50::path(X,Y,Z) <- point(X,Y,Z,I), Z > 0, T is Z-1, D is X+1 , path(D,Y,T).
0.25::path(X,Y,Z) <- point(X,Y,Z,I), X > 0, T is X-1, path(T,Y,Z).
0.25::path(X,Y,Z) <- point(X,Y,Z,I), T is X+1, path(T,Y,Z).
0.25::path(XY,Z) <- point(X,Y,Z,I), Y > 0, T is Y-1, path(T,Y,Z).
0.25::path(X,Y,Z) <- point(X,Y,Z,I), T is Y+1, path(T,Y,Z).

%%%% Bordering

north(X1,Y1,Z1,D1) :- inr(X1,Y1,Z1), Y1 > 0, Y is Y1 - 1, north(X1,Y,Z1,D), D1 is D + 1.
north(X1,Y1,Z1,D) :- \+inr(X1,Y1,Z1), D is 0.

south(X1,Y1,Z1,D1) :- inr(X1,Y1,Z1), Y is Y1 + 1, south(X1,Y,Z1,D), D1 is D + 1.
south(X1,Y1,Z1,D) :- \+inr(X1,Y1,Z1), D is 0.

west(X1,Y1,Z1,D1) :- inr(X1,Y1,Z1), X1 > 0, X is X1 - 1, west(X,Y1,Z1,D), D1 is D + 1.
west(X1,Y1,Z1,D) :- \+inr(X1,Y1,Z1), D is 0.

east(X1,Y1,Z1,D1) :- inr(X1,Y1,Z1), X is X1 + 1, east(X,Y1,Z1,D), D1 is D + 1.
east(X1,Y1,Z1,D) :- \+inr(X1,Y1,Z1), D is 0.

eq_distant(D1,D2,D,M,P) :- D is abs(D1-D2), M is max(D1,D2), D > 0, P is 1.0 / D.
eq_distant(D1,D2,D,M,P) :- D is abs(D1-D2), M is max(D1,D2), D =< 0, P is 1.0.

Py::centeredY(X,Y,Z,Dy,My) :- north(X,Y,Z,D1), south(X,Y,Z,D2), eq_distant(D1,D2,Dy,My,Py). 
Px::centeredX(X,Y,Z,Dx,Mx) :- east(X,Y,Z,D3), west(X,Y,Z,D4), eq_distant(D3,D4,Dx,Mx,Px). 
centered(X,Y,Z) :- centeredX(X,Y,Z,D1,M1), centeredY(X,Y,Z,D2,M2).

center(X,Y,Z) :- centered(X,Y,Z), inrange(X,Y,Z), path(X,Y,Z).
center1(X,Y,Z) :- centered(X,Y,Z), inrange(X,Y,Z).
center2(X,Y,Z) :- inrange(X,Y,Z), path(X,Y,Z).
center3(X,Y,Z) :- centered(X,Y,Z).
center4(X,Y,Z) :- inrange(X,Y,Z).
center5(X,Y,Z) :- path(X,Y,Z).

%query(center1(X,Y,2)).
%query(center2(X,Y,2)).
%query(center3(X,Y,2)). //checked
%query(center4(X,Y,2)). //checked
%query(center5(X,Y,2)). //checked
query(center(X,Y,2)).

%1.00::center(X,Y,Z) <- 

%query(center(4,4,2)).
%query(center(5,4,2)).
%query(center(3,4,2)).
%query(center(2,4,2)).


%0.7::burglary.
%0.2::earthquake.

%0.9::alarm <- burglary, earthquake.
%0.8::alarm <- burglary, \+earthquake.
%0.1::alarm <- \+burglary, earthquake.

%0.8::calls(X) <- alarm, person(X).
%0.1::calls(X) <- \+alarm, person(X).


%%% Evidence
%evidence(calls(john),true).
%evidence(calls(mary),true).

%%% Queries
%query(burglary).
%query(earthquake).