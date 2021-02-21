%this is to see which sampling strat has the least error
function error = placeholder(w,M)  
    i=5;
    error1=[];
    error2=[];
    error3=[];
    grapherr1=[];
    grapherr2=[];
    grapherr3=[];
    iter=1;
    number_of_graphs=5; %use this to control the # of graphs you average over
    while (iter<=number_of_graphs)
        iter
        G=gsp_random_regular(50,3); %generate a random graph of 50 nodes
        G=gsp_compute_fourier_basis(G);
        [Sonehop localset]=onehop(G); % do NOT use onehop sampling since we cannot control the number of samples

        Sonehop=maxfrobnorm(G,w,30); %third parameter is the number of samples
        localset=graphallshortestpath(G,Sonehop);

        i=0;
        error1=[];
        error2=[];
        error3=[];
        while(i<=50) %i is number of iterations 
            i;
            er_1=0; er_2=0; er_3=0;
            
            for j=[1:100] %to find the average error over all signals
                j;
                %[i j qwer]
                x=makesignal(G,w,1);
                x_ilsr=ilsr(G,Sonehop,x,w,i);
                x_iwr=iwr(G,Sonehop,localset,x,w,i);
                x_ipr=ipr(G,Sonehop,localset,x,w,i);

                er_1=(er_1+sqrt(mean((x_ilsr-x).^2)));
                er_2=(er_2+sqrt(mean((x_iwr-x).^2)));
                er_3=(er_3+sqrt(mean((x_ipr-x).^2)));
            end
            %normalising
            er_1=er_1/100;
            er_2=er_2/100;
            er_3=er_3/100;

            %[length(error1) i]
            error1=[error1 er_1];
            error2=[error2 er_2];
            error3=[error3 er_3];
            i=i+1;
        end
        %   Each grapherr matrix is a (# of graphs)x(# of signals) matrix
        %   Each row contains the outputs of the reconstructions for a single graph
        %   We take the mean along each column to average over multiple graphs
        grapherr1=[grapherr1; error1];
        grapherr2=[grapherr2; error2];
        grapherr3=[grapherr3; error3];
        size(grapherr1);
        iter=iter+1;
    end
    
    ploterr1=mean(grapherr1);
    ploterr2=mean(grapherr2);
    ploterr3=mean(grapherr3);
    % size(ploterr1)
    % size(ploterr2)
    % size(ploterr3)
    
    plot(ploterr1);
    hold on;
    plot(ploterr2,'k');
    hold on;
    plot(ploterr3,'r');
    hold on;
    title('Performance of Reconstruction Algorithms');
    xlabel('Number of iterations');
    ylabel('Reconstruction Error');
    legend('ILSR', 'IWR','IPR');
end

%{
    %this is to generate samplingsets ka photo.
        
    i=5;
    error1=[];
    error2=[];
    error3=[];
    error4=[];
    error5=[];
    error6=[];
    
    while(i<=50)
        %cd /home/loay/Desktop/local_set_matlab/Sampling

        S1=maxfrobnorm(G,w,i);
        S2=minfrobnorm(G,w,i);
        S3=maxvolume(G,w,i);
        S4=maxsigmin(G,w,i);
        S5=randsamp(G,w,i);
        S6=minuniset(G,w,i);
        er_1=0; er_2=0; er_3=0; er_4=0; er_5=0; er_6=0;

        %to find the average error over all signals
        for j=[1:100]
            x=makesignal(G,w,1);
            x_ilsr1=ilsr(G,S1,x,w,M);
            x_ilsr2=ilsr(G,S2,x,w,M);
            x_ilsr3=ilsr(G,S3,x,w,M);
            x_ilsr4=ilsr(G,S4,x,w,M);
            x_ilsr5=ilsr(G,S5,x,w,i);
            x_ilsr6=ilsr(G,S6,x,w,i);
            er_1=(er_1+sqrt(mean((x_ilsr1-x).^2)))/(j+1);
            er_2=(er_2+sqrt(mean((x_ilsr2-x).^2)))/(j+1);
            er_3=(er_3+sqrt(mean((x_ilsr3-x).^2)))/(j+1);
            er_4=(er_4+sqrt(mean((x_ilsr4-x).^2)))/(j+1);
            er_5=(er_5+sqrt(mean((x_ilsr5-x).^2)))/(j+1);
            er_6=(er_6+sqrt(mean((x_ilsr6-x).^2)))/(j+1);
        end
        error1=[error1 er_1];
        error2=[error2 er_2];
        error3=[error3 er_3];
        error4=[error4 er_4];
        error5=[error5 er_5];
        error6=[error6 er_6];
        i=i+1;
        
    end

   
    error=[error1.' error2.' error3.' error4.'];
    %error=db(error);
    plot(error1); %maxfrobnorm
    hold on;
    plot(error2,'k'); %minfrobnorm
    hold on;
    plot(error3,'r'); %maxvolume
    hold on;
    plot(error4,'c'); %maxsigmin
    hold on;
    plot(error5,'m'); %random
    hold on;
    plot(error6,'g'); %minuniset
    title('Performance of sampling sets');
    xlabel('Number of Sampled Points');
    ylabel('Reconstruction Error');
    legend('MaxFrobNorm', 'MinFrobNorm','MaxVolume','MaxSigMin','Random','MinUniSet');
%}