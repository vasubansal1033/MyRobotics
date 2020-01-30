function world = createWorld()
    world.NumObstacles = input('enter number of obstacles');
    for i=1:world.NumObstacles
        % randomly pick radius
        world.type(i) = input('enter 0 for sphere and 1 for cuboid');
        if(world.type(i)==0)
            world.ln(i) = input('enter radius for sphere');
            world.wd(i)=0;
            world.ht(i)=0;
            world.cx(i) = input('enter x-cord for sphere');
            world.cy(i) = input('enter y-cord for sphere');
            world.cz(i) = input('enter z-cord for sphere');
        elseif(world.type(i)==1)
            world.ln(i) = input('enter length for cuboid');
            world.wd(i) = input('enter width for cuboid');
            world.ht(i) = input('enter height for cuboid');
            world.cx(i) = input('enter x-cord for cuboid');
            world.cy(i) = input('enter y-cord for cuboid');
            world.cz(i) = input('enter z-cord for cuboid');
        end
    end
end
        
     