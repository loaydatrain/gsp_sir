function x=makesignal(G,w,const)
    N=G.N;
    U=G.U;
    e=G.e;
    x=[];
    for i=[1:N]
        if (e(i)>=w)
            x=[x 0];
        else
            x=[x const*rand];
        end
    end
    x=x.';
    x=U*x;
end