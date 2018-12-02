# MPSiS 2018/2019
# Model CFAP, L/P - problem W2, CW_3 

/* Number of paths, edges, demands */
param P_count, integer, >= 0;
param E_count, integer, >= 0;
param D_count, integer, >= 0;

/* Sets of paths, edges and demands */
set P, default {1..P_count};
set E, default {1..E_count};
set D, default {1..D_count};

/* Requirements */
param h{d in D} >= 0; //wolumen ruchu w ramach zapotrzebowania d

/* Capacity */
param c{e in E} >= 0, default 1;   /* pojemność łączy, default - jesli brak przypisania to przypisana 						bedzie wartosc z default*/

/* KSI*/
param KSI{e in E} >= 0; //koszt w zwiazku z uzyciem jednostki pojemnosci na łączu e

/* M */
param M, integer, default 10000;

/* delta */
param delta{e in E,d in D,p in P}, binary, default 0;


/* Decision variables */
var x{d in D, p in P} >= 0;     //sciezka do zapotrzebowania
var y{e in E} >=0; //suma wszystkich przeplywow na laczu e
var u{d in D,p in P}, binary;

/* Objective function 'z' */
minimize z: sum{e in E} (KSI[e]*y[e]); /* - u nas bez zmian*/

/* Constraints */       /*  - tego nie tykać chyba*/
s.t. c1{e in E} : sum{d in D,p in P}(delta[e,d,p]*u[d,p]*h[d])==y[e];
s.t. c2{d in D,p in P} : x[d,p]<=u[d,p]*M;
//todo:suma x dla danego zapotrzebowania na konkretnej scieze = h[d]


/*
printf{e in E, v in V} "A[%d,%d] = %d, B[%d,%d] = %d\n", e, v, A[e, v], e, v, B[e, v];
printf{e in E} "K[%d] = %d, c[%d] = %d\n", e, K[e], e, c[e];
printf{d in D} "s[%d] = %d, t[%d] = %d, h[%d] = %d\n", d, s[d], d, t[d], d, h[d];*/

end;
