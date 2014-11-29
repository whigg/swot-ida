function MakeFigs (D,Truth,Prior,C,E,Err)

figure(1)
if C.Estimateq,
    n=4;
else
    n=3;
end
subplot(n,1,1); 
plot(C.thetaA0'); grid on;
title('Baseflow cross-sectional area, m^2')
subplot(n,1,2)
plot(C.thetan'); grid on;
title('Roughness coefficient')
subplot(n,1,3)
plot(C.thetac2'); grid on;
title('Dave''s parameter x1: c2')

if C.Estimateq,
    subplot(n,1,4);
    plot(mean(C.thetaq)); grid on;
    title('Average q, m2/s')
end
    
figure(2)
h1=errorbar(D.xkm./1000,E.A0hat,E.stdA0Post,'LineWidth',2,'Color','r'); hold on;
hp=errorbar(D.xkm./1000,Prior.meanA0.*ones(D.nR,1),Prior.stdA0.*ones(D.nR,1),'LineWidth',2,'Color','g');
h2=plot(D.xkm./1000,Truth.A0,'LineWidth',2); hold off;
set(gca,'FontSize',14)
xlabel('Flow distance, km')
ylabel('Cross-sectional area, m^2')
legend([h1; hp; h2;],'Estimate','Prior','True',0)

figure(3)
for i=1:D.nR,
    subplot(1,D.nR,i)
    x=0:max(C.thetaA0(i,:));
    y=normpdf(x,Prior.meanA0(i),Prior.stdA0(i));
    plot(x,y/max(y)*C.N/20,'r--','LineWidth',2); hold on;
    hist(C.thetaA0(i,C.Nburn+1:end),50); 
    set(gca,'FontSize',14)
    plot(Truth.A0(i)*ones(2,1),get(gca,'YLim'),'g-','LineWidth',2);    
    plot(E.A0hat(i)*ones(2,1),get(gca,'YLim'),'k--','LineWidth',2); hold off;    
    title(['Reach ' num2str(i)])
    xlabel('A_0, m^2')
    ylabel('Frequency')
end

figure(4)
for i=1:D.nR,
    subplot(1,D.nR,i)
    x=linspace(0,max(C.thetan(i,:)),100);
    y=normpdf(x,Prior.meann(i),Prior.stdn(i));
    plot(x,y/max(y)*C.N/20,'r--','LineWidth',2); hold on;
    
    hist(C.thetan(i,C.Nburn+1:end),50); 
    plot(Truth.n(i)*ones(2,1),get(gca,'YLim'),'g-','LineWidth',2); 
    set(gca,'FontSize',14)
    plot(E.nhat(i)*ones(2,1),get(gca,'YLim'),'k--','LineWidth',2); hold off;    
    title(['Reach ' num2str(i)])
    xlabel('n, [-]')
    ylabel('Frequency')    
end

Qbar=squeeze(mean(mean(C.thetaQ)));

figure(5)
plot(Qbar,'LineWidth',2); grid on;
set(gca,'FontSize',14)
title('Markov chain on average discharge')
xlabel('Iteration #')
ylabel('Discharge m^3/s')

figure(6)
h=plot(D.t,E.QhatPostf',D.t,Truth.Q,'--','LineWidth',2); 
Co=get(0,'DefaultAxesColorOrder');
for i=1:D.nR,
    set(h(D.nR+i),'Color',Co(i,:));
end
set(gca,'FontSize',14)
if D.t(1)>datenum(1900,0,0,0,0,0);
    datetick
else
    xlabel('Time, days')
end
ylabel('Discharge, m^3/s')

figure(7)
plot(1:D.nR,Err.QRelErrPrior,'s-',1:D.nR,Err.QRelErrPost,'s-','LineWidth',2);
set(gca,'FontSize',14)
xlabel('Reach'); ylabel('Relative error');
legend('Prior','Posterior',0);

figure(8)
plot(Qbar,C.LogLike,'o'); hold on;
a=axis; plot(mean(Truth.Q(1,:))*ones(2,1),a(3:4),'r-','LineWidth',2); hold off
set(gca,'FontSize',14)
xlabel('Average discharge, m^3/s')
ylabel('Log of likelihood')
legend('Markov Chain','Truth',0)

<<<<<<< HEAD
figure(9)
for i=1:D.nR,
    subplot(1,D.nR,i)
%     x=0:max(C.thetac2(i,:));
%     y=normpdf(x,Prior.meanc2(i),Prior.stdc2(i));
%     plot(x,y/max(y)*C.N/20,'r--','LineWidth',2); hold on;
    hist(C.thetac2(i,C.Nburn+1:end),50); 
    set(gca,'FontSize',14)
%     plot(Truth.A0(i)*ones(2,1),get(gca,'YLim'),'g-','LineWidth',2);    
%     plot(E.A0hat(i)*ones(2,1),get(gca,'YLim'),'k--','LineWidth',2); hold off;    
    title(['Reach ' num2str(i)])
    xlabel('c_2')
    ylabel('Frequency')
end
=======

>>>>>>> parent of 438feec... v0: Minor tweaks

return