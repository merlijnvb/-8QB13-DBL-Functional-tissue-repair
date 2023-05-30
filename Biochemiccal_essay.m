bio_std = table2array(readtable('Hyp Group 12.xlsx','Range','C25:D31'));
bio_wfsl = table2array(readtable('Hyp Group 12.xlsx','Range','G25:H27'));
bio_std_mean = mean(bio_std,2);
bio_wfsl_mean = mean(bio_wfsl,2);
conc = [0,12.5,25,50,100,200,400];

f_verdun = 4;
sample_m = 10.73*10^-3;


%get data
mdl = fitlm(conc,bio_std_mean);
trend = [mdl.Coefficients.Estimate(2),mdl.Coefficients.Estimate(1)];
R_adj = mdl.Rsquared.Adjusted;

%plot data
figure(1),
plot(conc,bio_std_mean,'black *');
title('Calibration line standards');
xlabel('Concentration Hydroxyproline in standards (μg/ml)');
ylabel('Absorption (nm)');

caption_1 = sprintf('y = %fx + %f', trend(1), trend(2));
caption_2 = sprintf('R^2-adjusted = %f', R_adj);
text(250,0.15,caption_1);
text(250,0.1,caption_2);

hold on
% Plot the least-squares trend line: 
x = [0 max(conc)]; 
plot(x,polyval(trend,x),'red--');
axis([0 max(conc)*1.1 0 max(bio_std_mean)*1.1]);

saveas(gcf,'biochem_essay.png');


%formulate volume fraction
%Gewichtsfractie collageen (w/w%) = (Collageen per mg weefsel / drooggewicht van het weefsel) x 100%
y = bio_wfsl_mean(1) - trend(2);
x = y/trend(1);

x_onverdund = f_verdun * x * 8 * 10^-6; %g collageen per 1 ml
v_f = x_onverdund / sample_m;