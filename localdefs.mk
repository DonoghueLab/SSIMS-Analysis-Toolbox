##  !!! DO NOT EDIT THIS FILE DIRECTLY !!!
#   Instead, copy it to localdefs.mk and make your changes there!

# By default, OpenMP support is not enabled, as compilers delivered Xcode <=7.3.1 do not support it.
# Depending on where your dependent libaries are installed, you may have to change the following options:

#extraCXXFLAGS=-O3 -std=c++11 -stdlib=libc++ -I/usr/local/include
#extraLDFLAGS=-L/usr/local/lib -larpack -O3

## Compilers to use for C/C++ files, and for special versions for use with OpenMP (if so desired)
# c_compiler=clang
# cpp_compiler=clang++

## Path to MATLAB app.
MATLAB_ROOT:=/Applications/MATLAB_R2018a.app


## Relative path to build products
## Compiled *.mex* files will be copied here.
# productdir=for_MATLAB

## Directory to be used for building
# builddir=build


## Using parallelization techniques.
# If you would like to use OpenMP to make use of multiple processors/cores, uncomment `use_openmp`
# (any non-empty value will enable OpenMP). Your compiler has to support it though, and MATLAB
# has to be configured to use the different compiler (see INSTALL.md)
#use_openmp=1

## Compilers to use for C/C++ files, using special versions for use with OpenMP (if so desired)
#c_compiler=/usr/local/opt/llvm/bin/clang
#cpp_compiler=/usr/local/opt/llvm/bin/clang++

#extraCXXFLAGS=-O3 -std=c++11 -stdlib=libc++ -I/usr/local/include -I/usr/local/opt/llvm/include
#extraLDFLAGS=-L/usr/local/lib -larpack -O3 -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib

# use the following instead if working with macOS 12:
#extraCXXFLAGS=-O3 -std=c++11 -stdlib=libc++ -I/usr/local/opt/llvm/include
#extraLDFLAGS= -larpack -O3 -L$(MATLAB_ROOT)/sys/os/maci64 -L/usr/local/opt/llvm/lib -Wl,-rpath,$(MATLABROOT)/sys/os/maci64:/usr/local/opt/llvm/lib



