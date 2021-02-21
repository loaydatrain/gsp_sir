%iterative least squares reconstruction
function f1=ilsr(G,S,f,w,iter)
    eigen=G.U;
    eigen=eigen.';
    eigenv=G.e;
    f1=zeros(G.N,1);
    f2=zeros(G.N,1);
    f3=zeros(G.N,1);
    
    Stemp=zeros(G.N,1);
    Stemp(S)=1;
    S=Stemp;
    
    %sampling operation:
    i=1;
    while(i<=G.N)
        if(S(i)==1)
            f1(i)=f(i);
            f2(i)=f(i);
        end
        i=i+1;
    end

    f1=pwproject(G,f1,w);
    
    while(iter)
        i=1;
        while(i<=G.N)
            if(S(i)==1)
                f3(i)=f2(i)-f1(i);
            end
            i=i+1;
        end
        f3=pwproject(G,f3,w);
        
        f1=f1+f3;
        
        iter=iter-1;
    end
    
end