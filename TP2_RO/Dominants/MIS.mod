/*********************************************
 * OPL 22.1.1.0 Model
 * Author: eldisymeraj
 * Creation Date: Mar 20, 2024 at 10:10:36 PM
 *********************************************/
int n = ...;

tuple Edge {int u; int v;}
{Edge} Edges = ...;
{int} Nodes = {i.u | i in Edges} union {i.v | i in Edges};
// On calcule les voisins pour chaque sommet
{int} voisin [Nodes] ;
execute {
   for (var e in Edges) {
      voisin[e.u].add(e.v);
      voisin[e.v].add(e.u);
   }
}

dvar boolean x[Nodes];

minimize sum(n in Nodes) x[n];

subject to {
  
   forall (node in Nodes) {
      // La contrainte d'inclusion
      x[node] + sum(v in voisin[node]) x[v] >= 1;
   } 
   
   forall(edge in Edges)
   {
      x[edge.u] + x[edge.v] <= 1;
   } 
   
}

// On recupere la solution optimale
{int} dominant = {n | n in Nodes : x[n] == 1};

execute {
   writeln("Ensemble dominant : ", dominant);
}