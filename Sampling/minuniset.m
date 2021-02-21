function S=minuniset(G,wc,M)
    S=[];
    Shat=1;
    eigen=G.U;
    eigen=eigen.';
    eigenv=G.e;
    
    eigenk=eigen^5;
    Sc=[1:G.N];
    w=0;
    while(w<=wc && length(S)<M)
        
        %generating Lk Sc
        lksc=eigenk(Sc,Sc);
        [psi, sig]=eig(lksc);
        psi=flip(psi);
        sig=flip(sig);
        sig=diag(sig);
        abs(sig);
        omega=sig(1)^(1/5);
        psi=psi(:,1);
        w=omega;
        [psi, j]=max(psi);
        
        %{
        [test, i]=sort(test);
        i(1)
        j=1;
        while(ismembertol(i(j),S))
            j=randi(G.N);
        end
        j=i(j);
        %}
        
        S=[S j];
        Sc(j)=[];
        
        [size(S) j];
    end
    
end