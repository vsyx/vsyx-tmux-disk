#!/usr/bin/env bash

avail=$(df "$HOME" --output=avail 2>/dev/null | tail -1 | tr -d ' ')
if [ -n "$avail" ]; then
  gb=$((avail / 1048576))
  printf "%dG" "$gb"
fi
