#!/bin/bash

echo "--> Configuring sauas..."
node-gyp configure --debug
if [ $? -eq 0 ]; then
  echo "--> Building sauas..."
  node-gyp build
  if [ $? -eq 0 ]; then
    echo "<-- Build succeeded!"
  else
    echo "<-- Build failed!"
  fi
else
  echo "<-- Configuration failed!"
fi