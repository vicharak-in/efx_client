# efx_client - remote synthesis on Galactos

## Install

```
git clone https://github.com/vicharak-in/efx_client/
cd efx_client
sudo make install-client
```

## Updating (whenever new updates are available)

```
cd efx_client
git pull origin master
sudo make install-client
```

## Usage

```
$ efx_client -d <folder_name> -n <project_name> -e <efinity_version>
```

Example:
```
$ efx_client -d ~/dev/verilog/and_gate -n and_gate -e 2
$ efx_client -d ~/dev/verilog/and_gate
```

Help:
```
$ efx_client -h
```

Carry out multiple jobs at the same time:

```
$ efx_client -d . -n proj_name -e 2023.2 -o job1 &>/dev/null </dev/null &
$ efx_client -d . -n proj_name -e 2023.2 -o job2 &>/dev/null </dev/null &
$ efx_client -d . -n proj_name -e 2023.2 -o job3 &>/dev/null </dev/null &
```
You may give relevant names to the jobs. After the processes have finished,
the results (log messages, bitstreams etc.) can be found in job1, job2, job3
directories.

## Inspecting output

After synthesis is complete, the console output can be found in the outflow
directory inside the `<project_folder>` that you provided earlier.

These are the files of interest:
```
<project_name>.err.log
<project_name>.info.log
<project_name>.log
```

The `.log` file contains the numbers for resource usage of logical,
input/output, memory blocks, frequency, slack etc. This is the same output that
you would see in your console.

## Opening outflow in Efinix IDE

Simply open the project in Efinix IDE or reload after remote synthesis is
complete. You should see the updated results.

## Reporting Issues

Please use the issues tab to report any issues with the script. 
