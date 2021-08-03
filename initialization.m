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
% This function randomly initializes the position of search agents in the search space.
function Positions=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % number of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    Positions=rand(SearchAgents_no,dim).*(ub-lb)+lb;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    end
end