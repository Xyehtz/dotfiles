{...}: {
  # RAM Compression
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    memoryPercent = 60;
  };
}
