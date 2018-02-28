# matlab graph routines
Some common functionalities for working with graphs in Matlab
- **random_multi_bottleneck_graph.m** creates the adjacency matrix of a graph that has groups of vertices of sizes N(i) that are connected to each other with some given probablities P(i,j). You can also create weighted or signed graphs.
	
	##### Examples 
    1. One bottleneck
    ```matlab
	N = [15,25];
	P = [.90,.10; 
		 .10,.85];
	A = random_multi_bottleneck_graph(N,P); 
	spy(A)
	```
	![N = [15,25]; 
	P = [.90,.10; 
		 .10,.85];](/images/random_multi_bottleneck_simple_graph_ex1.png)
	
	2. Three bottlenecks
	```matlab
	N = [20,15,25];
	P = [.90,.10,.10; 
		 .10,.85,.20; 
		 .10,.20,.90];
	A = random_multi_bottleneck_graph(N,P); 
	spy(A)
	```
	![N = [20,15,25];
	P = [.90,.10,.10; 
		 .10,.85,.20; 
		 .10,.20,.90];](/images/random_multi_bottleneck_simple_graph_ex2.png)

	3. Complete connected components
	 ```matlab
	N = [20,15,25];
	P = eye(length(N));
	A = random_multi_bottleneck_graph(N,P); 
	spy(A)
	```
	![N = [20,15,25];
	P = [1,0,0; 
		 0,1,0; 
		 0,0,1];](/images/random_multi_bottleneck_simple_graph_ex3.png)
	
	You don't have to specify P if you want this.
		 
	4. Complete tripartite
	```matlab
	N = [20,15,25];
	P = ones(length(N), length(N)) - eye(length(N));
	A = random_multi_bottleneck_graph(N,P); 
	spy(A)
	```
	![N = [20,15,25];
	P = [0,1,1; 
		 1,0,1; 
		 1,1,0];](/images/random_multi_bottleneck_simple_graph_ex4.png)

	5. Weighted 
	```matlab
	N = [20,15,25];
	P = [.90,.10,.10; 
		 .10,.85,.20; 
		 .10,.20,.90];
	A = random_multi_bottleneck_graph(N,P,'weighted',true); 
	imagesc(A)
	colormap('jet')
	caxis([-1,1])
	colorbar
	```
	![weighted](/images/random_multi_bottleneck_simple_graph_ex5.png)
	
	6. Weighted and signed 
	```matlab
	N = [20,15,25];
	P = [.90,.10,.10; 
		 .10,.85,.20; 
		 .10,.20,.90];
	A = random_multi_bottleneck_graph(N,P,'weighted',true,'Signed',.5); 
	imagesc(A)
	colormap('jet')
	caxis([-1,1])
	colorbar
	```
	![weighted and signed](/images/random_multi_bottleneck_simple_graph_ex6.png)
	
	You can run the code without any inputs and it will return a graph on 40 vertices with two connected components where the connected components are complete graphs of sizes 10 and 15, respectively.
	
- **spectral_coordinate.m** returns the k-dimensional spectral coordinates of a (signed) graph as defined in [1], which then can be used to cluster the vertices.
	##### Example
	1. First generate a random signed graph that is clusterable, using above
	```matlab
	N = [20,15,25];
	P = [.90,.10,.10; 
		 .10,.95,.10; 
		 .10,.10,.90];
	A = random_multi_bottleneck_graph(N,P,'weighted',true,'Signed',.1);
	imagesc(A);
	caxis([-1,1]);
	colormap('jet');
	colorbar;
	```
	![a signed graph with some apparent clusters](/images/random_multi_bottleneck_simple_graph_ex7.png)
	Then find its spectral coordinates in 3 dimenstions and plot them
	```matlab
	S = spectral_coordinate(A,3); 
	str = cell(1,size(A,1));
	for j = 1:size(A,1)
		str{j} = num2str(j);
	end
	xt(:) = 1.1*S(:,1);
	yt(:) = 1.1*S(:,2);
	zt(:) = 1.1*S(:,3);

	scatter3(S(:,1),S(:,2),S(:,3),'o');
	hold on;
	text(xt,yt,zt,str);
	[x,y,z] = sphere;
	surf(x,y,z,'FaceAlpha',.1);
	colormap([0,0,0]);
	shading interp
	view([-68 -46]);
	axis off;
	```
	![3 dimensional spectral coordinates of the nodes on the unit sphere](/images/spectral_coordinate_ex1.png)
	The nodes are very neatly clustered together on the unit sphere.
	
	

[1] L. Wu, X. Wu, A. Lu and Y. Li, 
       "On Spectral Analysis of Signed and Dispute Graphs: Application
       to  Community Structure,"  
       IEEE Transactions on Knowledge and Data Engineering, 
       29, 7, 1480--1493, 2017.
       10.1109/TKDE.2017.2684809
