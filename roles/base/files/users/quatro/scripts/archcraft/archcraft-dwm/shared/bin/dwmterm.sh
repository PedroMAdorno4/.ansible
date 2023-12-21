#!/usr/bin/env bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>

if [ "$1" == "--float" ]; then
	st -c 'st-float,st-float'
else
	st
fi
