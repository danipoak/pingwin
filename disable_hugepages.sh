#!/bin/bash
# Disable Hugepages

echo "Disabling hugepages and releasing memory..."

# Release the reserved memory
if echo 0 | sudo tee /proc/sys/vm/nr_hugepages > /dev/null; then
    echo "Hugepages successfully released."
else
    echo "ERROR: Failed to release hugepages."
    exit 1
fi
