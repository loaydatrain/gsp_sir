function S=maxvolume(G,w,M)
    S=[];
    Shat=1;
    eigen=G.U;
    eigen=eigen.';
    eigenv=G.e;
    
    %generating Uhat
    cutoff=1;
    while(eigenv(cutoff)<=w)
        cutoff=cutoff+1;
    end
    eigenhat=eigen((1:cutoff),:);
    
    while(length(S)<M)
        K=min(length(S),cutoff);
        test=realmax*ones(G.N,1);
        j=1;
        while(j<=G.N)
            if(ismembertol(j,S))
                j=j+1;
               continue;
            else
                Shat=[S j];
                asdf=eigenhat( :,(Shat) );
                asdf= asdf'*asdf;
                asdf=eig(asdf);
                argm=prod(asdf(1:K));

                test(j)=argm;
                j=j+1;
            end
        end
        %test=test.';
        
        [test, i]=sort(test);
        S=[S i(1)];
        continue;
        %{
        x=1;
        j=zeros(length(test),2);
        while(x<=length(test))
        j(x,:)=[test(x) x];
        x=x+1;
        end
        test=j;
        
        
        [test, i]=sort(test);
        j=1;
        while(ismembertol(i(j),S))
            j=randi(G.N);
        end
        j=i(j);
        
        S=[S j];
        [size(S) j];
        %}
    end
    
end