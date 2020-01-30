x = 1:10;
n = length(x);
avg = mymean(x,n);
% y=input('enter %d time',x(3));

N = 15;
a = 1/8;
XT = randn(1,N)/6;
YT = randn(1,N)/6;
ZT = randn(1,N)/6;
for j=1:N
  % Generate a sphere consisting of 20by 20 faces
  [x,y,z]=sphere;
  % use surf function to plot
  hSurface=surf(a*x+XT(j),a*y+YT(j),a*z+ZT(j));
  hold on
  set(hSurface,'FaceColor',[0 0 1], ...
      'FaceAlpha',0.5,'FaceLighting','gouraud','EdgeColor','none')
  axis([-0.5 0.5 -0.5 0.5 -0.5 0.5]);
  daspect([1 1 1]);
end
hold off
xlabel('X')
ylabel('Y')
zlabel('Z')
camlight


function a = mymean(v,n)
% MYMEAN Example of a local function.

    a = sum(v)/n;
end