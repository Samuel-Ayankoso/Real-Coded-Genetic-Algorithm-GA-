% Real coded Genetic Algorithm Project
% By Samuel Ayankoso
% The American Univeristy in Cairo
% In this project, real-coded GA was used in solving a simple optimization
% problem with 3 variables

clc;clear;close all;
n_variables=3;
LB=[0.05 0.25 2];% The lower bound of the chromosomes
UB=[2 1.3 15]; % The upper bound of the chromosomes

generation=500;  % Maximum Number of Iterations
population_size= 50; % Population size

population=zeros(population_size,n_variables); % Initializing the size of the population
temp_population=zeros(population_size,n_variables); % Intializing the size of the temporary population
mu=0.1; % muitation rate

S_population= zeros (population_size,n_variables+1);% Initializing the size of the sorted population using the problem objective function
F= zeros(population_size,1);% initializing the size of the objective function based on the population size
crossover_times=4;% number of crossovers
mutation_times=5; % number of mutations

 for i=1:1:population_size
     for n=1:1:n_variables
     population(i,n)= unifrnd(LB(1,n),UB(1,n));
     end
  F(i)= myobjfunc(population(i,:));
 end
 
% sorting of the population  
 S_population(:,1:n_variables)= population(:,:);
 S_population(:,n_variables+1)=F;
 S_population= sortrows(S_population,n_variables+1);
 
% Generation
for ii=1:1:generation
    k=1;% This is used to initialize the location of the temp_population;
    
%Elitism
temp_population(k,1:n_variables)=S_population(1,1:n_variables);
k=k+1;

% Selection and Crossover
for j=1:1:crossover_times
% parent selection
    y1(j) = geornd(0.1)+1;
    while   y1(j)> population_size
            y1(j) = geornd(0.1)+1;
    end
    y2(j) = geornd(0.1)+1;
    while   y2(j)> population_size
            y2(j) = geornd(0.1)+1;
    end
end
for u=1:1:crossover_times
parent1= S_population(y1(u),1:n_variables);
parent2= S_population(y2(u),1:n_variables);

% arithmetic crossover
[Children]= arithmetic_crossover (parent1, parent2);
temp_population(k,1:n_variables)=Children(1,:);

temp_population(k,1:n_variables)=max(temp_population(k,1:n_variables),LB);
temp_population(k,1:n_variables)=min(temp_population(k,1:n_variables),UB);

k=k+1;
temp_population(k,1:n_variables)=Children(2,:);

temp_population(k,1:n_variables)=max(temp_population(k,1:n_variables),LB);
temp_population(k,1:n_variables)=min(temp_population(k,1:n_variables),UB);

k=k+1;

end
% Mutation
for e=1:1:mutation_times
    parent=S_population(unidrnd(population_size),1:n_variables);
    [child]= gene_mutation (parent,mu,LB,UB);
    
    temp_population(k,1:n_variables)=child;
    temp_population(k,1:n_variables)=max(temp_population(k,1:n_variables),LB);
    temp_population(k,1:n_variables)=min(temp_population(k,1:n_variables),UB);

    k=k+1;
end

% Replication
for k=k:1:population_size
replicated_child=S_population(randi([1 population_size]),1:n_variables);
temp_population(k,1:n_variables)=replicated_child;
k=k+1;
end

% Calculating the temporary population objective function values
for iii=1:1:population_size
F(iii)= myobjfunc(temp_population(iii,:));
end
% sorting for the next generation and selection of the population best  
S_population(:,1:n_variables)= temp_population;
S_population(:,n_variables+1)=F(:,:);
S_population= sortrows(S_population,n_variables+1);
 
Best_F(ii)= S_population(1,n_variables+1);
end
plot(Best_F,'b');
pause(0.1)
xlabel('Generation')
ylabel('Best Value')
grid on
Xmin=S_population(1,1:n_variables)
Fval=Best_F(1,generation)
