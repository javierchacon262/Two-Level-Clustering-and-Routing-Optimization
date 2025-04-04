% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA116
% Project Title: Implementation of Tabu Search for TSP
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com

function [BestSol, BestCost, it] = ts(x, y)

%% Problem Definition

model = CreateModel(x, y);                    % Create TSP Model

CostFunction=@(tour) TourLength(tour, model); % Cost Function

ActionList=CreatePermActionList(model.n);     % Action List

nAction=numel(ActionList);                    % Number of Actions


%% Tabu Search Parameters

MaxIt=50;                                     % Maximum Number of Iterations

TL=round(0.5*nAction);                        % Tabu Length


%% Initialization

% Create Empty Individual Structure
empty_individual.Position=[];
empty_individual.Cost=[];

% Create Initial Solution
sol=empty_individual;
sol.Position=randperm(model.n);
sol.Cost=CostFunction(sol.Position);

% Initialize Best Solution Ever Found
BestSol=sol;

% Array to Hold Best Costs
BestCost=zeros(MaxIt,1);

% Initialize Action Tabu Counters
TC=zeros(nAction,1);


%% Tabu Search Main Loop

for it=1:MaxIt
    
    bestnewsol.Cost=inf;
    
    % Apply Actions
    for i=1:nAction
        if TC(i)==0
            newsol.Position=DoAction(sol.Position,ActionList{i});
            newsol.Cost=CostFunction(newsol.Position);
            newsol.ActionIndex=i;

            if newsol.Cost<=bestnewsol.Cost
                bestnewsol=newsol;
            end
        end
    end
    
    % Update Current Solution
    sol=bestnewsol;
    
    % Update Tabu List
    for i=1:nAction
        if i==bestnewsol.ActionIndex
            TC(i)=TL;               % Add To Tabu List
        else
            TC(i)=max(TC(i)-1,0);   % Reduce Tabu Counter
        end
    end
    
    % Update Best Solution Ever Found
    if sol.Cost<=BestSol.Cost
        BestSol=sol;
    end
    
    % Save Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % If Global Minimum is Reached
    if BestCost(it)==0
        break;
    end
    
end

BestCost=BestCost(1:it);

