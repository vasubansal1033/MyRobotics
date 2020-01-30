function [aa,b,c,p,q]=plotarm(X1,X2)
figure(1);
    x=[];
    y=[];
    z=[];
    x=[x, X1(1,:), X2(1,:)];
    y=[y, X1(2,:), X2(2,:)];
    z=[z, X1(3,:), X2(3,:)];
    p=plot3(x,y,z);
    hold on;
    set(p,'Color','r','LineWidth',0.5);
    x=[X2(1,:)];
    y=[X2(2,:)];
    z=[X2(3,:)];
    q=plot3(x,y,z);
    set(q,'Color','b','LineWidth',0.5);
    aa=plot3(X1(1,1),X1(2,1),X1(3,1),'k','LineWidth',1,'Marker','o','MarkerEdgeColor','k','Markersize',2);
    b=plot3(X2(1,1),X2(2,1),X2(3,1),'k','LineWidth',1,'Marker','o','MarkerEdgeColor','k','Markersize',2);
    c=plot3(X2(1,end),X2(2,end),X2(3,end),'k','LineWidth',1,'Marker','o','MarkerEdgeColor','k','Markersize',2);
    
    
end
    