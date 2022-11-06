
U = 10;
R = 1.8;
L = 0.1;
A = U / R;
tau = L/R;
%didt = U / L;
t = 0:0.0001:0.5;
f1 = A*(1-exp(-t/tau));
N = length(t);
LeV = [];
Imax = [];
%for i=50:50:1000
 for i=100:200:10000  
    di = f1(i);
    Imax = [Imax; di];
    dt = t(i);
    x=t(1:i);
    y=f1(1:i);
    didt = di/dt;
    f2 = didt * x; %funkcja liniowa

    dtdi = 1/didt;
    Le1 = U * dtdi % uproszczone L
    Isr = di/2;
    Le2 = (U - R*Isr)*dtdi % L z uwzglednieniem Ri
   
    fitf = fit(x',y','poly1');

    f3 = fitf(x);
    dtdi2 = x(i)/f3(i);
    Le3 = U * dtdi2
    Le4 = (U - R*Isr)*dtdi2
   
    LeV = [LeV; Le1 Le2 Le3 Le4];
   
    clf;
    figure(1);
    xnew = linspace(min(x),max(x),35);
    ynew = interp1(x, y, xnew);
    plot(xnew,ynew,'ro:');
    hold on;
    plot(x,f2,'--',x,f3','-');
    axis([0 max(x) 0  max(f3')]);
    legend('Location', 'Best');
    %'$\displaystyle\frac{e^2}{2\hbar}$','interpreter','latex'
    leg1 = legend('referencja $\frac{U}{R}(1-e^{-\frac{R}{L}t})$', 'aproksymacja 2p', 
		'regresja liniowa');
    set(leg1,'Interpreter','latex');
   
    xlabel('czas (s)');
    ylabel('prad (A)');
    grid on;
     set(findobj('Type','line'), 'linewidth',2);
      fontSize=12;
      fontSize_osie=12;
      fontName='Times';
      set(findall(gcf,'type','axes'),'fontsize',fontSize_osie,'fontName',fontName);
      set(findall(gcf,'type','text'),'fontSize',fontSize,'fontName',fontName);  
      set(leg1,'FontSize',12)
end