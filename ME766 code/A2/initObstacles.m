% The function drawObstacles is used to initiate the Obstacles

function obstacle = initObstacles()
    obstacle.num = input('Enter number of obstacles : ');
    for i=1:obstacle.num        
        obstacle.type(i) = input('Enter 0 for sphere, 1 for cuboid : ');
        if(obstacle.type(i)==0) % Incase of sphere, length will be radius
                                % width, and height will be 0
            obstacle.l(i) = input('Enter radius for the sphere : ');
            obstacle.w(i)=0; 
            obstacle.h(i)=0;
            obstacle.cx(i) = input('Enter the x-coordinate of center : ');
            obstacle.cy(i) = input('Enter the y-coordinate of center : ');
            obstacle.cz(i) = input('Enter the z-coordinate of center : ');
        elseif(obstacle.type(i)==1)
            obstacle.l(i) = input('Enter length of cuboid : ');
            obstacle.w(i) = input('Enter width of cuboid : ');
            obstacle.h(i) = input('Enter height of cuboid : ');
            obstacle.cx(i) = input('Enter the x-coordinate of center : ');
            obstacle.cy(i) = input('Enter the y-coordinate of center : ');
            obstacle.cz(i) = input('Enter the z-coordinate of center : ');
        end
    end
end
        
     