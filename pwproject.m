%paly weiner projection, bandlimiting in a way
function f=pwproject(G,f,w)
    eigen=G.U;
    eigen=eigen.';
    eigenv=G.e;
    %implementing the paley weiner projection operator
    f=eigen*f; %now dealing in the graph domain
    i=1;
    while (i<=G.N)
        if(eigenv(i)>w)
            wi=i; %this is the eigenvector number at which to blimit
            f(i)=0;
        end
        i=i+1;
    end
    f=inv(eigen)*f; %converting back to vertex domain
end


