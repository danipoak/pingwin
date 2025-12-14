#!/bin/bash
# Enable Hugepages for a 32GB VM (e.g., 16384 pages @ 2MB each)

# --- Configuration ---
# Set the number of hugepages needed based on your VM's RAM (RAM in MB / 2)
# If VM has 32GB RAM (32768 MB), then 32768 / 2 = 16384
HUGEPAGE_COUNT=16384
# --- End Configuration ---

echo "Enabling $HUGEPAGE_COUNT hugepages..."

# Attempt to write the count to the kernel parameter
if echo "$HUGEPAGE_COUNT" | sudo tee /proc/sys/vm/nr_hugepages > /dev/null; then
    echo "Hugepages successfully allocated."
else
    echo "ERROR: Failed to allocate hugepages. Check memory availability."
    exit 1
fi
