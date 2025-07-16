// -------- PARAMETERS --------
int N = 4;
range Proc = 1..N;

float P[Proc] = [5, 10, 8, 7];         // Processing times
float T = 1000 / 60.0;                     // Target throughput rate ≈ 16.67
float W = 10;                              // Max WIP allowed before any stage
float M = 1000;                            // Big M constant for arc activation

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
dvar int+ S[Proc];             // Number of parallel stations per process
dvar boolean x[e in E];                // Whether connection (i→j) is active
dvar float+ f[e in E];                 // Flow from process i to j

// -------- HELPER EXPRESSION----------
	// total incoming flow into process j
dexpr float TotalInFlow[j in Proc] =
  sum(e in E : e.to_node == j) f[e];

// -------- OBJECTIVE --------
minimize sum(i in Proc) S[i];

// -------- CONSTRAINTS --------
subject to {

  // Capacity constraint: each process must support its incoming flow forall(j in Proc)
  forall (j in Proc)
    sum(e in E : e.to_node == j) f[e] <= S[j] / P[j];

  // Flow requirements: net flow = +T at source, -T at sink, 0 otherwise
  forall(i in Proc : i != 1 && i != 4)
    sum(e in E : e.from_node == i) f[e]
    == sum(e in E : e.to_node == i) f[e];

  // WIP constraint: limit accumulation between i → j
  //  so that in any 60s window the WIP ≤ 10 units
 forall(e in E)
    (TotalInFlow[e.to_node] / (S[e.to_node] / P[e.to_node])) 
    	- (f[e] / (S[e.from_node] / P[e.from_node])) <= W / 60.0;
  
  // Flow only allowed if arc is active
  forall (e in E)
    f[e] <= M * x[e];
}
