{...}: {
  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "type": "small"
      },
      "display": {
        "separator": "  "
      },
      "modules": [
        "uptime",
        {
          "type": "cpuusage",
          "key": "CPU"
        },
        {
          "type": "memory",
          "key": "RAM"
        },
        {
          "type": "disk",
          "folders": ["/"],
          "key": "Disk"
        },
        "battery"
      ]
    }
  '';
}
