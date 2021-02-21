%Iterative weighting reconstruction
function f1=iwr(G,S,localset,f,w,iter)
    eigen=G.U;
    eigen=eigen.';
    eigenv=G.e;
    f1=zeros(G.N,1);
    f2=zeros(G.N,1);
    f3=zeros(G.N,1);

    gam=sqrt(w);
    num=zeros(G.N,1);
    i=1;
    
    while(i<=G.N) %find total number of nodes in each local set
        num(i)=sum(localset(i,:));
        i=i+1;
    end
    %sampling operation:
    i=1;
    while(i<=length(S))
        f1(S(i))=num(S(i))*f(S(i));
        f2(S(i))=f(S(i));
        i=i+1;
    end

    f1=pwproject(G,f1,w);
    f1=f1/(1+gam*gam);
    
    error1=[];
    error2=[];
    error3=[];
    while(iter)
        i=1;
        f3(S)=f2(S)-f1(S);
        f3(S)=num(S).*f3(S);
        f3=pwproject(G,f3,w);
        f3=f3/(1+gam*gam);
        f1=f1+f3;
        iter=iter-1;
        % error1=[error1 sum(f1)];
        % error2=[error2 sum(f2)];
        % error3=[error3 sum(f1-f2)];
    end 
    % plot(error1);
    % hold on;
    % plot(error2, 'k');
    % hold on;
    % plot(error3, 'r');
end