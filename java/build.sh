#!/bin/sh
source ../env.sh

CLASSPATH=./*:$SOL_JCSMP/lib/*

javac -cp $CLASSPATH  -d . *.java
