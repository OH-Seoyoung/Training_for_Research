x1 = linspace(-1.5,1.5); x2 = linspace(-1,3);

[xx1,xx2] = meshgrid(x1,x2); f = Rosenbrock(xx1,xx2);
levels = 10:10:300;
LW = 'linewidth'; FS = 'fontsize'; MS = 'markersize';
figure, contour(x1,x2,f,levels,LW,1.2), colorbar
%axis([0.5 1.5 1 2.5]), axis square, hold on
axis([-1.5 1.5 -1 3]), axis square, hold on


itr = 5000;

theta = zeros(itr,2);
theta(1,:) = [-1.3 0.9];
h=0.01;
for i = 2:itr
    [derivX1, derivX2] = RosenbrockDeriv(theta(i-1,1),theta(i-1,2));
    scale = sqrt(derivX1^2+derivX2^2);
    derivX1=derivX1/scale;
    derivX2=derivX2/scale;
    theta(i,1) = theta(i-1,1)-h*derivX1;
    theta(i,2) = theta(i-1,2)-h*derivX2;
end

h=scatter(theta(:,1),theta(:,2));
set(h(1),'MarkerFaceColor','g')
set(h(1),'MarkerEdgeColor','g')
hold on;

plot(theta(:,1),theta(:,2),'g');

figure
surf(x1,x2,f);
hold on;

value = zeros(itr,1);
for i = 1:itr
    value(i)=Rosenbrock(theta(i,1),theta(i,2));
end
h=scatter3(theta(:,1),theta(:,2),value);
set(h(1),'MarkerFaceColor','g')
set(h(1),'MarkerEdgeColor','g')
hold on;

plot3(theta(:,1),theta(:,2),value,'g');