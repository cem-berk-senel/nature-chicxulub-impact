function vd = depocean(eb1,eb2,ustar,dp)
    eps0=3; rhop = 2700;
    kappa = 0.4; Tair=293;
    zr = 2; z0 = 0.001; g = 9.81; 
    mu = 1.81e-5; nu = 1.48e-5;
    lambda = 0.0651e-6; xk=1.381e-23;
    cc = 1 + (2*lambda./dp);
    vg=(dp.^2.)*(g*rhop/(18.*mu)).*cc;
    r_a = log(zr/z0)/(kappa*ustar);
    stokes = ((ustar^2)*vg)/nu;
    br = cc.*xk*Tair./(3*pi*mu*dp);
    schmidt = nu./br;
    eb = eb1*(abs(schmidt)).^eb2;
    eim = (stokes.^2)./((400+stokes).^2);
    ein = 0;    
    r_s = 1./(eps0 * ustar * (eb + eim + ein)); 
    vd = vg + 1./(r_a + r_s + r_a.*r_s.*vg);
end