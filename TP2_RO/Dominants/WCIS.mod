/*********************************************
 * OPL 22.1.1.0 Model
 * Author: eldisymeraj
 * Creation Date: Mar 21, 2024 at 11:34:13 AM
 *********************************************/
 
int n = ...;
tuple Edge {int u; int v;}
{Edge} Edges = ...;
{int} Nodes = {i.u | i in Edges} union {i.v | i in Edges};

// Calcul des sous-ensembles de sommets et leur complémentaires
// 'S' est l'ensemble de tous les sous-ensembles possibles des sommets
// 'Sub' contient les sommets de chaque sous-ensemble
// 'Compl' contient les sommets qui ne sont pas dans le sous-ensemble correspondant
// 'bordW' est initialisé comme vide et contiendra les sommets frontières des sous-ensembles
range S=1..ftoi(round(2^(n)));
{int} Sub[s in S]={i|i in Nodes: (s div ftoi(round(2^(i-1))))mod 2==1};
{int} bordW[s in S]={};
{int} Compl[s in S]=Nodes diff Sub[s]; 
{int} voisin [Nodes] ;

// Calcul des voisins de chaque sommet et mise à jour des sommets frontières pour chaque sous-ensemble
execute {
   for (var e in Edges) {
      voisin[e.u].add(e.v);
      voisin[e.v].add(e.u);
   }
   
   for (var s in S) {
      for (var e in Edges) {
         if(Sub[s].contains(e.u) && Compl[s].contains(e.v)) {
            bordW[s].add(e.u);
         }
         if(Sub[s].contains(e.v) && Compl[s].contains(e.u)) {
            bordW[s].add(e.v);
         }
      }
   }   
}

dvar boolean x[Nodes];
minimize sum(n in Nodes) x[n];

subject to { 
   // Chaque sous-ensemble de sommets doit avoir au moins un sommet frontière dans l'ensemble dominant
   forall(s in S) {
      sum(i in bordW[s]) x[i] >= 1;
   }
   
   // Aucune arête ne doit avoir ses deux extrémités dans l'ensemble dominant
   // Ceci assure qu'on ne choisit pas plus de sommets que nécessaire
   forall(edge in Edges) {
      x[edge.u] + x[edge.v] <= 1;
   } 		
}

// Construction de l'ensemble dominant à partir de la solution optimale
{int} dominant = {n | n in Nodes : x[n] == 1};
execute {
   writeln("Ensemble dominant : ", bordW);
}
