function B = random_multi_bottleneck_graph(varargin)
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
    % 2-part Example :
    % N = [15,25];
    % P = [.90,.10; 
    %      .10,.85];
    %
    % 3-part Example :
    % N = [20,15,25];
    % P = [.90,.10,.10; 
    %      .10,.85,.20; 
    %      .10,.20,.90];
    
    %taking care of the defaults
    defaultN = [10,15];
    defaultP = eye(length(defaultN));
    defaultWeighted = false;
    defaultSigned = 0;

    ip = inputParser;
    ip.CaseSensitive = false;
    addOptional(ip,'N',defaultN);
    addOptional(ip,'P',defaultP);
    addParameter(ip,'Weighted',defaultWeighted);
    addParameter(ip,'Signed',defaultSigned);
    
    parse(ip,varargin{:});
    
    N = ip.Results.N;
    P = ip.Results.P;
    Weighted = ip.Results.Weighted;
    Signed = ip.Results.Signed;
    
    %the function
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
                    if (r > c) %only consider the lower triagnle
                        if rand > 1-p %toss a coin
                            if Weighted %if I want a weightred graph
                                w = rand; %choose weights randomly
                            else %otherwise
                                w = 1; %keep them all equal to one
                            end
                            if rand < Signed %if I want a signed graph with
                                             %Signed fraction of edges
                                             %negative,
                                    s = -1; 
                            else %otherwise
                                s = 1; %keep them all positive
                            end
                            B(r,c) = s * w;
                            B(c,r) = s * w; %then symmetrize it
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
