%To Find Sag
%function to control the flow of program
function calculate_maximum_sag_192064()
    ch = input("Are supports at same level? (true / false) ");
    if ch == true
        calculate_maximum_sag_for_same_level();
    else
        calculate_maximum_sag_for_different_level();
    end
end

%function to calculate maximum sag when supports are at same level
function MSag_even = calculate_maximum_sag_for_same_level()
    w =get_weight_per_unit_length();
    L = get_span_length();
    d = get_conductor_diameter;
    us = get_ultimate_strength();
    sf = get_safety_factor();
    iswind = wind_present();
    wind = get_wind_loading(iswind);
    issnow = snow_present();
    snow = get_snow_loading(issnow);
    Ed = d + 2 * snow;
    Wstress = us / sf;
    Area = pi * (Ed^2) / 4;
    AreaIce = pi * (Ed^2 - d^2);
    Wice = AreaIce * 910;
    Wwind =  Ed * wind;
    Wtension = Wstress * Area;
    disp("weights");
    disp(w);
    disp(Wwind);
    disp(Wice);
    Ew = calculate_effective_weight(Wwind, Wice,w);
    disp(Ew);
    c = Wtension / Ew;
    disp(c);
    MSag_even = (L^2)/(8*c);
    disp(MSag_even);
end
%function to calculate maximum sag when supports are at different level
function  calculate_maximum_sag_for_different_level()
    l = get_span_length();
    tl = get_tower_length();
    tl2 = get_tower_length2();
    h = abs(tl - tl2);
    w = get_weight_per_unit_length();
    us = get_ultimate_strength();
    sf = get_safety_factor();
    t = us/sf;
    x1 = (0.5*l) - (t*h/(w*l));
    x2 = (0.5*l) + (t*h/(w*l));
    c = t / w;
    S1 = w * x1 *x1 / (2*c);
    S2 = w * x2 *x2 / (2*c);
    fprintf("Sag with respect to first tower = %f \n", S1);
    fprintf("Sag with respect to second tower = %f ", S2);
    
end

function W = get_weight_per_unit_length()
    W = input("Enter Weight per unit length of Conductor(kg/m) : ");
end
function L = get_span_length()
   L = input("Enter Span Length(m) : ");
end
function d = get_conductor_diameter()
    d = input("Enter Diameter of conductor(m) : ");
end
function US = get_ultimate_strength()
    US = input("Enter Ultimate Strength/Stress (kg/m^2) : ");
end
function SF = get_safety_factor()
    SF = input ("Enter Safety Factors : ");
end

%unequal supports
function TL = get_tower_length()
    TL = input("Enter Tower length (m) : ");
end
function TL2 = get_tower_length2()
    TL2 = input("Enter 2nd Tower length (m) : ");
end
%wind loading
function iswind = wind_present()
    iswind = input("Is Wind Loading Present (true / false) : ");
    if iswind == true || iswind == false
    else
        disp("Enter Valid input !!!!!");
        wind_present();
    end
end
function Wind = get_wind_loading(wind_present)
    if wind_present == true
        Wind = input("Enter Wind Pressure(kg/m^2) : ");
    else
        Wind = 0;
    end
end
%snow Loading
function issnow = snow_present()
    issnow = input("Is there snow Loading? (true / false) : ");
    if issnow == true || issnow == false
    else
        disp("Enter Valid input !!!!!");
        snow_present();
    end
end    
function Snow = get_snow_loading(issnow)
    if issnow == true
        Snow = input("Enter thickness of ice coating(m) : ");
    else
        Snow = 0;
    end
    
end

function EW = calculate_effective_weight(Wwind, Wice,W)
    EW = sqrt((W + Wice)^2 + (Wwind^2));
end

