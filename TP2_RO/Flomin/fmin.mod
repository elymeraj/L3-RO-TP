/*********************************************
 * OPL 22.1.1.0 Model
 * Author: eldisymeraj
 * Creation Date: Mar 19, 2024 at 7:54:32 PM
 *********************************************/

// Nombre de destinations (villes)
int nbDestinations = ...;
// Définition de l'ensemble des destinations (villes)
range Destinations = 1..nbDestinations;

// Nombre de sources (ports)
int nbSources = ...;
// Définition de l'ensemble des sources (ports)
range Sources = 1..nbSources;

// Structure représentant une connexion (arête) entre une source et une destination
tuple Edge {
 int source;
 int destination;
}

// Ensemble des connexions entre sources et destinations
{Edge} Edges with source in Sources, destination in Destinations = ...;

// Coût associé à chaque connexion
float Cost[Edges] = ...;

// Demande de chaque destination
int Demande[1..nbDestinations]=...;
// Offre de chaque source
int Offre[1..nbSources]=...;

// Variables de décision: quantité transportée sur chaque connexion
dvar float+ flux[Edges];

// Objectif: Minimiser le coût total de transport
minimize sum(e in Edges) Cost[e] * flux[e];

subject to {
 // Contraintes d'offre pour chaque source
 forall (s in Sources){
  (sum(e in Edges : e.source==s) flux[e]) == Offre[s]; 
 }
 // Contraintes de demande pour chaque destination
 forall (d in Destinations){
  (sum(e in Edges : e.destination==d) flux[e]) == Demande[d]; 
 }
}

// Affichage de la solution optimale
execute {
 writeln("Coût de transport minimum : ", cplex.getObjValue());
}
 