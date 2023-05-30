function [E_comp, v_m] = stress_strain_test(file_name, width_0, width_1, thickness)
    file_data = importdata(file_name);
    crosshead = file_data.data(:,1)*10^-3; %m
    load = file_data.data(:,2); %N
    time = file_data.data(:,3); %sec
    
    %Tensile strain & strength in y-direction (verticle)
    tensile_stress = (load/(width_0*thickness))/1000; %F/a --> MPa
    tensile_strain_y = (crosshead-crosshead(1))/crosshead(1); %(L-L_0)/L_0
    E_comp = tensile_stress./tensile_strain_y;
    E_comp = mean(E_comp(isfinite(E_comp)));
    
    tensile_strain_x = (width_1 - width_0)/width_0; %(L-L_0)/L_0
    v_m = -(tensile_strain_x/mean(tensile_strain_y));
    if v_m > 1
        v_m = v_m/10;
    end
end