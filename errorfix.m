function error = errorfix(G,x,w)  
    error1=[];
    error3=[];
    error2=[];
    [Sonehop localset]=onehop(G); %DO NOT USE ONEHOP SAMPLING AS YOU CANNOT CONTROL THE NUMVER OF SAMPLES
    Smax=maxfrobnorm(G,w,30); %change third parameter to control the number of sampled nodes
    localsetmax=graphallshortestpath(G,Smax);
    for i=1:200 %number of iterations
        i;
        adsf1=iwr(G,Smax,localsetmax,x,3,i);
        adsf2=ilsr(G,Smax,x,3,i);
        adsf3=ipr(G,Smax,localsetmax,x,3,i);
        er_1=mean(sqrt((adsf1-x).^2));
        er_2=mean(sqrt((adsf2-x).^2));
        er_3=mean(sqrt((adsf3-x).^2));
        error1=[error1 er_1];
        error2=[error2 er_2];
        error3=[error3 er_3];
    end

    plot(error1);
    hold on;
    plot(error2,'k');
    hold on;
    plot(error3,'r');
    hold on;
    title('Performance of Reconstruction Algorithms');
    xlabel('Number of iterations');
    ylabel('Reconstruction Error');
    legend('IWR', 'ILSR','IPR');
    
    %{
    i=5;
    error1=[];
    error2=[];
    error3=[];
    grapherr1=[];
    grapherr2=[];
    grapherr3=[];
    qwer=1;
    while (qwer<=5)
        qwer
        G=gsp_random_regular(50,3);
        G=gsp_compute_fourier_basis(G);
        [Sonehop localset]=onehop(G);
        i=0;
        error1=[];
        error2=[];
        error3=[];
        while(i<=50)
            i
            er_1=0; er_2=0; er_3=0;
            %to find the average error over all signals
            for j=[1:100]
                j
                %[i j qwer]
                x=makesignal(G,w,1);
                x_ilsr=ilsr(G,Sonehop,x,w,i);
                x_iwr=iwr(G,Sonehop,localset,x,w,i);
                x_ipr=ipr(G,Sonehop,localset,x,w,i);

                er_1=(er_1+sqrt(mean((x_ilsr-x).^2)))/(j+1);
                er_2=(er_2+sqrt(mean((x_iwr-x).^2)))/(j+1);
                er_3=(er_3+sqrt(mean((x_ipr-x).^2)))/(j+1);
            end
            %[length(error1) i]
            error1=[error1 er_1];
            error2=[error2 er_2];
            error3=[error3 er_3];
            i=i+1;
        end
        grapherr1=[grapherr1; error1];
        grapherr2=[grapherr2; error2];
        grapherr3=[grapherr3; error3];
        size(grapherr1)
        qwer=qwer+1;
    end
    ploterr1=mean(grapherr1);
    ploterr2=mean(grapherr2);
    ploterr3=mean(grapherr3);
    size(ploterr1)
    size(ploterr2)
    size(ploterr3)
    plot(ploterr1); %maxfrobnorm
    hold on;
    plot(ploterr2,'k'); %minfrobnorm
    hold on;
    plot(ploterr3,'r'); %maxvolume
    hold on;
    title('Performance of Reconstruction Algorithms');
    xlabel('Number of iterations');
    ylabel('Reconstruction Error');
    legend('ILSR', 'IWR','IPR');
    %} 
end