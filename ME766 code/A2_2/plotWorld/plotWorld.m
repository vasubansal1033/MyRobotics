function colr = plotWorld(world)

colr=[];
for i=1:world.NumObstacles
    if world.type(i)==0
        [x,y,z] = sphere;
        x = x*world.ln(i);
        y = y*world.ln(i);
        z = z*world.ln(i);
        hs=surf(x+world.cx(i),y+world.cy(i),z+world.cz(i));
        hold on;
        color = [rand rand rand];
        set(hs,'FaceColor',color,'FaceAlpha',0.5,'EdgeColor','none');
        daspect([1 1 1]);
        axis([-20 20 -20 20 -20 20]);
    elseif (world.type(i)==1)
        SL = [world.ln(i); world.wd(i); world.ht(i)];
        CV = [world.cx(i); world.cy(i); world.cz(i)];
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
    colr=[colr,color'];
end
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Workspace of 2-arm Manipulator (3 degree of freedom) with obstacles');
grid on;
end
      
            