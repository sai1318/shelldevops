#!/bin/bash

MOVIES=("pushpa" "dhoni" "sachin")

echo "first movie ; ${MOVIES[0]}"
echo "second movie ; ${MOVIES[1]}"
echo "third movie ; ${MOVIES[2]}"

echo "all movies ; ${MOVIES[@]}"
