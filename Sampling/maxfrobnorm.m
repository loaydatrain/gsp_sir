function S=maxfrobnorm(G,w,M)
    S=[];
    eigen=G.U;
    eigen=eigen.';
    eigenv=G.e;
    
    %generating Uhat
    cutoff=1;
    while(eigenv(cutoff)<=w && cutoff<G.N)
        cutoff=cutoff+1;
    end
    eigenhat=eigen((1:cutoff),:);
   
    asdf=sum(eigenhat.^2);
    [x i]=sort(asdf);
    S=i(1:M);
end