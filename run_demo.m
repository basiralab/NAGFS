clc, clear all, close all,
rng default
addpath('src')
addpath('snnf')
addpath('libsvm-3.23')
addpath('libsvm-3.23/matlab')
addpath('circularGraph')



%% Setting graph data simulation parameters
%%

mu1 = 0.9; % Mean value of the first Gaussian distribution
sigma1 = 0.4; % Standard deviation value of the first Gaussian distribution

mu2 = 0.7; % Mean value of the second Gaussian distribution
sigma2 = 0.6; % Standard deviation value of the second Gaussian distribution

Nf = 5; % Number of selected features

fprintf('The number of selected features is automatically set to %d.', Nf)
fprintf('\nTo change it, please set Nf variable inside run_demo.m to a different integer. \n\n');


%% Change 'displayResults' option for visualizing the learned network atlases and top selected features
%%
displayResults = 0; % input 1 if you want to visualize the estimated atlases and selected features at each run of the cross-validation algorithm
fprintf('The option for displaying the estimated atlases and selected features at each run of the cross-validation algorithm is set to %d.', displayResults)
fprintf('\nTo turn it off, please set displayResults variable inside run_demo.m to 0. \n\n');
fprintf('\nNote that displaying the results at each run will slow down the demo. \n\n');

%% Simulate graph data for running the demo
%%

% In this exemple, each class has its own statistical distribution

[data] = simulateData(mu1, sigma1, mu2, sigma2); % data samples drawn from two Gaussian distributions, each corresponding to one class

data_class1 = data.Featurematrix((data.Labels ==1),:); % retrieve samples in class 1
data_class2 = data.Featurematrix((data.Labels ==-1),:);  % retrieve samples in class 2


%%  Initialization
%%

c = cvpartition(size(data.Labels,1),'LeaveOut');
decision_score = zeros(size(data.Labels,1),1); % vector of decision values (indep.of treshold)
[sz1,sz2,sz3] = size(data.X);
ind_Nf = zeros(size(data.Labels,1),Nf); % store the indices of thr top discriminative features
dataFeatures = data.Featurematrix;
test_Labels_vector = zeros(size(data.Labels,1),1); % store ground truth in test order
accuracy = zeros(size(data.Labels,1),1) ; % store accuracy from each test
predicted_Labels = zeros(size(data.Labels,1),1); % vector to store predicted labels 


for m = 1 : c.NumObservations
    
    mm = num2str(m)
    
    % Create training and testing sets
    testIndex = c.test(m);
    trainIndex = c.training(m);
    train_Labels = data.Labels(trainIndex);
    train_data = data.X(trainIndex,:,:);
    test_Label = data.Labels(testIndex);
    test_data = data.X(testIndex,:,:);
    test_Labels_vector(m) = test_Label;
    
    %% NAGFS execution
    
    [Atlas1,Atlas2,topFeaturesind] = NAGFS(train_data,train_Labels,Nf,displayResults); 
    
    %% Extract top Nf discriminative features
    
    train_set = zeros(length(train_Labels),length(dataFeatures));
    train_Nf = zeros(length(train_Labels),Nf);
    
    % Extract the top Nf discriminative training features
    
    for r = 1: (length(train_Labels))
        train_subject = squeeze(train_data(r,:,:));
        train = triu(train_subject);
        train_vect = [];
        
        for i = 1: sz3
            
            for j = (i+1): sz3
                train_vect = [train_vect,train(i,j)]; % Vectorize the upper triangular part of the training matrix
            end
            
        end
        
        train_set(r,:) = train_vect; % Matrix stacking all training subjects
        
        for h = 1: Nf
            l = topFeaturesind(h);
            train_Nf(r,h) = train_set(r,l); % Discriminative training matrix
        end
        
    end
    
    % Extract the same ranked features from the testing network
    
    test = triu(squeeze(test_data),1); % Upper triangular part of test matrix
    test_vect = [];
    for i = 1: sz3
        
        for j = (i+1): sz3
            test_vect = [test_vect,test(i,j)]; % Vectorize the upper triangular part of the test matrix
        end
        
    end
    
    test_Nf = [];
    for j = 1: Nf
        l = topFeaturesind(j);
        test_Nf = [test_Nf,test_vect(l)]; % Discriminative testing vector
    end
    
    
    % Classification using SVM classifier
    
    model = svmtrain(train_Labels,train_Nf); % Training the classifier using the training data
    [predict_Labels, accuracy, decision_values] = svmpredict(test_Label,test_Nf,model); % Testing the classfier on the left out data (hidden/test data)
    predicted_Labels(m) = predict_Labels;
    test_Labels_vector(m) = test_Label;
    ind_Nf(m,:) = topFeaturesind;
end
CM = confusionmat(test_Labels_vector,predicted_Labels); % Returns the confusion matrix CM determined by the known and predicted groups, respectively

True_Negative = CM(1,1);
True_Positive = CM(2,2);
False_Negative = CM(2,1);
False_Positive = CM(1,2);
Accuracy = (True_Positive + True_Negative)/(size(data.Labels,1)) * 100;
Sensitivity = (True_Positive)/(True_Positive + False_Negative) * 100;
Specificity = (True_Negative)/(True_Negative + False_Positive) * 100;

%% Display the average circular graph of top Nf discriminative features across all cross-validation runs
%%

[J,H] = scoreFeaturesAcrossRuns(data,ind_Nf,Nf); % Display the circular graph of the top discriminative features
pause(2)
figure
imagesc(H),title('NAGFS most discriminative features across all cross-validation runs','Color','b')  % Display top discriminative features

% plot distribution of each class
figure
h1 = histfit(data_class1(:),10,'normal')
h1(1).FaceColor = [.8 .8 1];
h1(2).Color = [.8 .8 1];
set(h1(1),'FaceAlpha',.25);

hold on
h2 = histfit(data_class2(:),10,'normal')
h2(1).FaceColor = [0.6350 0.0780 0.1840];
h2(2).Color = [0.6350 0.0780 0.1840];
set(h2(1),'FaceAlpha',.25);

title('Class-specific simulated data distribution (2 classes)')
hold off

%% Display final results
%%

fprintf('\n')
disp( '                             Final results using leave-one-out cross-validation                         ');
fprintf('\n')
disp(['****************** Average accuracy = ' num2str(Accuracy) '% ******************']);
fprintf('\n')
disp(['****************** Average sensitivity = ' num2str(Sensitivity) '% ******************']);
fprintf('\n')
disp(['****************** Average Specificity = ' num2str(Specificity) '% ******************']);

