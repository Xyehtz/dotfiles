{...}: {
  services.atftpd = {
    enable = true;
    root = "/home/alej-garz/Downloads/brocade-09-08-2025/TFTP-Content";
    extraOptions = [
      "--secure"
      "-vvvv"
    ];
  };
}
