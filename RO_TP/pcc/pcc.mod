/*********************************************
 * OPL 22.1.1.0 Model
 * Author: user
 * Creation Date: 23 Feb 2024 at 06:39:26
 *********************************************/
int n = ...;
{string} Nodes = ...;
string s=...;
string p=...;
// D�finition des ar�tes du graphe
tuple Edge {string u; string v;}

{Edge} Edges with u in Nodes,v in Nodes=...;
float Duree[Edges]=...;

dvar boolean x[Edges];


minimize sum(e in Edges) Duree[e] * x[e];


subject to
{
  
  forall (i in Nodes : i != s && i != p) {
      sum(a in Edges : a.u == i) x[a] - sum(a in Edges : a.v == i) x[a] == 0;
   }
   
   // Le sommet A est le point de d�part
   sum(a in Edges : a.u == s) x[a] - sum(a in Edges : a.v == s) x[a] == 1;
   
   // Le sommet H est le point d'arriv�e
   sum(a in Edges : a.u == p) x[a] - sum(a in Edges : a.v ==p) x[a] == -1;

  
}

{Edge} Used = {e | e in Edges : x[e]==1};



execute {writeln("used edges", Used);}