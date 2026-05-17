{ ... }:

{
  # XH00 is the USB controller (pci:0000:11:00.0) that hosts the Logitech
  # Unifying Receiver. The receiver continuously transmits, which triggers
  # an immediate resume from suspend. Disable its wakeup capability before
  # each sleep; the state persists through suspend/resume cycles.
  powerManagement.powerDownCommands = ''
    for dev in XH00; do
      if grep -q "^$dev.*enabled" /proc/acpi/wakeup; then
        echo "$dev" > /proc/acpi/wakeup
      fi
    done
  '';
}
