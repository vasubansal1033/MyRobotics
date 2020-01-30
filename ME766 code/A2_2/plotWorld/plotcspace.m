function plotcspace(i,j,k,y,colr)
figure(2);
    if(y==0)
        plot3(i,j,k,'o','color',[1 1 0],'MarkerSize',5);
        hold on;
    else
        plot3(i,j,k,'o','color',colr(:,y)','MarkerSize',5);
        hold on;
    end
    xlabel('theta1')
    ylabel('theta2')
    zlabel('theta3')
    title('C-space of 2-arm Manipulator (3 degree of freedom) with obstacles');
    grid on;
    camlight
end