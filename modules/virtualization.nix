{ pkgs, ... }:
{
  # KVM/QEMU via libvirt, managed with virt-manager.
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm; # host-arch only, smaller closure
        swtpm.enable = true;     # virtual TPM (needed for Windows 11)
        runAsRoot = false;
      };
    };
    spiceUSBRedirection.enable = true; # pass USB devices (audio interface, MIDI, iLok) to the VM
  };

  programs.virt-manager.enable = true;

  users.users.f.extraGroups = [ "libvirtd" ];
}
