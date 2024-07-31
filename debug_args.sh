#!/bin/bash

POSITIONAL=()
for ARG in "$@"; do
    case $ARG in
        --output-file)
            OUTPUT_FILE="$2"
            shift; shift
            ;;
        *)
            POSITIONAL+=("$1")
            shift
            ;;
    esac
done

> "$OUTPUT_FILE"
for ITEM in "${POSITIONAL[@]}"; do
    if [[ -n "$ITEM" ]]; then
        echo "• $ITEM" >> "$OUTPUT_FILE"
    fi
done
