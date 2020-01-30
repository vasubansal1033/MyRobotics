function draw = drawObstacles(obstacle)
figure(1);
draw = [];
% The sphere function generates the x-, y-, and z- coordinates of a unit sphere for use with surf and mesh.
% sphere generates a sphere consisting of 20-by-20 faces.
% Reference - https://in.mathworks.com/help/matlab/ref/sphere.html

for i=1:obstacle.num
    if obstacle.type(i)==0 % If the obstacle is sphere
        [x,y,z] = sphere; 
        
        x = x*obstacle.l(i);
        y = y*obstacle.l(i);
        z = z*obstacle.l(i);
        
        % surf command is used to plot in 3D
        hs=surf(x+obstacle.cx(i),y+obstacle.cy(i),z+obstacle.cz(i)); 
        hold on;
        color = [rand rand rand];
        set(hs,'FaceColor',color,'FaceAlpha',0.5,'EdgeColor','none');
        daspect([1 1 1]);
        axis([-20 20 -20 20 -20 20]);
        
    elseif (obstacle.type(i)==1) % If the obstacle to be drawn is Cuboid
        % This portion is already explained in DrawCuboid.m
        SL = [obstacle.l(i); obstacle.w(i); obstacle.h(i)];
        CV = [obstacle.cx(i); obstacle.cy(i); obstacle.cz(i)];
        color = [rand rand rand];
        alph = 0.5;
        x = 0.5*SL(1)*[-1 1 1 -1 -1 1 1 -1]';
        y = 0.5*SL(2)*[1 1 1 1 -1 -1 -1 -1]';
        z = 0.5*SL(3)*[-1 -1 1 1 1 1 -1 -1]';
        facs = [1 2 3 4
                5 6 7 8
                4 3 6 5
                3 2 7 6
                2 1 8 7
                1 4 5 8];
        verts = zeros(3,8);
        for j = 1:8
            verts(1:3,j) = [x(j);y(j);z(j)]+CV;
        end
        patch('Faces',facs,'Vertices',verts','FaceColor',color,'FaceAlpha',alph);
        hold on;
    end
    draw= [draw, color'];
end
xlabel('X')
ylabel('Y')
zlabel('Z')
end
      
            