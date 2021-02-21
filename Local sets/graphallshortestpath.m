%this is to make the localset
function localset = graphallshortestpath(G,S)
    distance=graphallshortestpaths(G.A);
    distance(S,:)=0; %set all rows from smapling set = 0
    
    %make notS
    Stemp=zeros(G.N,1);
    Stemp(S)=1;
    Stemp=~Stemp;
    i=1;
    notS=[];
    while(i<=length(Stemp))
        if(Stemp(i)==1)
            notS=[notS i];
        end
        i=i+1;
    end
    
    %dist(:,notS)=0;
    %[mindists relevant]=(min(dist(notS,S).'));
    %[mindists.' relevant.']
    
    mindist=1/0;
    index=0;
    localset=zeros(G.N,G.N);
    for i=1:G.N %i is the non sampled point for which we're finding which localset it belongs to
        mindist=1/0;
        index=0;
        if(ismember(i,notS))
            for k=1:length(S)
                j=S(k); %j is the sampled point
                if(distance(i,j)==0)
                    disp("outlier, waow")
                    continue;
                else
                    if(distance(i,j)<mindist)
                        mindist=distance(i,j);
                        index=j; %i belongs to index's localset
                    end
                end
            end
            localset(index,i)=1;
        else
            continue;
        end
    end
    
    for i=1:length(S)
        i=S(i);
        localset(i,i)=1;
    end

end
