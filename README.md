SSIMS Toolbox v3.0
==================


Carlos Vargas-Irwin
Jonas B. Zimmermann
Jacqueline Hynes

Donoghue Lab, Brown University, 2012-2019.

The purpose of this toolbox is to generate dimensionality-reduced data from spike trains, facilitating visualization and further analysis. The toolbox integrates two algorithms to achieve this:
* spike train distance metric described by Victor and Purpura (1996)
* t-Distributed Stochastic Neighbor Embedding (tSNE) (Van der Maaten and Hinton 2008).
The whole approach has been published in Vargas-Irwin et al. 2015.

For installation instructions, see `doc/INSTALL.md`. Specific files for macOS X installations are contained in `doc/install_mac`.
For an example, open & run `SSIMS_demo_center_out.m` in MATLAB.
In addition, the C++ code implementing tSNE and useful spike train manipulation functions have some example code in src/test. `SSIMS_test.cpp` is essentially a port of `SSIMS_demo_center_out.m`, without plotting. On Mac/Linux, run with `make test`.


Version history
---------------
 *  4.0.0: March 2019
    Added SSIMS toolbox to Github; updated install instructions
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
[Vargas-Irwin CE, Brandman DM, Zimmermann JB, Donoghue JP, Black MJ (Jan. 2015). “Spike Train SIMilarity Space (SSIMS): A Framework for Single Neuron and Ensemble Data Analysis”. In: Neural Computation. 27(1), pp.1–31.](http://www.mitpressjournals.org/doi/abs/10.1162/NECO_a_00684?url_ver=Z39.88-2003&rfr_id=ori:rid:crossref.org&rfr_dat=cr_pub%3dpubmed)

Van der Maaten, Laurens J P and Geoffrey E Hinton (Nov. 2008). “Visualizing High-Dimensional Data Using t-SNE”. In: Journal of Machine Learning Research 9, pp. 2579–2605.

Victor, J D and K P Purpura (1996). “Nature and precision of temporal coding in visual cortex: a metric-space analysis”. In: Journal of Neurophysiology 76.2, pp. 1310–26.
