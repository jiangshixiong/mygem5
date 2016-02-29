source settings.sh

argc=${#}
argv=${@};

if [ ${argc} != 1 ]; then 
	echo "argc = 1";
	exit;
else 
	tech=${argv[0]};
fi

tech_uppercase=${tech^^};
tech_lowercase=${tech,,};

commandline="scons ${build}";
binary_path="${gem5}/build/${tech_uppercase}";
binary="${binary_path}/gem5.opt";

python_path="${gem5}/configs/example";
python="${python_path}/se.py";

benchmark_path="${gem5}/tests/test-progs/hello/bin/${tech_lowercase}/linux";
benchmark="${benchmark_path}/hello";

commandline="${binary} ${python} -c ${benchmark}";

echo ${commandline};

${commandline};

