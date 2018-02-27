function B = random_multi_bottleneck_simple_graph(N,P)
    % Inputs:
    %   N: a list of k numbers of vertices in each part, that adds up to n,
    %       total number of vertices.
    %       Default: N = [10, 15]
    %   P: a kxk symetric matrix with (i,j) entry being the the
    %       probability of and edge between part i and j.
    %       Default: identity matrix of size k, i.e. the output will have
    %       k disconnected components and each connected component is a
    %       complete graph.
    %
    % Outputs:
    %   B: an nxn adjacency matrix of the graph
    %
    % One bottleneck Example :
    % N = [15,25];
    % P = [.90,.10; 
    %      .10,.85];
    % A = random_multi_bottleneck_simple_graph(N,P); 
    %
    % Three bottlenecks Example :
    % N = [20,15,25];
    % P = [.90,.10,.10; 
    %      .10,.85,.20; 
    %      .10,.20,.90];
    % A = random_multi_bottleneck_simple_graph(N,P); 
    %
    % Complete connected components
    %
    % N = [20,15,25];
    % P = eye(length(N));
    % A = random_multi_bottleneck_simple_graph(N,P); 
    % or just run it without specifying the P
    % A = random_multi_bottleneck_simple_graph(N); 
    % 
    % Complte tripartite Example
    % N = [20,15,25];
    % P = ones(length(N), length(N)) - eye(length(N));
    % A = random_multi_bottleneck_simple_graph(N,P); 
    %
    % You can run the code without any inputs and it will return a graph 
    % on 40 vertices with two connected components where the connected 
    % components are complete graphs of sizes 10 and 15, respectively.
    
    %taking care of the defaults
    if nargin < 2
        if nargin < 1
            N = [10, 15];
        end
        P = eye(sum(N));
    end
    
    n = sum(N); %total number of vertices
    B = zeros(n); %initialize the adjacency matrix
    
    % add vertices 
    p_adjust = 0; %for moving up each part in rows
    k = 1;
    while k <= length(N)
        q_adjust = 0; %for moving up each part in columns
        l = 1;
        while l <= length(N)
            p = P(k,l); %probability of edges between parts k and l
            for r = p_adjust+1:p_adjust+N(k) %rows of  this part
                for c = q_adjust+1:q_adjust+N(l) %columns of this part
                    if (r>c) %only consider the lower triagnle
                        if rand > 1-p %toss a coin
                            B(r,c) = 1;
                            B(c,r) = 1; %then symmetrize it
                        end
                    end
                end
            end
            q_adjust = q_adjust + N(l); %move on to next part of columns
            l = l+1;
        end
        p_adjust = p_adjust + N(k); %move on to next part of rows
        k = k+1;
    end
end
