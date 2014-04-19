#!/usr/bin/env bash
#
# test.sh
# Copyright (C) 2014 Andrew DeMaria (muff1nman) <ademaria@mines.edu>
#
# All Rights Reserved.
#

pkill jekyll
rm jekyll.log

nohup jekyll serve --drafts -w > jekyll.log &
sleep 2
grep -REiI 'Server address' jekyll.log
exit 0
