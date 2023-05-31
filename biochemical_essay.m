function [v_f,m_f] = biochemical_essay(solvent,sample_mass,tissue_vol)%solvent in ml, sample_mass in mg, tissue_vol in ml
    tiss_D = 1.0405125*10^3; %mg/ml
    col_D = 1.35*10^3; %mg/ml
    tiss_vol = sample_mass /tiss_D; %ml


    bio_std = table2array(readtable('Hyp Group 12.xlsx','Range','C25:D31'));
    tiss_mass = table2array(readtable('Hyp Group 12.xlsx','Range','G25:H27'));
    bio_std_mean = mean(bio_std,2);
    tiss_mass_mean = mean(tiss_mass,2);
    conc = [0,12.5,25,50,100,200,400];

    %get data:
    mdl = fitlm(conc,bio_std_mean);
    trend = [mdl.Coefficients.Estimate(2),mdl.Coefficients.Estimate(1)];
    R_adj = mdl.Rsquared.Adjusted;

    %plot data:
    figure(1),
    plot(conc,bio_std_mean,'black *');
    hold on
    
    %add labels and texts:
    title('Calibration line standards');
    xlabel('Concentration Hydroxyproline in standards [μg/ml]');
    ylabel('Absorption [nm]');
    caption_1 = sprintf('y = %fx + %f', trend(1), trend(2));
    caption_2 = sprintf('R^2-adjusted = %f', R_adj);
    text(250,0.15,caption_1);
    text(250,0.1,caption_2);
    
    % Plot the least-squares trend line: 
    x = [0 max(conc)]; 
    plot(x,polyval(trend,x),'red--');
    axis([0 max(conc)*1.1 0 max(bio_std_mean)*1.1]);
    
    %save plot:
    saveas(gcf,'biochem_essay.png');


    %formulate volume and massa fractions:
    %y=ax+b --> x=(y-b)/a
    tiss_mass_hyp = tiss_mass_mean(1) - trend(2);
    conc_hyp = tiss_mass_hyp/trend(1);

    col_mass = conc_hyp * solvent * 8 * 10^-3; %mg collagen
    col_volume = col_mass/col_D; %ml collagen 

    %results:
    m_f = col_mass/sample_mass;
    v_f = col_volume/tiss_vol;
end