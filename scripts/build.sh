source settings.sh

cd ${gem5};

CPU_MODELS="CPU_MODELS=\"AtomicSimpleCPU,MinorCPU,O3CPU,TimingSimpleCPU\""
build="build/X86/gem5.opt";

commandline="scons ${CPU_MODELS} ${build} -j5";
echo ${commandline};
${commandline};
