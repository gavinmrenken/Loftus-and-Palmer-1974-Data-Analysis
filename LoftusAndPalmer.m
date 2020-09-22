clear; 
close all; 


% Experiment 1
experiment1 = readtable('experiment1.xlsx'); 

% 1 - table1
[gVerbs,Verb] = findgroups(experiment1.verbs);
meanEstimates = splitapply(@mean, experiment1.estimates, gVerbs);
table1 = table(Verb, round(meanEstimates,1));
table1.Properties.VariableNames = {'Verb','Mean speed estimate'};
table1 = sortrows(table1, 'Mean speed estimate', "descend");

% 1 - graph 
bar(table1.("Mean speed estimate"));
xlabel('Verb');
ylabel('Mean speed estimate');
title({'SPEED ESTIMATES FOR THE VERBS';'USED IN EXPERIMENT I'});
xticklabels({'smashed' 'collided' 'bumped' 'hit' 'contacted'});
SD = splitapply(@std, experiment1.estimates, gVerbs);
nObservations = splitapply(@length, experiment1.estimates, gVerbs);
SE = SD/sqrt(nObservations); 
SE(:, 2:5) = []; % had to convert the matrix into a 5 by 1 instead of 5 by 5
table_SE = table(Verb, SE); % putting values into a table to see what corresponds to what
hold on; 
e = [0.62826 0.43361 0.55901 0.80306 0.93776];
errorbar([1], [40.5], e(:,1), 'k+'); % errorbar for smashed
errorbar([2], [39.3], e(:,2), 'k+'); % errorbar for collided
errorbar([3], [38.1], e(:,3), 'k+'); % errorbar for bumped
errorbar([4], [34], e(:,4), 'k+'); % errorbar for hit
errorbar([5], [31.8], e(:,5), 'k+'); % errorbar for contacted


% Experiment 2
experiment2 = readtable('experiment2.xlsx');

% 2 - table2
[gResponseByVerbs, Response, Verb] = findgroups(experiment2.response,experiment2.verb);
numVerb = splitapply(@length, experiment2.verb, gResponseByVerbs);
tableEG = table((1:6)', Response, Verb);
table2 = table({'Yes'; 'No'},[numVerb(6); numVerb(3)],[numVerb(5);numVerb(2)],[numVerb(4);numVerb(1)]);
table2.Properties.VariableNames = {'Response', 'Smashed','Hit', 'Control'};

% 2 - table3
[gRVE, Estimate, Response, Verb] = findgroups(experiment2.estimate, experiment2.response, experiment2.verb); %gRVE = response by verb by estimate
nVBE = splitapply(@length,experiment2.verb, gRVE); % nVE = number verb by estimate 
% analysis for hit via brute force indexing 
% hit == yes 
hitY_1 = sum(nVBE(10));
hitY_2 = sum([nVBE(18), nVBE(20)]);
hitY_3 = sum(nVBE(26),nVBE(32));
hitY_4 = sum(nVBE(39)); 
% hit == no
hitN_1 = sum([nVBE(2), nVBE(4), nVBE(7), nVBE(9)]); 
hitN_2 = sum([nVBE(13), nVBE(15), nVBE(16), nVBE(19)]); 
hitN_3 = sum([nVBE(21), nVBE(24), nVBE(28), nVBE(30), nVBE(33)]); 
hitN_4 = sum(nVBE(42)); 
% analysis for smashed
% smashed == yes 
smashY_1 = sum(nVBE(6)); 
smashY_2 = sum(nVBE(12)); 
smashY_3 = sum([nVBE(23), nVBE(27)]); 
smashY_4 = sum([nVBE(36), nVBE(38), nVBE(40), nVBE(41)]); 
% smashed == no 
smashN_1 = sum([nVBE(1), nVBE(3), nVBE(5), nVBE(8)]); 
smashN_2 = sum([nVBE(11), nVBE(14), nVBE(17)]); 
smashN_3 = sum([nVBE(22), nVBE(25), nVBE(29), nVBE(31), nVBE(34)]); 
smashN_4 = sum([nVBE(35), nVBE(37)]);
% calculating totals 
hit_1 = round((hitY_1/(hitY_1 + hitN_1)),2); 
smash_1 = round((smashY_1/(smashY_1 + smashN_1)),2); 
hit_2 = round((hitY_2/(hitY_2 + hitN_2)),2); 
smash_2 = round((smashY_2/(smashY_2 + smashN_2)),2); 
hit_3 = round((hitY_3/(hitY_3 + hitN_3)),2); 
smash_3 = round((smashY_3/(smashY_3 + smashN_3)),2); 
hit_4 = round((hitY_4/(hitY_4 + hitN_4)),2); 
smash_4 = round((smashY_4/(smashY_4 + smashN_4)),2); 
% putting it all into a table 
table3 = table({'Smashed';'Hit'}, [smash_1 ; hit_1], [smash_2 ; hit_2], [smash_3 ; hit_3], [smash_4 ; hit_4]); 
table3.Properties.VariableNames = {'Verb condition', '1-5', '6-10', '11-15', '16-20'};
