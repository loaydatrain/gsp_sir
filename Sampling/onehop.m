function [Sfinal localset]=onehop(G)
    vertices=G.N;
    count=1;
    S=zeros(vertices,1);
    
    %you can convert this strtuct to a matrix, see if that works
    adj=G.A;
    deg=G.d;
    
    
    
    localset=zeros(G.N,G.N);
    while (count <= vertices) %end when gone through all vertices
        [u, i]=max(deg);
        if(u==0)
            break;
        else
            S(i)=1;
            localset(i,i)=1;
            count=count+1;
            j=G.N;
            %initialise local set
            while(j>0)
                if adj(i,j)==1
                    localset(i,j)=1;
                    %carry out steps 4,5 of algo
                    adj(j,:)=0; %adj(i,j)=0;  
                    adj(:,j)=0; %adj(j,:)=0; 
                    deg(j)=0;
                    deg(i)=deg(i)-1;
                    %count=count+1;
                end
                j=j-1;
            end
            %new addition, wednesday
            adj(i,:)=0;
            adj(:,i)=0;
            deg(i)=0;
        end
        %[sum(sum(adj)) count sum(deg) u i]
    end
    
    %changing sampling set structure
    Sfinal=[];
    for i=1:length(S)
        if(S(i)==1)
            Sfinal=[Sfinal i];
        end
    end
end