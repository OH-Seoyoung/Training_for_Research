function [ ret ] = Rosenbrock( x1, x2 )
    
    ret = (1-x1).^2+100*(x2-x1.^2).^2;
    
end

