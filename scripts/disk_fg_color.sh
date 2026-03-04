#!/usr/bin/env bash

avail=$(df "$HOME" --output=avail 2>/dev/null | tail -1 | tr -d ' ')
if [ -n "$avail" ]; then
  gb=$((avail / 1048576))
  if [ "$gb" -lt 5 ]; then
    echo "#[fg=red]"
  elif [ "$gb" -lt 10 ]; then
    echo "#[fg=colour208]"
  elif [ "$gb" -lt 20 ]; then
    echo "#[fg=yellow]"
  else
    echo "#[fg=green]"
  fi
fi
