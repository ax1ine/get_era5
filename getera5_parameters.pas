unit getera5_parameters;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

//procedure GetParameters(Var par_name, par_tbl:array of string);

implementation

{procedure GetParameters(Var p_n, p_t:array of string);
begin
 SetLength(p_n, 100);
 SetLength(p_t, 100);


 (* Temperature and Pressure *)
 p_n[0]:='2m dewpoint temperature [K]';
 p_t[0]:='2m_dewpoint_temperature';
 p_n[1]:='2m temperature [K]';
 p_t[1]:='2m_temperature';
 p_n[2]:='Ice temperature layer 1 [K]';
 p_t[2]:='ice_temperature_layer_1';
 p_n[3]:='Ice temperature layer 2 [K]';
 p_t[3]:='ice_temperature_layer_2';
 p_n[4]:='Ice temperature layer 3 [K]';
 p_t[4]:='ice_temperature_layer_3';
 p_n[5]:='Ice temperature layer 4 [K]';
 p_t[5]:='ice_temperature_layer_4';
 p_n[6]:='Mean sea level pressure [Pa]';
 p_t[6]:='mean_sea_level_pressure';
 p_n[7]:='Sea surface temperature [K]';
 p_t[7]:='sea_surface_temperature';
 p_n[8]:='Skin temperature [K]';
 p_t[8]:='skin_temperature';
 p_n[9]:='Surface pressure [Pa]';
 p_t[9]:='surface_pressure';


 (* Wind *)
 p_n[10]:='100m u-component of wind [m s-1]';
 p_t[10]:='100m_u_component_of_wind';
 p_n[11]:='100m v-component of wind [m s-1]';
 p_t[11]:='100m_v_component_of_wind';
 p_n[12]:='10m u-component of neutral wind [m s-1]';
 p_t[12]:='10m_u_component_of_neutral_wind';
 p_n[13]:='10m u-component of wind [m s-1]';
 p_t[13]:='10m_u_component_of_wind';
 p_n[14]:='10m v-component of neutral wind [m s-1]';
 p_t[14]:='10m_v_component_of_neutral_wind';
 p_n[15]:='10m v-component of wind [m s-1]';
 p_t[15]:='10m_v_component_of_wind';
 p_n[16]:='10m wind speed [m s-1]';
 p_t[16]:='10m_wind_speed';
 p_n[17]:='Instantaneous 10m wind gust [m s-1]';
 p_t[17]:='instantaneous_10m_wind_gust';

 (* Mean rates *)
 p_n[18]:='Mean boundary layer dissipation [W m-2]';
 p_t[18]:='mean_boundary_layer_dissipation'
 p_n[19]:='Mean convective precipitation rate [kg m-2 s-1]';
 p_t[19]:='mean_convective_precipitation_rate'
 p_n[20]:='Mean convective snowfall rate [kg m-2 s-1]';
 p_t[20]:='mean_convective_snowfall_rate'
 p_n[21]:='Mean eastward gravity wave surface stress [N m-2]';
 p_t[21]:='mean_eastward_gravity_wave_surface_stress'
 p_n[22]:='Mean eastward turbulent surface stress [N m-2]';
 p_t[22]:='mean_eastward_turbulent_surface_stress'
 p_n[23]:='Mean evaporation rate [kg m-2 s-1]';
 p_t[23]:='mean_evaporation_rate'
 p_n[24]:='Mean gravity wave dissipation [W m-2]';
 p_t[24]:='mean_gravity_wave_dissipation'
 p_n[25]:='Mean large-scale precipitation fraction [Proportion]';
 p_t[25]:='mean_large_scale_precipitation_fraction'
 p_n[26]:='Mean large-scale precipitation rate [kg m-2 s-1]';
 p_t[26]:='mean_large_scale_precipitation_rate'
 p_n[27]:='Mean large-scale snowfall rate [kg m-2 s-1]';
 p_t[27]:='mean_large_scale_snowfall_rate'
 p_n[28]:='Mean northward gravity wave surface stress [N m-2]';
 p_t[28]:='mean_northward_gravity_wave_surface_stress'
 p_n[29]:='Mean northward turbulent surface stress [N m-2]';
 p_t[29]:='mean_northward_turbulent_surface_stress'
 p_n[30]:='Mean potential evaporation rate [kg m-2 s-1]';
 p_t[30]:='mean_potential_evaporation_rate'
 p_n[31]:='Mean runoff rate [kg m-2 s-1]';
 p_t[31]:='mean_runoff_rate'
 p_n[32]:='Mean snow evaporation rate [kg m-2 s-1]';
 p_t[32]:='mean_snow_evaporation_rate'
 p_n[33]:='Mean snowfall rate [kg m-2 s-1]';
 p_t[33]:='mean_snowfall_rate'
 p_n[34]:='Mean snowmelt rate [kg m-2 s-1]';
 p_t[34]:='mean_snowmelt_rate'
 p_n[35]:='Mean sub-surface runoff rate [kg m-2 s-1]';
 p_t[35]:='mean_sub_surface_runoff_rate'
 p_n[36]:='Mean surface direct short-wave radiation flux [W m-2]';
 p_t[36]:='mean_surface_direct_short_wave_radiation_flux'
 p_n[37]:='Mean surface direct short-wave radiation flux, clear sky [W m-2]';
 p_t[37]:='mean_surface_direct_short_wave_radiation_flux_clear_sky'
 p_n[38]:='Mean surface downward UV radiation flux [W m-2]';
 p_t[38]:='mean_surface_downward_uv_radiation_flux'
 p_n[39]:='Mean surface downward long-wave radiation flux [W m-2]';
 p_t[39]:='mean_surface_downward_long_wave_radiation_flux';
 p_n[40]:='Mean surface downward long-wave radiation flux, clear sky [W m-2]';
 p_t[40]:='mean_surface_downward_long_wave_radiation_flux_clear_sky';
 p_n[41]:='Mean surface downward short-wave radiation flux [W m-2]';
 p_t[41]:='mean_surface_downward_short_wave_radiation_flux';
 p_n[42]:='Mean surface downward short-wave radiation flux, clear sky [W m-2]';
 p_t[42]:='mean_surface_downward_short_wave_radiation_flux_clear_sky'
 p_n[43]:='Mean surface latent heat flux [W m-2]';
 p_t[43]:='mean_surface_latent_heat_flux'
 p_n[48]:='Mean surface net long-wave radiation flux [W m-2]';
 p_t[44]:='mean_surface_net_long_wave_radiation_flux'
 p_n[49]:='Mean surface net long-wave radiation flux, clear sky [W m-2]';
 p_t[42]:='mean_surface_net_long_wave_radiation_flux_clear_sky'
 p_n[46]:='Mean surface net short-wave radiation flux [W m-2]';
 p_t[42]:='mean_surface_net_short_wave_radiation_flux'
 p_n[47]:='Mean surface net short-wave radiation flux, clear sky [W m-2]';
 p_t[42]:='mean_surface_net_short_wave_radiation_flux_clear_sky'
 p_n[52]:='Mean surface runoff rate [kg m-2 s-1]';
 p_t[52]:='mean_surface_runoff_rate'
 p_n[53]:='Mean surface sensible heat flux [W m-2]';
 p_t[53]:='mean_surface_sensible_heat_flux'
 p_n[54]:='Mean top downward short-wave radiation flux [W m-2]';
 p_t[54]:='mean_top_downward_short_wave_radiation_flux'
 p_n[55]:='Mean top net long-wave radiation flux [W m-2]';
 p_t[55]:='mean_top_net_long_wave_radiation_flux'
 p_n[56]:='Mean top net long-wave radiation flux, clear sky [W m-2]';
 p_t[56]:='mean_top_net_long_wave_radiation_flux_clear_sky'
 p_n[57]:='Mean top net short-wave radiation flux [W m-2]';
 p_t[57]:='mean_top_net_short_wave_radiation_flux'
 p_n[58]:='Mean top net short-wave radiation flux, clear sky [W m-2]';
 p_t[58]:='mean_top_net_short_wave_radiation_flux_clear_sky'
 p_n[59]:='Mean total precipitation rate [kg m-2 s-1]';
 p_t[59]:='mean_total_precipitation_rate'
 p_n[60]:='Mean vertically integrated moisture divergence [kg m-2 s-1]';
 p_t[60]:='mean_vertically_integrated_moisture_divergence'


 (* Radiation and heat *)
 p_n[61]:='Clear-sky direct solar radiation at surface [J m-2]';
 p_n[62]:='Downward UV radiation at the surface [J m-2]';
 p_n[63]:='Forecast logarithm of surface roughness for heat [~]';
 p_n[64]:='Instantaneous surface sensible heat flux [W m-2]';
 p_n[65]:='Near IR albedo for diffuse radiation [(0 - 1]';
 p_n[66]:='Near IR albedo for direct radiation [(0 - 1]';
 p_n[67]:='Surface latent heat flux [J m-2]';
 p_n[68]:='Surface net solar radiation [J m-2]';
 p_n[69]:='Surface net solar radiation, clear sky [J m-2]';
 p_n[70]:='Surface net thermal radiation [J m-2]';
 p_n[71]:='Surface net thermal radiation, clear sky [J m-2]';
 p_n[72]:='Surface sensible heat flux [J m-2]';
 p_n[73]:='Surface solar radiation downward, clear sky [J m-2]';
 p_n[74]:='Surface solar radiation downwards [J m-2]';
 p_n[75]:='Surface thermal radiation downward, clear sky [J m-2]';
 p_n[76]:='Surface thermal radiation downwards [J m-2]';
 p_n[77]:='TOA incident solar radiation [J m-2]';
 p_n[78]:='Top net solar radiation [J m-2]';
 p_n[79]:='Top net solar radiation, clear sky [J m-2]';
 p_n[80]:='Top net thermal radiation [J m-2]';
 p_n[81]:='Top net thermal radiation, clear sky [J m-2]';
 p_n[82]:='Total sky direct solar radiation at surface [J m-2]';
 p_n[83]:='UV visible albedo for diffuse radiation [(0 - 1]';
 p_n[84]:='UV visible albedo for direct radiation [(0 - 1]';

 (* Clouds *)
 p_n[85]:='Cloud base height [m]';
 p_n[86]:='High cloud cover [(0 - 1]';
 p_n[87]:='Low cloud cover [(0 - 1]';
 p_n[88]:='Medium cloud cover [(0 - 1]';
 p_n[89]:='Total cloud cover [(0 - 1]';
 p_n[90]:='Total column cloud ice water [kg m-2]';
 p_n[91]:='Total column cloud liquid water [kg m-2]';
 p_n[92]:='Vertical integral of divergence of cloud frozen water flux [kg m-2 s-1]';
 p_n[93]:='Vertical integral of divergence of cloud liquid water flux [kg m-2 s-1]';
 p_n[94]:='Vertical integral of eastward cloud frozen water flux [kg m-1 s-1]';
 p_n[95]:='Vertical integral of eastward cloud liquid water flux [kg m-1 s-1]';
 p_n[96]:='Vertical integral of northward cloud frozen water flux [kg m-1 s-1]';
 p_n[97]:='Vertical integral of northward cloud liquid water flux [kg m-1 s-1]';


 (* Lakes *)
 p_n[98] :='Lake bottom temperature [K]';
 p_n[99] :='Lake cover [(0 - 1]';
 p_n[100]:='Lake depth [m]';
 p_n[101]:='Lake ice depth [m]';
 p_n[102]:='Lake ice temperature [K]';
 p_n[103]:='Lake mix-layer depth [m]';
 p_n[104]:='Lake mix-layer temperature [K]';
 p_n[105]:='Lake shape factor [dimensionless]';
 p_n[106]:='Lake total layer temperature [K]';

 (* Evaporation and runoff *)
 p_n[107]:='Evaporation [m]';
 p_n[108]:='Potential evaporation [m]';
 p_n[109]:='Runoff [m]';
 p_n[110]:='Sub-surface runoff [m]';
 p_n[111]:='Surface runoff [m]';

(* Precipitation and rain *)
 p_n[112]:='Convective precipitation [m]';
 p_n[113]:='Convective rain rate [kg m-2 s-1]';
 p_n[114]:='Instantaneous large-scale surface precipitation fraction [(0 - 1]';
 p_n[115]:='Large scale rain rate [kg m-2 s-1]';
 p_n[116]:='Large-scale precipitation [m]';
 p_n[117]:='Large-scale precipitation fraction [s]';
 p_n[118]:='Precipitation type [GRIB code table 4.201]';
 p_n[119]:='Total column rain water [kg m-2]';
 p_n[120]:='Total precipitation [m]';


 (* Snow *)
 p_n[121]:='Convective snowfall [m of water equivalent]';
 p_n[122]:='Convective snowfall rate water equivalent [kg m-2 s-1]';
 p_n[123]:='Large scale snowfall rate water equivalent [kg m-2 s-1]';
 p_n[124]:='Large-scale snowfall [m of water equivalent]';
 p_n[125]:='Snow albedo [(0 - 1]';
 p_n[126]:='Snow density [kg m-3]';
 p_n[127]:='Snow depth [m of water equivalent]';
 p_n[128]:='Snow evaporation [m of water equivalent]';
 p_n[129]:='Snowfall [m of water equivalent]';
 p_n[130]:='Snowmelt [m of water equivalent]';
 p_n[131]:='Temperature of snow layer [K]';
 p_n[132]:='Total column snow water [kg m-2]';

 (* Soil *)
 p_n[133]:='Soil temperature level 1 [K]';
 p_n[134]:='Soil temperature level 2 [K]';
 p_n[135]:='Soil temperature level 3 [K]';
 p_n[136]:='Soil temperature level 4 [K]';
 p_n[137]:='Soil type [~]';
 p_n[138]:='Volumetric soil water layer 1 [m3 m-3]';
 p_n[139]:='Volumetric soil water layer 2 [m3 m-3]';
 p_n[140]:='Volumetric soil water layer 3 [m3 m-3]';
 p_n[141]:='Volumetric soil water layer 4 [m3 m-3]';

 (* Vertical integrals *)
 p_n[142]:='Vertical integral of divergence of geopotential flux [W m-2]';
 p_n[143]:='Vertical integral of divergence of kinetic energy flux [W m-2]';
 p_n[144]:='Vertical integral of divergence of mass flux [kg m-2 s-1]';
 p_n[145]:='Vertical integral of divergence of moisture flux [kg m-2 s-1]';
 p_n[146]:='Vertical integral of divergence of ozone flux [kg m-2 s-1]';
 p_n[147]:='Vertical integral of divergence of thermal energy flux [W m-2]';
 p_n[148]:='Vertical integral of divergence of total energy flux [W m-2]';
 p_n[149]:='Vertical integral of eastward geopotential flux [W m-1]';
 p_n[150]:='Vertical integral of eastward heat flux [W m-1]';
 p_n[151]:='Vertical integral of eastward kinetic energy flux [W m-1]';
 p_n[152]:='Vertical integral of eastward mass flux [kg m-1 s-1]';
 p_n[153]:='Vertical integral of eastward ozone flux [kg m-1 s-1]';
 p_n[154]:='Vertical integral of eastward total energy flux [W m-1]';
 p_n[155]:='Vertical integral of eastward water vapour flux [kg m-1 s-1]';
 p_n[156]:='Vertical integral of energy conversion [W m-2]';
 p_n[157]:='Vertical integral of kinetic energy [J m-2]';
 p_n[158]:='Vertical integral of mass of atmosphere [kg m-2]';
 p_n[159]:='Vertical integral of mass tendency [kg m-2 s-1]';
 p_n[160]:='Vertical integral of northward geopotential flux [W m-1]';
 p_n[161]:='Vertical integral of northward heat flux [W m-1]';
 p_n[162]:='Vertical integral of northward kinetic energy flux [W m-1]';
 p_n[163]:='Vertical integral of northward mass flux [kg m-1 s-1]';
 p_n[164]:='Vertical integral of northward ozone flux [kg m-1 s-1]';
 p_n[165]:='Vertical integral of northward total energy flux [W m-1]';
 p_n[166]:='Vertical integral of northward water vapour flux [kg m-1 s-1]';
 p_n[167]:='Vertical integral of potential and internal energy [J m-2]';
 p_n[168]:='Vertical integral of potential, internal and latent energy [J m-2]';
 p_n[169]:='Vertical integral of temperature [K kg m-2]';
 p_n[170]:='Vertical integral of thermal energy [J m-2]';
 p_n[171]:='Vertical integral of total energy [J m-2]';
 p_n[172]:='Vertically integrated moisture divergence [kg m-2]';

(* Vegetation *)
 p_n[173]:='High vegetation cover [(0 - 1]';
 p_n[174]:='Leaf area index, high vegetation [m2 m-2]';
 p_n[175]:='Leaf area index, low vegetation [m2 m-2]';
 p_n[176]:='Low vegetation cover [(0 - 1]';
 p_n[177]:='Type of high vegetation [~]';
 p_n[178]:='Type of low vegetation [~]';

(* Ocean waves *)
 p_n[179]:='Air density over the oceans [kg m-3]';
 p_n[180]:='Coefficient of drag with waves [dimensionless]';
 p_n[181]:='Free convective velocity over the oceans [m s-1]';
 p_n[182]:='Maximum individual wave height [m]';
 p_n[183]:='Mean direction of total swell [degrees]';
 p_n[184]:='Mean direction of wind waves [degrees]';
 p_n[185]:='Mean period of total swell [s]';
 p_n[186]:='Mean period of wind waves [s]';
 p_n[187]:='Mean square slope of waves [dimensionless]';
 p_n[188]:='Mean wave direction [degree true]';
 p_n[189]:='Mean wave direction of first swell partition [degrees]';
 p_n[190]:='Mean wave direction of second swell partition [degrees]';
 p_n[191]:='Mean wave direction of third swell partition [degrees]';
 p_n[192]:='Mean wave period [s]';
 p_n[193]:='Mean wave period based on first moment [s]';
 p_n[194]:='Mean wave period based on first moment for swell [s]';
 p_n[195]:='Mean wave period based on first moment for wind waves [s]';
 p_n[196]:='Mean wave period based on second moment for swell [s]';
 p_n[197]:='Mean wave period based on second moment for wind waves [s]';
 p_n[198]:='Mean wave period of first swell partition [s]';
 p_n[199]:='Mean wave period of second swell partition [s]';
 p_n[200]:='Mean wave period of third swell partition [s]';
 p_n[201]:='Mean zero-crossing wave period [s]';
 p_n[202]:='Model bathymetry [m]';
 p_n[203]:='Normalized energy flux into ocean [dimensionless]';
 p_n[204]:='Normalized energy flux into waves [dimensionless]';
 p_n[205]:='Normalized stress into ocean [dimensionless]';
 p_n[206]:='Ocean surface stress equivalent 10m neutral wind direction
 p_n[207]:=/Ocean surface stress equivalent 10m neutral wind speed
 p_n[208]:='Peak wave period [s]';
 p_n[209]:='Period corresponding to maximum individual wave height [s]';
 p_n[210]:='Significant height of combined wind waves and swell [m]';
 p_n[211]:='Significant height of total swell [m]';
 p_n[212]:='Significant height of wind waves [m]';
 p_n[213]:='Significant wave height of first swell partition [m]';
 p_n[214]:='Significant wave height of second swell partition [m]';
 p_n[215]:='Significant wave height of third swell partition [m]';
 p_n[216]:='Wave spectral directional width [dimensionless]';
 p_n[217]:='Wave spectral directional width for swell [dimensionless]';
 p_n[218]:='Wave spectral directional width for wind waves [dimensionless]';
 p_n[219]:='Wave spectral kurtosis [dimensionless]';
 p_n[220]:='Wave spectral peakedness [dimensionless]';
 p_n[221]:='Wave spectral skewness [dimensionless]';


(* Other *)
 p_n[222]:='Angle of sub-gridscale orography [radians]';
 p_n[223]:='Anisotropy of sub-gridscale orography [~]';
 p_n[224]:='Benjamin-feir index [dimensionless]';
 p_n[225]:='Boundary layer dissipation [J m-2]';
 p_n[226]:='Boundary layer height [m]';
 p_n[227]:='Charnock [~]';
 p_n[228]:='Convective available potential energy [J kg-1]';
 p_n[229]:='Convective inhibition [J kg-1]';
 p_n[230]:='Duct base height [m]';
 p_n[231]:='Eastward gravity wave surface stress [N m-2 s]';
 p_n[232]:='Eastward turbulent surface stress [N m-2 s]';
 p_n[233]:='Forecast albedo [(0 - 1]';
 p_n[234]:='Forecast surface roughness [m]';
 p_n[235]:='Friction velocity [m s-1]';
 p_n[236]:='Geopotential
 p_n[237]:='Gravity wave dissipation [J m-2]';
 p_n[238]:='Instantaneous eastward turbulent surface stress [N m-2]';
 p_n[239]:='Instantaneous moisture flux [kg m-2 s-1]';
 p_n[240]:='Instantaneous northward turbulent surface stress [N m-2]';
 p_n[241]:='K index [K]';
 p_n[242]:='Land-sea mask [(0 - 1]';
 p_n[243]:='Magnitude of turbulent surface stress [N m-2 s]';
 p_n[244]:='Mean magnitude of turbulent surface stress [N m-2]';
 p_n[245]:='Minimum vertical gradient of refractivity inside trapping layer [m-1]';
 p_n[246]:='Northward gravity wave surface stress [N m-2 s]';
 p_n[247]:='Northward turbulent surface stress [N m-2 s]';
 p_n[248]:='Sea-ice cover [(0 - 1]';
 p_n[249]:='Skin reservoir content [m of water equivalent]';
 p_n[250]:='Slope of sub-gridscale orography [~]';
 p_n[251]:='Standard deviation of filtered subgrid orography [m]';
 p_n[252]:='Standard deviation of orography [~]';
 p_n[253]:='Total column ozone [kg m-2]';
 p_n[254]:='Total column supercooled liquid water [kg m-2]';
 p_n[255]:='Total column water [kg m-2]';
 p_n[256]:='Total column water vapour [kg m-2]';
 p_n[257]:='Total totals index [K]';
 p_n[258]:='Trapping layer base height [m]';
 p_n[259]:='Trapping layer top height [m]';
 p_n[260]:='U-component stokes drift [m s-1]';
 p_n[261]:='V-component stokes drift [m s-1]';
 p_n[262]:='Zero degree level [m]';

end;  }

end.

