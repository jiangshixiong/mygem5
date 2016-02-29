source settings.sh

cd ${gem5};

build_path="build/ARM";
build="${build_path}/gem5.opt";

commandline="scons ${build}";
echo ${commandline};
${commandline};
