% clear all MATLAB variables, command windows, and figure
clear; clc; close all;

% spatial discretization
nx=100; x=linspace(0,10,nx)'; h=x(2)-x(1);
dt=0.4*h^2; alpha=dt/h^2; 
T=10000; max_it=T/dt;

% set the parameters which govern equation
Du=1 ; k2=11 ; Dv=0.06 ; k1=11;  % params (0.06/11)
u_bar = 1 + 0.04*(k2^2) ; v_bar = k2/5 ;  % steady state

u=u_bar + 0.01*(rand(nx,1)-0.5) ;
nu=0*x;
v=v_bar + 0.01*(rand(nx,1)-0.5) ;
nv=0*x;

A=zeros(nx);
for ix=1:nx
    A(ix,ix)=-2*alpha;
    if ix > 1
        A(ix-1,ix)=alpha;
    end
    if ix < nx
        A(ix+1,ix)=alpha;
    end
end

% Periodic boundary condition
A(nx,1)=A(2,1);
A(1,nx)=A(nx-1,nx);

% explicit scheme
for it=1:max_it
    
    ix=1:nx;
    nu(ix) = Du*A*u(ix)+u(ix) + dt*k1*(v(ix)-(u(ix).*v(ix))./(1+v(ix).^2));
    nv(ix) = Dv*A*v(ix)+v(ix) + dt*(k2-v(ix)-4*(u(ix).*v(ix))./(1+v(ix).^2));
    
    u=nu;
    v=nv;
    
    t=dt*it;

    if mod(it,100)==0
        clf;
        plot(x,u,'m');
        hold on;
        plot(x,v,'k');
        drawnow;
        
    end
end