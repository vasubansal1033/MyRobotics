function flag = isCollision(X1, X2, obstacle)
len = length(X1);
flag=0; % If there is a collision, then flag will be 1 or 2 depending on whether it's a sphere or cuboid
for i=1:obstacle.num
    if(flag~=0) % if flag is not equal to 0
        break;
    end
    for j = 1:len
        if obstacle.type(i)==0 % If the obstacle is a sphere
            dist1 = dista(X1, obstacle);
            dist2 = dista(X2, obstacle);
            if((dist1<=obstacle.l(i)) || (dist2<=obstacle.l(i)))
                flag=i;
                break;
            end
        end
        if obstacle.type(i)==1
            dist1(1) = abs(X1(1,j)-obstacle.cx(i));
            dist1(2) = abs(X1(2,j)-obstacle.cy(i));
            dist1(3) = abs(X1(3,j)-obstacle.cz(i));
            dist2(1) = abs(X2(1,j)-obstacle.cx(i));
            dist2(2) = abs(X2(2,j)-obstacle.cy(i));
            dist2(3) = abs(X2(3,j)-obstacle.cz(i));
            if(((dist1(1)<=obstacle.l(i)/2) && (dist1(2)<=obstacle.w(i)/2) && (dist1(3)<=obstacle.h(i)/2)) || ((dist2(2)<=obstacle.w(i)/2) &&(dist2(1)<=obstacle.l(i)/2) && (dist2(3)<=obstacle.h(i)/2)))
                flag=i;
                break;
            end
        end
    end
end
end

function distance = dista(X, obstacle)
distance = sqrt((X(1,j)-obstacle.cx(i))^2+(X(2,j)-obstacle.cy(i))^2+(X(3,j)-obstacle.cz(i))^2);
end