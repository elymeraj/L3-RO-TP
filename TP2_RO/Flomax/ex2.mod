/*********************************************
 * OPL 22.1.1.0 Model
 * Author: eldisymeraj
 * Creation Date: Mar 21, 2024 at 12:19:45 PM
 *********************************************/
 
// Définition de la structure de données pour une case
tuple Case {
 key int i;
 key int j;
}

// Ensemble des cases admissibles
{Case} CasesAdmissibles = ...;

// Définition des tableaux a et b représentant respectivement l'offre et la demande
int a[1..3] = ...;
int b[1..4] = ...;

// Variables de décision: quantité à maximiser pour chaque case admissible
dvar int+ x[CasesAdmissibles];

maximize sum(c in CasesAdmissibles) x[c];

subject to {

 forall(i in 1..3)
   sum(c in CasesAdmissibles: c.i == i) x[c] <= a[i];

 forall(j in 1..4)
   sum(c in CasesAdmissibles: c.j == j) x[c] <= b[j];
}

execute {
 writeln("Solution x[c]:");
 for(c in CasesAdmissibles) {
  writeln("x[", c.i, ",", c.j, "] = ", x[c]);
 }
}
 