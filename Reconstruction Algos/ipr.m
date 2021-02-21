%Iterative Propagating Reconstruction
function f1=ipr(G,S,localset,f,w,iter)
    eigen=G.U;
    eigen=eigen.';
    eigenv=G.e;
    f1=zeros(G.N,1);
    f2=zeros(G.N,1);
    f3=zeros(G.N,1);
    f4=zeros(G.N,1);

    S=maxfrobnorm(G,w,30); %change the third parameter to control number of sampeld nodes
    localset=graphallshortestpath(G,S);
    
    Sonehot=zeros(G.N,1);
    Sonehot(S)=1;

    %sampling operation:
    i=1;
    while(i<=length(S)) 
        j=S(i);
        f4=localset(j,:).';
        f4=f4*f(j);
        f1=f1+f4; %"guess"
        f2(j)=f(j); %original sampled signal
        i=i+1;
    end

    f1=pwproject(G,f1,w);
    
    error1=[];
    error2=[];
    error3=[];
    while(iter)
        iter;
        i=1;
        if(f1==f2)
            disp("Exact Recovery")
            break;
        end
        while(i<=length(S))
            j=S(i);
            f3(j)=f2(j)-f1(j);
            f4=localset(j,:).';
            f3=f3 + f4*f3(j);
            i=i+1;
        end
        f3=pwproject(G,f3,w); 
        f1=f1+f3;
        iter=iter-1;
    end 
end

%{

    %sampling operation:
    i=1;
    while(i<=length(S))
        j=S(i);
        f4=localset(i,:).';
        f4=f4*f(i);

        f1=f1+f4; %"guess"
        f2(i)=f(i); %original samoples signal
        i=i+1;
    end

    f1=pwproject(G,f1,w);
    
    
    while(iter)
        i=1;
        while(i<=length(S))
            j=S(i);
            f3(i)=f2(i)-f1(i);

            f4=localset(i,:).';
            f3=f3 + f4*f3(i);
            i=i+1;
        end
        f3=pwproject(G,f3,w); 
        f1=f1+f3;
        iter=iter-1;
    end     
%}