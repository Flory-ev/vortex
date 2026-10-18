{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.virtualisation.libvirt;
in
{
  options.my.virtualisation.libvirt.enable = lib.mkEnableOption "KVM/QEMU via libvirt with virt-manager";

  config = lib.mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          runAsRoot = false;
        };
      };
      spiceUSBRedirection.enable = true; # pass USB devices (audio interface, MIDI, iLok) to the VM
    };

    programs.virt-manager.enable = true;
    users.users.${config.my.user.name}.extraGroups = [ "libvirtd" ];
  };
}
