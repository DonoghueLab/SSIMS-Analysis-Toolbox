SSIMS Toolbox v4.0
==================


Carlos Vargas-Irwin
Jonas B. Zimmermann
Jacqueline Hynes

Donoghue Lab, Brown University, 2012-2019.

https://github.com/DonoghueLab/SSIMS-Analysis-Toolbox

### Quick-Guide ####
The purpose of this toolbox is to generate dimensionality-reduced **S**pike train **Sim**ilarity (SSIM) Maps from discrete or continuous neural data, facilitating visualization and further analysis. 

To get started: 
1. Download the tool box from Github: [Toolbox Repository](https://github.com/DonoghueLab/SSIMS-Analysis-Toolbox) 

2. Add toolbox to your MATLAB path.

3. **Optional, but recommended** Installation of complied Matlab code for significantly(!) increased performance see 'install.md'. 

4. Open **SSIMS_democenter_out.m** in Matlab: for guidance on using SSIMS (dim-reduced Ensemble Activity Spiketrain Simliarty Maps) with a single demo dataset (discrete data).  

5. For more details on both methods see publication [1] or our webpage: [Donoghue Lab - Github Page - Analysis Toolbox](https://donoghuelab.github.io/SSIMS-Analysis-Toolbox/). 

Any questions should be directed to <carlos_vargas-irwin@brown.edu>


Version history
---------------
 *  4.0.0: March 2019
    Added Public SSIMS toolbox to Github; updated readME and install instructions; created webpage
*   3.0.11: 24 May 2017
    Added `getCSIMS` function for continuous data
*   3.0.10: 3 November 2016
  Add build instructions for macOS 12 and MATLAB 2016b
*   3.0.9:  15 September 2016
  Major overhaul of the toolbox structure.
  Removed legacy functions, improved function signatures
  Add example with real data
  Improved installation instructions
  This is a pre-release to test functionality before wider distribution
*   3.0:    11 May 2016
	Rewrite of most of the toolbox. We now use armadillo for linear algebra functions.
	There are also efficient functions to extract spike trains in windows, based
	on custom C++ classes efficiently handling spike trains.
	Build instructions for Windows greatly improved
*   2.2:    17 Novemeber 2014
    First public release.


References
----------
[1] [Vargas-Irwin CE, Brandman DM, Zimmermann JB, Donoghue JP, Black MJ (Jan. 2015). “Spike Train SIMilarity Space (SSIMS): A Framework for Single Neuron and Ensemble Data Analysis”. In: Neural Computation. 27(1), pp.1–31.](http://www.mitpressjournals.org/doi/abs/10.1162/NECO_a_00684?url_ver=Z39.88-2003&rfr_id=ori:rid:crossref.org&rfr_dat=cr_pub%3dpubmed)

[2] Van der Maaten, Laurens J P and Geoffrey E Hinton (Nov. 2008). “Visualizing High-Dimensional Data Using t-SNE”. In: Journal of Machine Learning Research 9, pp. 2579–2605.

[3] Victor, J D and K P Purpura (1996). “Nature and precision of temporal coding in visual cortex: a metric-space analysis”. In: Journal of Neurophysiology 76.2, pp. 1310–26.
