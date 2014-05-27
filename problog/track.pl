%%%%%%
%%%
%%%  Project: Anise 
%%%  Sub:     Inference 
%%%
%%%  Desc:    Main inference file. Calculates centerline path of a round tubular
%%%           structure described by "points" truth values. Values should be 
%%%           "inrange" to be considered inside the tube. path is calculated by 
%%%           means of "ruote" predicate starting from a "seed" point 
%%%
%%%  Author:  Alexander Baranya - 2014
%%%           
%%%
%%%%%%


%%% incluir la BD extensional de puntos
:-consult(points).

%just a test
point(203,144,2,1250).

%%%  Predicado ground que especifica el punto semilla
seed(203,143,0).

% predicados que indican la probabilidad de un punto de 
% estar en el rango de valores de intensidad deseado
0.99::inrange(X,Y,Z) <- point(X,Y,Z,I), I > 1100.
0.10::inrange(X,Y,Z) <- point(X,Y,Z,I), I =< 1100.

inr(X,Y,Z) :- point(X,Y,Z,I), I > 1100.

%  Predicados que indican que un punto esta en el camino generado por un punto
%  semilla. De esta forma:
%  1:00 si es el punto semilla
%  0.99 si está directamente debajo
%  0.50 si está movido una posicion en x o en y del punto directamente debajo
%  0.25 si está movido tanto en x como en y una posición del punto directamente debajo
%  en teoria las otras posiciones de componen de alguna forma a partir de esta. 

1.00::route(X,Y,Z) <- point(X,Y,Z,I), seed(X,Y,Z).
0.99::route(X,Y,Z) <- point(X,Y,Z,I), Z > 0, T is Z-1, route(X,Y,T).

0.80::route(X,Y,Z) <- point(X,Y,Z,I), Z > 0, Y > 0, T is Z-1, D is Y-1 , route(X,D,T).
0.80::route(X,Y,Z) <- point(X,Y,Z,I), Z > 0, Y > 0, T is Z-1, D is Y+1 , route(X,D,T).
0.80::route(X,Y,Z) <- point(X,Y,Z,I), Z > 0, X > 0, T is Z-1, D is X-1 , route(D,Y,T).
0.80::route(X,Y,Z) <- point(X,Y,Z,I), Z > 0, X > 0, T is Z-1, D is X+1 , route(D,Y,T).
%0.01::route(X,Y,Z) <- . 

%0.25::path(X,Y,Z) <- point(X,Y,Z,I), X > 0, T is X-1, path(T,Y,Z).
%0.25::path(X,Y,Z) <- point(X,Y,Z,I), T is X+1, path(T,Y,Z).
%0.25::path(XY,Z) <- point(X,Y,Z,I), Y > 0, T is Y-1, path(T,Y,Z).
%0.25::path(X,Y,Z) <- point(X,Y,Z,I), T is Y+1, path(T,Y,Z).


%%%% Bordering
% Predicado que calculan la distancia de un punto al borde en cada 
% dirección

north(X1,Y1,Z1,D1) :- inr(X1,Y1,Z1), Y1 > 0, Y is Y1 - 1, north(X1,Y,Z1,D), D1 is D + 1.
north(X1,Y1,Z1,D) :- \+inr(X1,Y1,Z1), D is 0.

south(X1,Y1,Z1,D1) :- inr(X1,Y1,Z1), Y is Y1 + 1, south(X1,Y,Z1,D), D1 is D + 1.
south(X1,Y1,Z1,D) :- \+inr(X1,Y1,Z1), D is 0.

west(X1,Y1,Z1,D1) :- inr(X1,Y1,Z1), X1 > 0, X is X1 - 1, west(X,Y1,Z1,D), D1 is D + 1.
west(X1,Y1,Z1,D) :- \+inr(X1,Y1,Z1), D is 0.

east(X1,Y1,Z1,D1) :- inr(X1,Y1,Z1), X is X1 + 1, east(X,Y1,Z1,D), D1 is D + 1.
east(X1,Y1,Z1,D) :- \+inr(X1,Y1,Z1), D is 0.
%% Predicado que estima la probabilidad P de ser equidistante  

eq_distant(D1,D2,D,M,P) :- D is abs(D1-D2), M is max(D1,D2), D > 0, P is 1.0 - (D/M).
eq_distant(D1,D2,D,M,P) :- D is abs(D1-D2), M is max(D1,D2), D =< 0, P is 1.0.

%% Predicado que computa, con base a los bordes la probabilidad del ser centro (bordes equidistantes)
Py::centeredY(X,Y,Z,Dy,My) :- north(X,Y,Z,D1), south(X,Y,Z,D2), eq_distant(D1,D2,Dy,My,Py). 
Px::centeredX(X,Y,Z,Dx,Mx) :- east(X,Y,Z,D3), west(X,Y,Z,D4), eq_distant(D3,D4,Dx,Mx,Px). 
centered(X,Y,Z) :- centeredX(X,Y,Z,D1,M1), centeredY(X,Y,Z,D2,M2).

%% Predicado que compone las 3 reglas principales para estimar la probabilidad total de un punto 
%% De ser parte de la línea central a partir de un punto semilla. 
center(X,Y,Z) :- centered(X,Y,Z), inrange(X,Y,Z), path(X,Y,Z).

%%%%%%%%%% consulta
%query(centered(200,_,0)).
%query(point(203,143,Z,I)).
%query(route(203,143,0)).
query(route(202,Y,Z)).
%query(inrange(203,142,0)).
%query(center(X,Y,Z)).
%query(north(203,Y,0,D)).
%query(centeredY(203,Y,0,D1,M1)).
%query(centeredX(X,143,0,D1,M1)).
%query(centered(X,Y,0)).
