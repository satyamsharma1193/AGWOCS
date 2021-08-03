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
% lb is the lower bound
% up is the uppper bound
% dim is the number of variables 
function [lb,ub,dim,fobj] = Get_Function_details(F)

    switch F
        case 'F1'
            fobj = @F1;
            lb=-100;
            ub=100;
            dim=30;
    end

end

% F1

function o = F1(x)
o=sum(x.^2);
end

function o=Ufun(x,a,k,m)
o=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
end
