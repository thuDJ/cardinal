#!/bin/sh
# Copyright 1998-2019 Lawrence Livermore National Security, LLC and other
# HYPRE Project Developers. See the top-level COPYRIGHT file for details.
#
# SPDX-License-Identifier: (Apache-2.0 OR MIT)

testname=`basename $0 .sh`
tests=""

# Echo usage information
case $1 in
   -h|-help)
      cat <<EOF

   $0 [-h] {src_dir} [options] [-rt <options for runtest.sh script>]

   where: -h|-help   prints this usage information and exits
          {src_dir}  is the hypre source directory
          -<test>    run <test>  (test = ams, fac, ij, sstruct, struct)
          -all       run all tests (default behavior)

   This script runs runtest.sh in {src_dir}/test with optional parameters.

   Example usage: $0 ../src -rt -D HYPRE_NO_SAVED

EOF
      exit
      ;;
esac

# Set src_dir
src_dir=$1; shift

# Parse the rest of the command line
while [ "$*" ]
do
   case $1 in
      -all)
         shift
         ;;
      -rt)
         shift
         break
         ;;
      -*)
         tname=`echo $1 | sed 's/-//'`
         tests="$tests $tname"
         shift
         ;;
   esac
done

# If no tests were specified, run all tests
if [ "$tests" = "" ]; then
   tests="ams fac ij sstruct struct"
fi

# Setup
output_dir=`pwd`/$testname.dir
rm -fr $output_dir
mkdir -p $output_dir

# Run the test drivers
cd $src_dir/test
./cleantest.sh
for tname in $tests
do
   ./runtest.sh $@ TEST_$tname/*.sh
done

# Collect all error files from the tests
for errfile in $( find TEST* -name "*.err" -o -name "*.fil" -o -name "*.out*" )
do
   mkdir -p $output_dir/`dirname $errfile`
   mv -f $errfile $output_dir/$errfile
done

# Echo to stderr all nonempty error files in $output_dir
for errfile in $( find $output_dir ! -size 0 -name "*.err" )
do
   echo $errfile >&2
done