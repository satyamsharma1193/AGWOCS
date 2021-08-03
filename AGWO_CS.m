%_____________________________________________________________________________________________ %
%  Augmented Grey Wolf Optimizer-Cuckoo Search Algorithm (AGWO-CS) source codes demo V1.0      %
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
% 
function [Alpha_score,Alpha_pos,Convergence_curve]=AGWO_CS(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

% initialize alpha_pos, beta_pos.
% p=initialization(SearchAgents_no,dim,ub,lb);
Alpha_pos=zeros(1,dim);

Alpha_score=inf; %change this to -inf for maximization problems

Beta_pos=zeros(1,dim);
Beta_score=inf; %change this to -inf for maximization problems

%Initialize the positions of search agents
Positions=initialization(SearchAgents_no,dim,ub,lb);
Positions=sort(Positions);
oldPositions=Positions;
Convergence_curve=zeros(1,Max_iter);

l=0;% Loop counter
% Main loop
while l<Max_iter
    for i=1:size(Positions,1)  
        
       % Return back the search agents that go beyond the boundaries of the search space
%        Flag4ub=Positions(i,:)>ub;
%        Flag4lb=Positions(i,:)<lb;
%        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;               
%         Positions(i,:)=sort(Positions(i,:));
        % Calculate objective function for each search agent
%        [Positions(i,:), fitness(i)]=objf(Positions(i,:)',measuredPos,measuredPos,BlindDeviceID,actualRefLocs,refDeviceID,Range,x);
        fitness(i)=fobj(Positions(i,:));
        % Update Alpha, Beta, and Delta
        if fitness(i)<Alpha_score 
            Alpha_score=fitness(i); % Update alpha
            Alpha_pos=Positions(i,:);
        end
        
        if fitness(i)>Alpha_score && fitness(i)<Beta_score 
            Beta_score=fitness(i); % Update beta
            Beta_pos=Positions(i,:);
            
        end
        
    end
    
    a=2-(cos(rand())*l/Max_iter); % a decreases non-linearly fron 2 to 1.
   
    % Update the Position of search agents including omegas
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
                   
            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1]
            
            A1=2*a*r1-a; % Equation (4)
            C1=2*r2;     % Equation (5)
            
            D_alpha=abs(C1*Alpha_pos(j)-Positions(i,j)); % Equation (6)-part 1
            X1(i,j)=Alpha_pos(j)-A1*D_alpha; % Equation (7)-part 1
                       
            r1=rand();
            r2=rand();
            
            A2=2*a*r1-a; % Equation (4)
            C2=2*r2;     % Equation (5)
            
            D_beta=abs(C2*Beta_pos(j)-Positions(i,j)); % Equation (6)-part 2
            X2(i,j)=Beta_pos(j)-A2*D_beta; % Equation (7)-part 2       
                     
        end
    end
    %% Cuckoo Search integrated here and take control from AGWO
   
    %  the key group members of AGWO are updated by cuckoo search's position updation formula 
    %    
    [~,index]=min(fitness);
    best=Positions(index,:);
    X1=get_cuckoos(X1,best,lb,ub); 
    X2=get_cuckoos(X2,best,lb,ub);
    %% control is sent back to AGWO
    Positions=(X1+X2)/2;% Equation (8)
%     Positions=sort(Positions);
    if Positions(i,j)>ub	
          Positions(i,j)=ub;	
          elseif Positions(i,j)<lb	
          Positions(i,j)=lb;	
    end
                    
    l=l+1;    
    Convergence_curve(l)=Alpha_score;
end

end
