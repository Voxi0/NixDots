{ lib, config, pkgs, ... }: {
  # Module options
  options = {
    enableFirefox = lib.mkEnableOption "Enables Firefox";
  };

  # Configure Firefox if it's enabled
  config = lib.mkIf config.enableFirefox {
    # Firefox configuration
    programs.firefox = {
      enable = true;
			package = pkgs.firefox;
      profiles = {
        "Voxi0" = {
          isDefault = true;

          # Browser settings
          settings = {
            "browser.fullscreen.autohide" = false;
            "ui.key.menuAccessKeyFocuses" = false;
						"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };

          # Bookmarks - Add "tags" and "keyword" if necessary
          bookmarks = [
            # NixOS stuff
            {
              name = "nebunebu/nix-config";
              url = "https://github.com/nebunebu/nix-config";
            }

            # OSDev stuff
            {
              name = "BrokenThorn Entertainment";
              url = "http://www.brokenthorn.com/Resources/OSDevIndex.html";
            }
          ];

          # Search engines
          search = {
            force = true;
            engines = {
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
            };
          };

          # User Chrome CSS
          userChrome = ''
						#titlebar { 
							display: none !important; 
						}
          '';
        };
      };
    };
  };
}
