/*********************************************
 * OPL 22.1.1.0 Model
 * Author: user
 * Creation Date: 21 Feb 2024 at 16:03:36
 *********************************************/
{string} Products =...;
{string} Factories=...;

float r[Products]=...;
float t[Products][Factories]=...;
float c[Factories]=...;

dvar float+ x[Products];

maximize sum(p in Products) r[p]*x[p];

subject to{
  forall(i in Factories)
    c1: sum(p in Products) t[p][i]*x[p] <= c[i];
}

execute {
  writeln("Post-processing: ");
  writeln("La valeur de la fonction objectif est:  "+cplex.getObjValue());
  
  for(var i in Factories){
    writeln("La valeur duale pour "+i+" est: ", +c1[i].dual);
  }
  for(var i in Factories){
    writeln("La valeur duale pour "+i+" est: ", +c1[i].dual);
  }
  for(var i in Products){
    writeln("La variable reduite "+i+" est: ", +x[i].reducedCost);
  }
  for(var i in Factories){
    writeln("La valeur de variable d'ecart "+i+ " est: ", +c1[i].slack);
  }
  
  
} 