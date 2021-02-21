%current sampling strat im workingo nwith sir
function localset=bfslocalset(G,S)
    vertices=G.N;
    count=1;
    
    %you can convert this strtuct to a matrix, see if that works
    adjorig=full(G.A);
    adj=adjorig;
    deg=G.d;
    
    
    %creating the bfs matrix
    %each row is the bfsearch output
    bfs=zeros(G.N,G.N);
    grap=graph(G.A);
    for i=[1:G.N]
        bfs(i,:)=[bfsearch(grap,i); zeros(G.N-length(bfsearch(grap,i)),1)];
    end
    %bfs
    
    
    Sonehot=zeros(G.N,1);
    i=1;
    while(i <=length(S))
        Sonehot(S(i))=S(i);
        i=i+1;
    end
    test=[deg Sonehot];
    test=sortrows(test);
    
    localset=zeros(G.N,G.N);
    i=1;
    while(i<=length(S))
        localset(S(i),S(i))=1;
        i=i+1;
    end
    
    
    %CONVERT COLUMNS OF SAMPLING POINTS TO ALL 0S
    adj(:,S)=0;
    
    %CREATING THE LOCAL SET
    iter=100;
    q=0;
    visited=ones(1,G.N);
    visited(S)=0;
    %visited
    while( sum(visited)~=0 && q<iter )
        q=q+1;
        %sum(visited)
        %disp("refresh")
        for j=[1:length(S)]
            i=S(j);
            for k=1:G.N
                %[i k sum(visited)]
                %[i j k]
                %bfs(i,k)
                if sum(visited)==0
                    j=length(S);
                    break;
                end
                %OTHER LOCALSETS CANNOT HAVE SAMPLED VERTICES, CHANGE IF
                %CONDITIONS
                %[bfs(i,k+1) visited(bfs(i,k+1))]
                if bfs(i,k+1)==0 || visited(bfs(i,k+1))==0 
                    %disp("if1");
                    continue;
                else
                    %disp("if2");
                    visited(bfs(i,k+1))=0;
                    localset(i,bfs(i,k+1))=1;
                    break;
                end
            end
        end
    end
        
    for i=1:length(S)
    i=S(i);
    localset(i,i)=1;
    end
    
end
