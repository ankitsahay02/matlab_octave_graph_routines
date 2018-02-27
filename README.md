# matlab graph routines
Some common functionalities for working with graphs in Matlab
- **random_multi_bottleneck_simple_graph.m** creates the adjacency matrix of a graph that has groups of vertices os sizes N(i) that are connected to each other with some given probablities P(i,j).
    - Let the P be the identity matrix, to get a disconnected graph where each connected component is a complete graph, or
    - let it be the J-I (ones(k,k) - eye(k)) to be a complete multipartite graph.
	
	##### Examples 
    1.
    ```matlab
    N = [15,25];
	P = [.90,.10; .10,.85];
	A = random_multi_bottleneck_simple_graph(N,P); 
	spy(A)
	```
	![N = [15,25]; P = [.90,.10; .10,.85];](/images/random_multi_bottleneck_simple_graph_ex1.png)
