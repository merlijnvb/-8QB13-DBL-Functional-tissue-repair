function E_eff = youngsmodulus(alpha, E_fiber, E_matrix, v_m)
    alpha = (alpha*pi)/180;
    
    E_f_convert = [cos(alpha)^4, sin(alpha)^2*cos(alpha)^2, 2*sin(alpha)*cos(alpha)^3;
                   cos(alpha)^2*sin(alpha)^2, sin(alpha)^4, 2*sin(alpha)^3*cos(alpha);
                   cos(alpha)^3*sin(alpha), cos(alpha)*sin(alpha)^3, 2*cos(alpha)^2*sin(alpha)^2];
                         
    E_m_convert = [1/(1-v_m^2), v_m, 0;
                   v_m/(1-v_m^2), 1/(1-v_m^2), 0;
                   0, 0, 1/(2*(1+v_m));];
       
    E_f = E_fiber.*E_f_convert;
    E_m = E_matrix.*E_m_convert;
    
    M_comp = (1-v_m)*E_f + v_m*E_m;
    M_comp_inv = 1./inv(M_comp);
    
    E_eff = M_comp_inv(1,1);
end
