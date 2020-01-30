clc;
clear

% Load image
workspace = imread('workspace_2.png');
workspace = im2bw(workspace,127/255);
imshow(workspace);

% Starting and end points
startX = 30;
startY = 30;
goalX = 40;
goalY = 40;
numIterations = 1000;

openNodes = {};
closedNodes = {}
for i = [0:numIterations]
  
    x = 1500*rand;
    y = 1500*rand;
    
    
    
    
end
