#!/bin/bash
VM_NAME="win11"
SCRIPT_DIR="/home/steve/VirtualMachines"

# 1. RESERVE Hugepages
"$SCRIPT_DIR/enable_hugepages.sh"

# Wait a moment for allocation
sleep 1

# 2. START the VM (This will only work if hugepages were successfully allocated)
echo "Starting VM: $VM_NAME"
sudo virsh start "$VM_NAME"
echo "Starting Looking Glass"
sleep 20
looking-glass-client

# 3. Wait for the VM to shut down or be explicitly stopped by the user
echo "VM $VM_NAME is running. Waiting for shutdown..."

# Loop while the output of "virsh domstate" contains the string "running"
while sudo virsh domstate "$VM_NAME" | grep -q "running"; do
    sleep 5
done

# Check the final state
FINAL_STATE=$(sudo virsh domstate "$VM_NAME")
echo "VM $VM_NAME has shut down. Final state: $FINAL_STATE"

echo "Releasing hugepages."

# 4. RELEASE Hugepages
"$SCRIPT_DIR/disable_hugepages.sh"

echo "Done."
