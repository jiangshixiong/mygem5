source settings.sh

argc="${#}";
argv=("${@}");
echo ${argc}
if [ ${argc} != 1 ] && [ ${argc} != 2 ]; then 
	echo "argc = 1 or 2";
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

# -------------------------CPU---------------------------
cpu_type="--cpu-type DerivO3CPU";
num_cpu="--num-cpu 1";
sys_voltage="--sys-voltage 1.0V"
sys_clock="--sys-clock 1GHz";
cpu_clock="--cpu-clock 2GHz";

CPU_SETTINGS="${cpu_type} ${num_cpu} ${sys_voltage} ${sys_clock} ${cpu_clock}";

# --------------------------CACHES---------------------------
caches="--caches";
l2cache="--l2cache";

# ----------l1----------
l1d_size="--l1d_size 64kB";
l1d_assoc="--l1d_assoc 2";

l1i_size="--l1i_size 32kB";
l1i_assoc="--l1i_assoc 2";

L1_SETTINGS="${caches} ${l2cache} ${l1d_size} ${l1d_assoc} ${l1i_size} ${l1i_assoc}";

# ----------l2----------
num_l2caches="--num-l2caches 1";
l2_size="--l2_size 2MB";
l2_assoc="--l2_assoc 8";

L2_SETTINGS="${num_l2caches} ${l2_size} ${l2_assoc}";

# ----------l3----------
num_l3caches="--num-l3caches 1";
l3_size="--l3_size 16MB";
l3_assoc="--l3_assoc 16";

L3_SETTINGS="${num_l3caches} ${l3_size} ${l3_assoc}";

# ---------- l1 + l2 + l3 -------------
CACHES_SETTINGS="${L1_SETTINGS} ${L2_SETTINGS} ${L3_SETTINGS}";

# -----------------------MEMORY-------------------------
mem_type="--mem-type DDR3_1600_x64";
mem_channels="--mem-channels 1";
mem_ranks="--mem-ranks 2";
mem_size="--mem-size 512MB";

MEMORY_SETTINGS="${mem_type} ${mem_channels} ${mem_ranks} ${mem_size}";

# ------------------CPU + CACHES + MEMORY -------------------
SETTINGS="${CPU_SETTINGS} ${CACHES_SETTINGS} ${MEMORY_SETTINGS}";

# ---------------------- BENCHMARKS ------------------------
benchmark_path="${gem5}/tests/test-progs/hello/bin/${tech_lowercase}/linux";
benchmark="${benchmark_path}/hello";

# ---------------------- COMMANDLINE --------------------------
if [ ${argc} == 2 ] && [ ${argv[1]} == "help" ]; then
	commandline="${binary} ${python} --help";
else
	commandline="${binary} ${python} ${SETTINGS} -c ${benchmark}";
fi

echo ${commandline};
${commandline};

