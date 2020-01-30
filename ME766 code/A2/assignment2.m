clear;
clc;

% Name - Vasu Bansal Roll No. - 160776 Course - ME766

%--------------------------------------------------------------------------
% Length of links and width of link
l1 = input('Enter the length of link 1: ');
l2 = input('Enter the length of link 2: ');
w = input('Enter the width of links: ');
link1 = polyshape([0,l1,l1,0],[-w/2,-w/2,w/2,w/2]);
link2 = polyshape([l1,l1+l2,l1+l2,l1],[-w/2,-w/2,w/2,w/2]);
%--------------------------------------------------------------------------
% Plot markers at joints and end affector and Plot settings
subplot(1,2,2)
title('Configuration space');
xlim([0 400]);
ylim([0 400]);
% legend('Analytical','Numerical','Location','best');
subplot(1,2,1)
title('Workspace');
xlim([-l1-l2 l1+l2]*1.3);
ylim([-l1-l2 l1+l2]*1.3);
hold on;
points = plot([0,l1,l1+l2],[0,0,0],'o','MarkerFaceColor','black');
links = plot([link1 link2],'FaceColor',[0.1 0.1 0.1]);
axis equal;
%--------------------------------------------------------------------------
% Obstacles for workspace
obstacle1 = polyshape([7,15,15,7],[7,7,12,12]);
obstacle2 = polyshape([7,15,15,7]*-1,[7,7,12,12]*-1);
obstacle2 = rotate(obstacle2, 45,[-2 -2]);
plot(obstacle1,'FaceColor','red');
plot(obstacle2,'FaceColor','blue');
%--------------------------------------------------------------------------
% Plot settings
ax = gca;
set(gca,'xtick',[]);
w_ = waitforbuttonpress;
%--------------------------------------------------------------------------
% Checking collisions
angle_step = 5;
sangle1 = 0; % starting angle of link1
eangle1 = 360; % end angle of link2
sangle2 = 0; % starting angle of link1
eangle2 = 360; % end angle of link2
mult = 2*pi/360;

for theta1 = sangle1:angle_step:eangle1
    for theta2 = sangle2:angle_step:eangle2
        subplot(1,2,1)
        % Deleting to remove the link plot of previous step
        delete(links);
        delete(points);
        % Transformation Matrices
        zero_T_one = [cos(theta1*mult), -sin(theta1*mult), 0, l1*cos(mult*theta1);
                      sin(theta1*mult), cos(theta1*mult), 0, l1*sin(mult*theta1);
                      0, 0, 1, 0;
                      0, 0, 0, 1];
                  
        one_T_two = [cos((theta2-theta1)*mult), -sin((theta2-theta1)*mult), 0, l2*cos((theta2-theta1)*mult);
                     sin((theta2-theta1)*mult), cos((theta2-theta1)*mult), 0, l2*sin((theta2-theta1)*mult);
                     0, 0, 1, 0 ;
                     0, 0, 0, 1 ];
                 
        zero_T_two = zero_T_one*one_T_two;
        % Calculating joint points and end affector points
        X0 = [0;0;0;1];
        X1 = zero_T_one*[0;0;0;1];
        X2 = zero_T_two*[0;0;0;1];
        points = plot([X0(1),X1(1),X2(1)],[X0(2),X1(2),X2(2)],'o','MarkerFaceColor','black','MarkerEdgeColor','black');
        % Plotting rotated links
        link1 = polyshape([0,l1,l1,0],[-w/2,-w/2,w/2,w/2]);
        link1 = rotate(link1,theta1,[0 0]);
        link2 = polyshape([X1(1) X1(1)+l2 X1(1)+l2 X1(1)],[X1(2)-w/2 X1(2)-w/2 X1(2)+w/2 X1(2)+w/2]);
        link2 = rotate(link2,theta2,[X1(1) X1(2)]);
        links = plot([link1 link2],'FaceColor',[0.1 0.1 0.1]);

        % pause to get an animation effect
        pause(0.015)
        % TF stores overlap matrix between the polygons
        polyvec = [link1,link2,obstacle1,obstacle2];
        TF = overlaps(polyvec);
        if(TF(1,3)==1 || TF(2,3)==1)
            subplot(1,2,2)
            hold on
            plot(theta1,theta2,'o','Color','red');
        end
        if(TF(1,4)==1 || TF(2,4)==1)
            subplot(1,2,2)
            hold on
            plot(theta1,theta2,'o','Color','blue');
        end
    end
end


