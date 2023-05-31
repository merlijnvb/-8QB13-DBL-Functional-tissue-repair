[v_f,m_f] = biochemical_essay(0.4,10.73);%solvent in ml, sample_mass in mg(, tissue_vol in ml)

%   [1]         [2]             [3]     [4]        [5]
%file_name, angle (degrees), width_0 (mm), width_1(mm), thickness
data = ["data/Test Run 1 synthetisch niks.txt",       0, 9.15,  9.14,  1.17;    %run 1
        "data/Test Run 2 - 9 rechte fibers.txt",      0, 9.28,  9.23,  1.57;    %run 2
        "data/Test Run 3 synthetisch 70 graden.txt", 70, 9.61,  9.60,  1.5;     %run 3
        "data/Test Run 4 - 10 dubbele fibers.txt",    0, 9.95,  9.91,  1.57;    %run 4
        %"data/Test Run 5 1 vezel.txt",                0, 0.065, 0.064, 0.065;   %run 5 (verneukt elke grafiek)
        "data/Test Run 6 verticaal 1.txt",           90, 0.95,  0.91,  0.22;    %run 5 
        "data/Test Run 7 - 45 graden 1.txt",         45, 3.3,   3.16,  0.9;     %run 6
        "data/Test Run 8 horizontaal 1.txt",          0, 3.14,  3.03,  0.33;    %run 7 %% raar result bij varying f-content
        "data/Test Run 9 verticaal 2.txt",           90, 4.76,  4.53,  0.91;    %run 8
        "data/Test Run 10 horizontaal 2.txt",         0, 2.24,  2.12,  0.59];   %run 9 %% raar result bij varying f-content

plot_inf = ["synth no f","--";
            "synth 9 f","--";
            "synth f 70deg","--";
            "synth 2x10f","--";
            "pleura 90deg","-";
            "pleura 45deg","-";
            "pleura 0deg","-";
            "pleura 90deg t2","-";
            "pleura 0deg t2","-"];
        
%Effective Modulus with varying angle & volume fraction for specific data
%run
data_run = 4;           %Changable var
x_vm = 0:0.01:0.5;      %Changable var
x_angle = 0:1:5;        %Changable var
%changable var --> change with x_angle
lines = ["0 deg","1 deg","2 deg","3 deg","4 deg", "5 deg"];

[E_comp,vm] = stress_strain_test(data(data_run,1),double(data(data_run,3)),double(data(data_run,4)),double(data(data_run,5)));

E_f = E_comp*(1-vm);
E_m = E_comp*vm;

for angle = x_angle
    y = [];
    for v_m = x_vm
        y(end+1) = youngsmodulus(angle, E_f, E_m, v_m);
    end
    figure(2), plot(x_vm, y);
    hold on
end

title('Effective Modulus with varying angle & fiber content');
xlabel('fiber content, Vf [mg/mg]');
ylabel('Effective modulus [MPa]');
legend(lines);
saveas(gcf,'Effective Modulus with varying angle & fiber content.png');



%Effective Modulus with varying angle
data_set_angle = [1,2,4,5,6,7]; %Changable var --> select which data sets you want to use from data directory
x_angle = 0:1:90;               %Changable var

for i = data_set_angle %Changable var (set i to 1 or multiple data runs)
    y = [];
    [E_comp, v_m] = stress_strain_test(data(i,1),double(data(i,3)),double(data(i,4)),double(data(i,5)));
    
    for angle = x_angle
        y(end+1) = youngsmodulus(angle, E_comp*(1-v_m), E_comp*v_m, v_m);
    end
    figure(3), plot(x_angle, y, plot_inf(i,2));
    hold on
end

title('Effective Modulus with varying angles');
xlabel("Angle 'alpha' [degrees]");
ylabel('Effective modulus [MPa]');
legend(plot_inf(data_set_angle,1));
saveas(gcf,'Effective Modulus with varying angle.png');



%Effective Modulus with varying fiber content
data_set_fiber = [1,2,4,5,6,7]; %Changable var --> select which data sets you want to use from data directory
x_vm = 0:0.01:0.5;              %Changable var --> define on which range you want v_m to iterate

for i = data_set_fiber %Changable var (set i to 1 or multiple data runs)
    y = [];
    [E_comp] = stress_strain_test(data(i,1),double(data(i,3)),double(data(i,4)),double(data(i,5)));
    
    for vm = x_vm
        y(end+1) = youngsmodulus(double(data(i,2)), E_comp*(1-v_m), E_comp*v_m, vm);
    end

    figure(4), plot(x_vm, y, plot_inf(i,2));
    hold on
end

title('Effective Modulus with varying fiber content');
xlabel("fiber content, Vf [mg/mg]");
ylabel('Effective modulus [MPa]');
legend(plot_inf(data_set_fiber,1));
saveas(gcf,'Effective Modulus with varying fiber content.png');