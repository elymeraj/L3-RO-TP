/*********************************************
 * OPL 22.1.1.0 Model
 * Author: user
 * Creation Date: 21 Feb 2024 at 15:29:18
 *********************************************/
dvar float+ x;
dvar float+ y;

minimize -2*x -y;

subject to{
  c1: x <= 4;
  c2: x+y <= 5;
  c3: 2*x + 3*y <= 12;
}

execute {
  writeln("Post-processing: ");
  writeln("La valeur de la fonction objectif est:  "+cplex.getObjValue());
  
  writeln("La solution duale pour c1: ", c1.dual);
  writeln("La solution duale pour c2: ",c2.dual);
  writeln("La solution duale pour c3: ", c3.dual);
  
  writeln("Le cout reduit pour la variable x: ", x.reducedCost);
  writeln("Le cout reduit pour la variable y: ", y.reducedCost);

  writeln("La valeur de variable d'ecart pour c1: ", c1.slack);
  writeln("La valeur de variable d'ecart pour c2: ", c2.slack);
  writeln("La valeur de variable d'ecart pour c3: ", c3.slack);
  
} 