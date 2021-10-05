Setup
=====

Download SDK perf: https://solace.com/downloads/#other-software

Should be able to download using wget:
wget https://products.solace.com/download/SDKPERF_C_LINUX64

Edit env.sh according to your environment.

Running Tests
=============

For tests involving queues run SEMP script first to initialise queues.

Run each test case and record result in the xls.

Set the appropriate messages size (-msa) for your use case.

Experiment with different publish rates (-mr) until you achieve the best baseline performance.

To run longer tests increase the number of messages (-mn)

[Note If you run test with higher numbers of connections you may need to use "-tm rtrperf" option to reduce the internal number of threads created with SDK Perf.]