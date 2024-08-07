% Ejercicio 10
depende(a, c).
depende(c, d).
depende(b, d).
depende(b, f).
depende(d, e).
depende(f, g).
depende(e, h).
depende(e, i).
depende(h, j).
depende(i, j).
depende(g, j).

requiere_de(X,Y) :- depende(X,Y).
requiere_de(X,Y) :- depende(X,D), requiere_de(D,Y).