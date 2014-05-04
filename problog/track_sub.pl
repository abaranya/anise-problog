%%% incluir la BD extensional de puntos
:-consult(points).

%just a test
point(203,144,2,1250).

%%%  Predicado ground que especifica el punto semilla
seed(203,143,0).

%  Predicados que indican que un punto esta en el camino generado por un punto
%  semilla. De esta forma:
%  1:00 si es el punto semilla
%  0.99 si está directamente debajo
%  0.80 si está movido una posicion en x o en y del punto directamente debajo
%  0.65 si está movido tanto en x como en y una posición del punto directamente debajo

1.00::route(X,Y,Z) <- point(X,Y,Z,I), seed(X,Y,Z).
0.99::route(X,Y,Z) <- point(X,Y,Z,I), Z > 0, T is Z-1, route(X,Y,T).

0.80::route(X,Y,Z) <- point(X,Y,Z,I), Z > 0, Y > 0, T is Z-1, D is Y-1 , route(X,D,T).
0.80::route(X,Y,Z) <- point(X,Y,Z,I), Z > 0, Y > 0, T is Z-1, D is Y+1 , route(X,D,T).
%AQUI ELIMINE LOS OTROS PREDICADOS SOLO PARA CONCENTRARME EN LA PRUEBA SOBRE Y


%%%%%%%%%% consultas

query(center(_,_,_)). 

