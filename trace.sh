#!/bin/bash
# need run in root
DPATH="/sys/kernel/debug/tracing"
TEMP="./mytrace.txt"
# The pid number you want to hide.
PROC=721

#clear the trace file
echo nop > $DPATH/current_tracer

echo function_graph > $DPATH/current_tracer

echo > $DPATH/set_ftrace_filter
echo > $DPATH/set_ftrace_pid

#echo $$ > $DPATH/set_ftrace_pid

# Need insmod first
echo hook_find_ge_pid > $DPATH/set_ftrace_filter
echo device_open >> $DPATH/set_ftrace_filter
echo device_close >> $DPATH/set_ftrace_filter
echo device_write >> $DPATH/set_ftrace_filter
echo device_read >> $DPATH/set_ftrace_filter
echo find_ge_pid >> $DPATH/set_ftrace_filter

echo 1 > $DPATH/tracing_on

echo "add ${PROC}" | tee /dev/hideproc

ps -ef

echo "del ${PROC}" | tee /dev/hideproc

pidof cron

echo 0 > $DPATH/tracing_on

cat $DPATH/trace > $TEMP
