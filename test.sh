#!/usr/bin/env bash
#
# test.sh
# Copyright (C) 2014 Andrew DeMaria (muff1nman) <ademaria@mines.edu>
#
# All Rights Reserved.
#

if [[ -e jekyll.log ]]; then
	pkill jekyll
	rm jekyll.log
fi

nohup jekyll serve --drafts > jekyll.log &
sleep 1
grep -REiI 'Server address' jekyll.log

