// -------- PARAMETERS --------
int N = 4;
range Stations = 1..N;
float P[Stations] = [5, 10, 8, 7];         // Processing times
float T = 1000 / 60.0;                     // Target throughput rate ≈ 16.67 products/sec
float W = 10;                              // Max WIP allowed before any stage
float M = 1000;                            // Dummy M constant for arc activation

// -------- TUPLE & SETS --------
tuple Edge {
 int from_node;
 int to_node;
};
{Edge} E = {
 <1,2>, <1,3>, <1,4>,
 <2,3>, <2,4>,
 <3,4>
};

// -------- DECISION VARIABLES --------
dvar int+ S[Stations];             // Number of parallel stations per process
dvar boolean x[E];                // Whether connection (i→j) is active
dvar float+ f[E];                 // Flow from process i to j

// -------- OBJECTIVE --------
minimize sum(i in Stations) S[i];

// -------- CONSTRAINTS --------
subject to {
 // Capacity constraint
 forall (j in Stations)
   sum(e in E : e.to_node == j) f[e] <= S[j] / P[j];
 // Source output
 sum(e in E : e.from_node == 1) f[e] == T;
 // Sink input
 sum(e in E : e.to_node == 4) f[e] == T;
 // Flow conservation for internal nodes
 forall (k in Stations : k != 1 && k != 4)
   sum(e in E : e.from_node == k) f[e] == sum(e in E : e.to_node == k) f[e];
 // WIP constraint surrogate: limit flow to downstream capacity
 forall (e in E)
   f[e] <= S[e.to_node] / P[e.to_node];
 // Flow only allowed if arc is active
 forall (e in E)
   f[e] <= M * x[e];
}

