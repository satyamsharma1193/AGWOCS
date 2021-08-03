%_____________________________________________________________________________________________ %
%  Augmented Grey Wolf optimizer-Cuckoo Search algorithm (AGWO-CS) source codes demo V1.0      %
%                                                                                              %
%  Author and programmer: Satyam Sharma                                                        %
%                                                                                              %
%         e-Mail: satyamsharma1193@gmail.com                                                   %
%                                                                                              %
%  Main paper: Satyam Sharma, Ridhi Kapoor, Sanjeev Dhiman                                     %
%              A Novel Hybrid Metaheuristic Based on Augmented Grey Wolf Optimizer             %
%              and Cuckoo Search for Global Optimization.                                      %
%              IEEE Xplore,                                                                    %
%              DOI: https://doi.org/10.1109/ICSCCC51823.2021.9478142                           %
%___________________________________________________________________________________________   %
%

clear all 
clc
close all
warning off

SearchAgents_no=30; % Number of search agents

Function_name='F1'; % Name of the test function that can be from F1 to F23 

Max_iteration=500; % Maximum number of iterations

Run_no = 20; 
    
for k =  1 : 1 : Run_no   

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Function_details(Function_name);

[Best_score_CS2,Best_pos_CS2,AGWOCS_cg_curve]=AGWO_CS(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); % Augmented GWO- Cuckoo Search.
BestSolutions1(k) = Best_score_CS2;

    
    Average= mean(BestSolutions1);
    Mean=mean(BestSolutions1);
    StandDP=std(BestSolutions1);
    Med = median(BestSolutions1); 
    [BestValueP I]   = min(BestSolutions1);
    [WorstValueP IM] = max(BestSolutions1);
    

       disp(['Run # ' , num2str(k), ' Best_score_AGWOCS :  ' , num2str( Best_score_CS2)]);      
end


     disp([ 'Best=',num2str( BestValueP)]);
     disp([ 'Worst=',num2str(WorstValueP)]);
     disp([ 'Average=',num2str( Average)]);
     disp([ 'Mean=',num2str( Mean)]);
     disp([ 'Standard Deviation=',num2str( StandDP)]);
     disp([ 'Median=',num2str(Med)]);
     

figure('Position',[300 190 980 490])
%figure('Position',[300 190 500 270])
%Draw search space
subplot(1,2,1);
func_plot(Function_name);
title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])
%colormap parula

%Draw objective space
subplot(1,2,2);
%semilogy(GWO_cg_curve,'Color','r')
hold on

semilogy(AGWOCS_cg_curve,'Color','m')

title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');

axis tight
grid on
box on
%legend('AGWO-CS')
legend({'AGWO-CS'},'FontSize',4,'location','best')
