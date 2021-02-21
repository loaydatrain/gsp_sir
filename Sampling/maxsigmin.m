function S=maxsigmin(G,w,M)
    S=[];
    A=full(double(G.A));
    [eigen eigenv]=eig(A);
    eigenv=diag(eigenv);
    %generating Uhat
    cutoff=1;
    while(cutoff<length(eigenv) && eigenv(cutoff)<=w )
        cutoff=cutoff+1;
    end
    eigenhat=eigen(:,(1:cutoff));
    
    
    while(length(S)<M)
        K=min(length(S),cutoff);
        test=[];
        j=1;
        while(j<=G.N)
            %{
            if(ismembertol(j,S))
                j=j+1;
               continue;
            else
            %}
            Shat=[S j];
            asdf=flip(svd(eigenhat((Shat),:)));
            test=[test asdf(1)];
            j=j+1;
        end
        test=test.';
        
        %{
        x=1;
        j=zeros(length(test),2);
        while(x<=length(test))
        j(x,:)=[test(x) x];
        x=x+1;
        end
        test=j;
        %}
        
        [test, i]=sort(test);
        j=1;
        while(ismembertol(i(j),S))
            j=j+1;
        end
        j=i(j);
        
        S=[S j];
        %[size(S) j]
    end
    
    
end