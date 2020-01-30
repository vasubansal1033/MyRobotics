%%-----------------------------------------------------------%%
%                             ME766A
%                          Assignment 2
%         C-space of 2 arm manipilator with 3 degree of freedom
% 
% Name     : PRAKHAR SAXENA
% Roll no. : 160494
% Date     : 16.10.2019
%----------------------------------------------------------%%

l1 = input('enter length of link1\n'); % lenght of arms of two link manipulator
l2 = input('enter length of link2\n');

origin = [0,0,0];

%function for creating workspace input: no. of obstacles and their specs
world = createWorld();
% figure(1);
% hold on;
colr= plotWorld(world);%plotting workspace

%t1, t2, t3: angle for three degree of freedom
t1 = 0;
t2 = 0;
t3 = 0;

%DH table parameter for system: a,alpha,d
a = [0 0 l1];
alpha = [0 -90 0];
d = [0 0 0];

%c-space figure specs.
figure(2);
daspect([1 1 1]);
axis([0 360 0 360 0 360]);

for i = 0:20:360
    t1 = i*pi/180;
    for j = 0:20:360
        t2 = j*pi/360;
        for k = 0:20:360
            t3 = k*pi/360;
            theta = [t1 t2 t3];
            %constructing 3 DH tables for 3 frames
            for m = 1:3
                T(:,:,m) = [cos(theta(m)), -sin(theta(m)), 0, a(m);
                        sin(theta(m))*cos(alpha(m)), cos(theta(m))*cos(alpha(m)), -sin(alpha(m)), -sin(alpha(m))*d(m);
                        sin(theta(m))*sin(alpha(m)), cos(theta(m))*cos(alpha(m)), -cos(alpha(m)), -cos(alpha(m))*d(m);
                        0, 0, 0, 1];
            end
            %transformation mat. for frame 0 to 2
            T01 = T(:,:,1)*T(:,:,2);
            %transformation mat. for frame 0 to 3
            T02 = T(:,:,1)*T(:,:,2)*T(:,:,3);
            L1 = linspace(0,l1,20);
            L2 = linspace(0,l2,20);
            %finding cord. for manipulator links in fizxed frame
            for n = 1:20
                X1(:,n) = T01*[L1(n) 0 0 1]';
                X2(:,n) = T02*[L2(n) 0 0 1]';
            end
            [aa,b,c,p,q]=plotarm(X1,X2);
            pause(0.00000001);
            delete(aa);delete(b);delete(c);delete(p);delete(q);
%             hold on;
            % checking if any arm is in collision with obstacle
            y = checkCollision(X1, X2, world);
            plotcspace(i,j,k,y,colr)
            
%             pause(0.000001);
            grid on;
%             break;
        end
%         break;
    end
%     break;
end
xlabel('X');
ylabel('Y');
zlabel('Z');