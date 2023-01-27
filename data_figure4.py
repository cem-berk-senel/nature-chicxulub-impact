#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 26 22:54:00 2023

@author: Cem Berk Senel, Royal Observatory of Belgium
"""

import numpy as np
import scipy.io
import os
import matplotlib.pyplot as plt
from matplotlib import rc
import pyart # https://arm-doe.github.io/pyart/API/generated/pyart.graph.html THIS IS FOR other CMAP OPTIONS 
import cartopy
import cartopy.crs as ccrs
import matplotlib.ticker as mticker
from cartopy.mpl.gridliner import LONGITUDE_FORMATTER, LATITUDE_FORMATTER
from cartopy.mpl.ticker import (LongitudeFormatter, LatitudeFormatter, LatitudeLocator)


def plot_robinson_hgt(x, y, dataplot_1, dataplot_2, resolution, output, limmin,limmax ):
	data_1 	   = dataplot_1
	data_2 	   = dataplot_2    
	maxval = max(map(max, data_1)) 
	minval = min(map(min, data_1)) 
	levels = np.linspace(limmin,limmax,resolution)

	fig = plt.figure(figsize = (20,9))
	axs1 = plt.axes(projection=ccrs.Robinson())    
	gl1 = axs1.gridlines(crs=ccrs.PlateCarree(), draw_labels=True, linewidth=1, color='black', alpha=0.3, linestyle='--')
	gl1.top_labels = 'True'
	gl1.left_labels = 'True'
	gl1.xlines = 'True'
	gl1.xlocator = mticker.FixedLocator([-180, -120, -60, 0, 60, 120, 180])
	gl1.ylocator = LatitudeLocator()
	gl1.xformatter = LongitudeFormatter()
	gl1.yformatter = LatitudeFormatter()
	gl1.xlabel_style = {'size': 12, 'color': 'black'}
	gl1.ylabel_style = {'size': 9, 'color': 'black'}  
	plot1 = axs1.contourf(x, y, data_1 ,levels, transform=ccrs.PlateCarree(), cmap=plt.cm.terrain, linestyles='dashed')
	axs1.set_global() 
	cbar = plt.colorbar(plot1, orientation = 'vertical')#, vmin = -50, vmax = 50)#, labelsize = 18)
	cbar.ax.tick_params(labelsize=14) 
	cbar.formatter.set_powerlimits((1, 2))
	plot2 = axs1.contour(x, y, data_2, 50, colors='black', transform=ccrs.PlateCarree(), alpha=0.2)
	#cbar.update_ticks() 
	plt.savefig("{}".format(output), dpi=600)  
	plt.show()      
# 	plt.suptitle("{}".format(title),size = 10)    
# 	plt.title("{}".format(title),size = 12)	
# 	plt.tight_layout()

def plot_robinson_ts(x, y, dataplot_1, dataplot_2, resolution, output, limmin,limmax ):
	data_1 	   = dataplot_1
	data_2 	   = dataplot_2    
	maxval = 40 
	minval = -30 
	levels = np.linspace(limmin,limmax,resolution)

	fig = plt.figure(figsize = (20,9))
	axs1 = plt.axes(projection=ccrs.Robinson())    
	gl1 = axs1.gridlines(crs=ccrs.PlateCarree(), draw_labels=True, linewidth=1, color='black', alpha=0.4, linestyle='--')
	gl1.right_labels = False
	gl1.top_labels = False
	gl1.left_labels = False
	gl1.bottom_labels = False    
	plot1 = axs1.contourf(x, y, data_1 ,levels, transform=ccrs.PlateCarree(), cmap=plt.cm.RdBu_r, linestyles='dashed', extend="both")
	plot2 = axs1.contour(x, y, data_1, levels, colors='black', transform=ccrs.PlateCarree(), alpha=0.1, linestyles='dashed')
	axs1.set_global() 
	cbar = plt.colorbar(plot1, orientation = 'vertical')#, vmin = -50, vmax = 50)#, labelsize = 18)
	cbar.ax.tick_params(labelsize=14) 
	cbar.formatter.set_powerlimits((1, 2))
	plot2 = axs1.contour(x, y, data_2, 50, colors='black', transform=ccrs.PlateCarree(), alpha=0.2)
	#cbar.update_ticks() 
	plt.savefig("{}".format(output), dpi=300)  
	plt.show()      
# 	plt.suptitle("{}".format(title),size = 10)    
# 	plt.title("{}".format(title),size = 12)	
# 	plt.tight_layout()

def plot_robinson_par(x, y, dataplot_1, dataplot_2, resolution, output, limmin,limmax ):
	data_1 	   = dataplot_1
	data_2 	   = dataplot_2    
	maxval = 45 
	minval = -30
	levels = np.linspace(limmin,limmax,resolution)

	fig = plt.figure(figsize = (20,9))
	axs1 = plt.axes(projection=ccrs.Robinson())    
	gl1 = axs1.gridlines(crs=ccrs.PlateCarree(), draw_labels=True, linewidth=1, color='black', alpha=0.4, linestyle='--')
	gl1.right_labels = False
	gl1.top_labels = False
	gl1.left_labels = False
	gl1.bottom_labels = False  
	plot1 = axs1.contourf(x, y, data_1 ,levels, transform=ccrs.PlateCarree(), cmap=plt.cm.Greens, linestyles='dashed', extend="both")
	axs1.set_global() 
	cbar = plt.colorbar(plot1, orientation = 'vertical')#, vmin = -50, vmax = 50)#, labelsize = 18)
	cbar.ax.tick_params(labelsize=14) 
	cbar.formatter.set_powerlimits((1, 2))
	plot2 = axs1.contour(x, y, data_2, 50, colors='black', transform=ccrs.PlateCarree(), alpha=0.2)
	#cbar.update_ticks() 
	plt.savefig("{}".format(output), dpi=300)  
	plt.show()      
# 	plt.suptitle("{}".format(title),size = 10)    
# 	plt.title("{}".format(title),size = 12)	
# 	plt.tight_layout()
   
################################################
filefolder = "data/kpg"
filelist = sorted(os.listdir(filefolder))
filelist = [filefolder +"/"+ i for i in filelist if "kpg" in i] # list of files in the folder.

lonlat = [i for i in filelist if "kpg" in i]
mat_pre = scipy.io.loadmat(lonlat[0])

lons 	 = mat_pre["lonn"]
lats     = mat_pre["latt"]
lons_v = lons[:,0]
lats_v = lats[0,:]
LAT, LON = np.meshgrid(lats_v,lons_v)#, sparse=False, indexing='ij')

np.shape(LON)
np.shape(LAT)

xltt = mat_pre["xlt"] 
indx_ts = ["1", "2", "3", "4", "5", "6"]

variables = list(mat_pre.keys())
print(variables)

hgt_kpg	 = mat_pre["hgtt"]
maxval = 1610 
minval = -90 
plot_robinson_hgt(LON, LAT, dataplot_1=hgt_kpg, dataplot_2=xltt, resolution=18, output = "kpg_paleogeo"+".png", limmin = minval, limmax=maxval  ) 

for i in range(1,len(lonlat)):
  	mat_out = scipy.io.loadmat(lonlat[i])
  	ts_kpg	 = mat_out["tskpg_" + indx_ts[i-1]]
  	print("processing tskpg_" + indx_ts[i-1])
  	maxval = 40
  	minval = -30
  	plot_robinson_ts(LON, LAT, dataplot_1=ts_kpg, dataplot_2=xltt, resolution=71, output = "tskpg_" + indx_ts[i-1]+".png", limmin = minval, limmax=maxval  )
      
filefolder_par = "data/parkpg"
filelist_par = sorted(os.listdir(filefolder_par))
filelist_par = [filefolder_par +"/"+ i for i in filelist_par if "parkpg" in i] # list of files in the folder.

gfpar_mat = [i for i in filelist_par if "parkpg" in i]

indx_gfpar = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39"]

variables = list(mat_pre.keys())
print(variables)

for i in range(len(filelist_par)):
  	if i==1 or i==6 or i==11 or i==16:
  	   maxval = 160
  	   minval = 0        
  	else:
  	   maxval = 160      
  	   minval = 0                
  	mat_gfpar = scipy.io.loadmat(gfpar_mat[i])
  	gfpar_kpg = mat_gfpar["parkpg_" + indx_gfpar[i]]
  	print("processing parkpg_" + indx_gfpar[i])
  	plot_robinson_par(LON, LAT, dataplot_1=gfpar_kpg, dataplot_2=xltt, resolution=17, output = "parkpg_" + indx_gfpar[i]+".png", limmin = minval, limmax=maxval  )      
  	 

