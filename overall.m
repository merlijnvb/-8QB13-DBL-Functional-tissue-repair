%[v_f,m_f] = biochemical_essay(0.4,10.73);%solvent in ml, sample_mass in mg(, tissue_vol in ml)
%[E_comp, v_m] = stress_strain_test('data/Test Run 3 synthetisch 70 graden.txt',1*10^-2,0.9*10^-2,1*10^-3);

%   [1]         [2]             [3]     [4]        [5]
%file_name, angle (degrees), width_0, width_1, thickness
data = ["data/Test Run 1 synthetisch niks.txt",       0, 9.15,  9.14,  1.17;
        "data/Test Run 2 - 9 rechte fibers.txt",      0, 9.95,  9.91,  1.57;
        "data/Test Run 3 synthetisch 70 graden.txt", 70, 9.61,  9.60,  1.5;
        "data/Test Run 4 - 10 dubbele fibers.txt",    0, 9.95,  9.91,  1.57;
        "data/Test Run 7 1 vezel.txt",                0, 0.065, 0.064, 0.065;
        "data/Test Run 8 verticaal 1.txt",            0, 0.95,  0.48,  0.22;
        "data/Test Run 9 45 graden 1.txt",           45, 3.3,   1.64,  0.9;
        "data/Test Run 10 horizontaal 1.txt",        90, 3.14,  3.03,  0.33;
        "data/Test Run 11 verticaal 2.txt",           0, 4.76,  4.53,  0.91;
        "data/Test Run 13 horizontaal 2.txt",        90, 2.24,  2.12,  0.59];

%Effective Modulus with varying angle & volume fraction
% x_vm = 0:0.01:0.5;
% x_angle = 0:1:5;
% 
% for angle = x_angle
%     y = [];
%     for v_m = x_vm
%         y(end+1) = youngsmodulus(angle,10*10^6,350*10^3,v_m);
%     end
%     figure(2), plot(x_vm, y);
%     hold on
% end
% 
% title('Effective Modulus with varying angle & volume fraction');
% xlabel('fiber content, Vf [mg/mg]');
% ylabel('Effective modulus [Mpa]');

%Effective Modulus with varying angle
x_angle = 0:1:90;

for i = 1:1:size(data,1)
    y = [];
    [E_comp, v_m] = stress_strain_test(data(i,1),double(data(i,3)),double(data(i,4)),double(data(i,5)));
    
    for angle = x_angle
        y(end+1) = youngsmodulus(angle, E_comp*(1-v_m), E_comp*v_m, v_m);
    end
    figure(3), plot(x_angle, y);
    hold on
end

title('Effective Modulus with varying angles');
xlabel("Angle 'alpha' [degrees]");
ylabel('Effective modulus [Mpa]');

%Effective Modulus with varying fiber content
% % x_vm = 0:0.01:0.5;
% % 
% % for i = 1:1:size(data,1)
% %     y = [];
% %     [E_comp] = stress_strain_test(data(i,1),double(data(i,3)),double(data(i,4)),double(data(i,5)));
% %     
% %     for vm = x_vm
% %         y(end+1) = youngsmodulus(double(data(i,2)), E_comp*(1-v_m), E_comp*v_m, vm);
% %     end
% % 
% %     figure(4), plot(x_vm, y);
% %     hold on
% % end
% % 
% % title('Effective Modulus with varying angles');
% % xlabel("Angle 'alpha' [degrees]");
% % ylabel('Effective modulus [Mpa]');