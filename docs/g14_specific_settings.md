# ROG Zephyrus G14 specific settings
The 2022 model of the Asus ROG G14 line has certain issues on Linux that can cause important disruption when using the laptop.

The issue that I experienced the most where
- Constant freezing (specially when the computer was idle)
- Constant kernel panics on boot and immediately after

These two issues would happen in less than 2 or 3 minutes, and it would happen on battery or AC

The solution I found to work for this was on a [Reddit thread](www.reddit.com/r/ZephyrusG14/comments/lodi4ma/comment/nie1z2n/?force-legacy-sct=1). This solution is based for fedora, but the application on Nix is not hard.

It can be done like this, in my case I am using option 1.

```nix
# amd_pstate needs to be set to active
boot.kernelParams = [
  "amd_pstate=active"
];

# Set the governor to performance
services.auto-cpufreq.enable = true;
services.auto-cpufreq.settings = {
  battery = {
    governor = "performance";
    turbo = "never"; # I prefer this option for battery life reasons
  };

  charger = {
    governor = "performance";
    turbo = "auto";
  };
};
```

There are other settings that can be used for this, but they decrease the battery life significantly.

```nix
boot.kernelParams = [
  "pcie_aspm=off"
];

boot.extraModprobeConfig = ''
  options amdgpu runpm=0
'';
```
