function [y,i] = checkCollision(X1, X2, world)
len = length(X1);
y=0;
for i=1:world.NumObstacles
    if(y~=0)
        break;
    end
    for j = 1:len
        if world.type(i)==0
            dis1 = sqrt((X1(1,j)-world.cx(i))^2+(X1(2,j)-world.cy(i))^2+(X1(3,j)-world.cz(i))^2);
            dis2 = sqrt((X2(1,j)-world.cx(i))^2+(X2(2,j)-world.cy(i))^2+(X2(3,j)-world.cz(i))^2);
            if((dis1<=world.ln(i)) || (dis2<=world.ln(i)))
                y=i;
                break;
            end
        end
        if world.type(i)==1
            dis1(1) = abs(X1(1,j)-world.cx(i));
            dis1(2) = abs(X1(2,j)-world.cy(i));
            dis1(3) = abs(X1(3,j)-world.cz(i));
            dis2(1) = abs(X2(1,j)-world.cx(i));
            dis2(2) = abs(X2(2,j)-world.cy(i));
            dis2(3) = abs(X2(3,j)-world.cz(i));
            if(((dis1(1)<=world.ln(i)/2) && (dis1(2)<=world.wd(i)/2) && (dis1(3)<=world.ht(i)/2)) || ((dis2(1)<=world.ln(i)/2) &&(dis2(2)<=world.wd(i)/2) && (dis2(3)<=world.ht(i)/2)))
                y=i;
                break;
            end
        end
    end
end
end