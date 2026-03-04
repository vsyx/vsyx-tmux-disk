#!/usr/bin/env bash

pct=$(df "$HOME" --output=pcent 2>/dev/null | tail -1 | tr -d ' %')
[ -n "$pct" ] && echo "${pct}%"
