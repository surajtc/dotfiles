{pkgs, ...}: {
  # Automatically mount removable drives through UDisks2 in the Niri session.
  services.udiskie = {
    enable = true;
    automount = true;
    settings.program_options.file_manager = "${pkgs.nautilus}/bin/nautilus";
  };
}
