/*********************************************
 * OPL 22.1.1.0 Model
 * Author: eldisymeraj
 * Creation Date: Mar 11, 2024 at 2:43:02 PM
 *********************************************/

 int n = ...;
 {string} Nodes = ...;
 string s =...;
 string p =...;
 //Définir les aretes du graphe
 tuple Edge{string u; string v;};
 
 {Edge} Edges with u in Nodes, v in Nodes = ...;
 float Debit[Edges] = ...;
 
 dvar float+ x[Edges];
 dvar float+ v;
 
 maximize v;
 
 subject to
 {
   forall(i in Nodes: i != s && i != p)
   {
     sum(a in Edges : a.u == i) x[a] - sum(a in Edges : a.v == i) x[a] == 0;
     
     }
     
   // pour la super source
   sum(a in Edges: a.u == s) x[a] -  sum(a in Edges: a.v == s) x[a] == v;
   
   // pour le super puits
   sum(a in Edges: a.u == p) x[a] -  sum(a in Edges: a.v == p) x[a] == -v;
   
   forall(e in Edges){
     x[e] <= Debit[e];
   }
   
}

execute{writeln("Le flot maximal :", x);}

