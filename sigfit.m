

function F = sigfit(x,xdata)

    


F = x(1)/2*(1+erf((xdata-x(2))/(sqrt(2)*x(3))));