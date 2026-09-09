{ config, pkg, lib, ... }:

let
  domain = "stryxredact.net";
  matrixDomain = "matrix.${domain}";
  rtcDomain = "rtc.${domain}";
  clientConfig = {
    "m.homeserver".base_url = "https://${matrixDomain}";

    # MatrixRTC
    "org.matrix.msc4143.rtc_foci" = [
      {
        type = "livekit";
        livekit_service_url = "https://${rtcDomain}/livekit/jwt";
      }
    ];
  };

  serverConfig = {
    "m.server" = "${matrixDomain}:443";
  };

  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';

in {
  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = domain;
      public_baseurl = "https://${matrixDomain}";

      listeners = [
        {
          port = 8008;
          bind_addresses = ["127.0.0.1"];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = ["client" "federation"];
              compress = true;
            }
          ];
        }
      ];

      database = {
        name = "psycopg2";
        allow_unsafe_locale = true;
        args = {
          user = "matrix-synapse";
          database = "matrix-synapse";
          host = "/run/postgresql";
        };
      };

      experimental_features = {
        msc3266_enabled = true;
        msc4143_enabled = true;
        msc4222_enabled = true;
        msc4140_enabled = true;
      };

      rc_message = {
        per_second = 1;
        burst_count = 20;
      };

      rc_delayed_event_mgmt = {
        per_second = 1;
        burst_count = 20;
      };

      max_event_delay_duration = "24h";

      matrix_rtc.transports = [
        {
          type = "livekit";
          livekit_service_url = "https://rtc.stryxredact.net/livekit/jwt";
        }
      ];

      max_upload_size_mib = 100;
      url_preview_enabled = true;
      enable_registration = false;
      enable_metrics = false;
      registration_shared_secret_path = "/var/lib/matrix-synapse/registration_secret";

      trusted_key_servers = [
        {
          server_name = "matrix.org";
        }
      ];
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = ["matrix-synapse"];
    ensureUsers = [
      {
        name = "matrix-synapse";
        ensureDBOwnership = true;
      }
    ];
  };

  services.nginx.virtualHosts.${domain} = {
    enableACME = true;
    forceSSL = true;
    locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
    locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
  };

  services.nginx.virtualHosts.${matrixDomain} = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8008";
      extraConfig = ''
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        client_max_body_size 100M;
      '';
    };
  };

  services.nginx.virtualHosts.${rtcDomain} = {
    enableACME = true;
    forceSSL = true;
    locations."/livekit/jwt/" = {
      proxyPass = "http://127.0.0.1:8080/";
      extraConfig = ''
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
      '';
    };
    locations."/livekit/sfu/" = {
      proxyPass = "http://127.0.0.1:7880/";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
      '';
    };
  };

  services.livekit = {
    enable = true;
    keyFile = "/var/lib/livekit/keys.yaml";
  };

  services.lk-jwt-service = {
    enable = true;
    livekitUrl = "wss://rtc.stryxredact.net/livekit/sfu";
    keyFile = "/var/lib/livekit/keys.yaml";
    port = 8080;
  };

  networking.firewall.allowedTCPPorts = [ 8448 80 443 7881];
  networking.firewall.allowedUDPPortRanges = [
    { from = 50000; to = 60000; }
  ];
}
