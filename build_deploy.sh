#!/bin/bash

rm -rf public
git clone https://github.com/hejcz/hejcz.github.io.git public
hugo -D
cd public
git add .
git commit -m "$(date)"
git push origin master
cd ..
