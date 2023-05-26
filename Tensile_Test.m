%[tensile_strain_y,tensile_stress, time, E_eff, tensile_strain_x] = Tensile_Testt('...', 1, 5, 0.1); %width & length in cm
%alles(2);

% figure(1), plot(tensile_strain_y, tensile_stress);
% title("Stress-Strain curve pleura tissue (angle...)");
% xlabel("Strain");
% ylabel("Stress (MPa)");

% figure(2),
% plot(tensile_strain_x, tensile_stress);
% title("stress (y-direction) against strain (x-direction)");
% xlabel("Strain");
% ylabel("Stress");

%per angle per v_f for plastic example
y = [];
x = 0:1:90;

for angle = x
    for v_f = 0.3
        res = sum(result(angle,10,0.2,v_f),2);
        y(end+1) = res(1);
    end
end

figure(2), plot(x, y)

%per volume fraction
%[E_fiber_null, crossling_content] = Biochemical_essay('...')


function [E_fiber_null, crossling_content] = Biochemical_essay(file_name)
    file_data = importdata(file_name);
    concentration = file_data.data(:,1);

    %formulas to calculate volume fractions
    
    %E_fiber_null = ...
    %crossling_content = ...
end

function [tensile_strain_y,tensile_stress, time, E_eff, tensile_strain_x] = Tensile_Testt(file_name, width, length, thickness)
    file_data = importdata(file_name);
    crosshead = file_data.data(:,1)*10^-3; %m
    load = file_data.data(:,2); %N
    time = file_data.data(:,3); %sec
    
    %Tensile strain & strength in y-direction (verticle)
    tensile_stress = (load/(width*length*10^-4))/1000; %F/a --> MPa
    tensile_strain_y = (crosshead-crosshead(1))/crosshead(1); %(L-L_0)/L_0
    E_eff = tensile_stress./tensile_strain_y;
    
    %Tensile strain & strength in x-direction (horizontal)
    volume = thickness*width*length*10^-6;
    delta_x = volume./(crosshead*(width*10^-2)); %??? --> see canvas!
    tensile_strain_x = delta_x/(thickness*10^-2);
end

function E_eff = result(alpha, E_fiber, E_matrix, V_matix)
    alpha = (alpha*pi)/180;
    v_f = 1-V_matix;
    v_m = V_matix;
    
    E_f_convert = [cos(alpha)^4, sin(alpha)^2*cos(alpha)^2, 2*sin(alpha)*cos(alpha)^3;
                   cos(alpha)^2*sin(alpha)^2, sin(alpha)^4, 2*sin(alpha)^3*cos(alpha);
                   cos(alpha)^3*sin(alpha), cos(alpha)*sin(alpha)^3, 2*cos(alpha)^2*sin(alpha)^2];
                         
    E_m_convert = [1/(1-v_m^2), v_m, 0;
                   v_m/(1-v_m^2), 1/(1-v_m^2), 0;
                   0, 0, 1/(2*(1+v_m));];
       
    E_f = E_fiber.*E_f_convert;
    E_m = E_matrix.*E_m_convert;
    
    M_comp = v_f*E_f + (1-v_f)*E_m;
    E_eff = 1./inv(M_comp);
    
    
    
    
%     crosshead_norm = (crosshead-min(crosshead))/(max(crosshead)-min(crosshead))
%     load_norm = (load-min(load))/(max(load)-min(load))
%     
%     Z_score_norm_cross = (crosshead_norm-mean(crosshead_norm)/std(crosshead_norm))
%     Z_score_cross = (crosshead-mean(crosshead)/std(crosshead))
%     
%     Z_score_load = (load-mean(load)/std(load))
%     Z_score_norm_load = (load_norm-mean(load_norm)/std(load_norm))
    
end
