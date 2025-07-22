{
  lib,
  config,
  inputs,
  system,
  ...
}: {
  # Module options
  options.apps.enableFirefox = lib.mkEnableOption "Enable Firefox";

  # Configuration
  config = lib.mkIf config.apps.enableFirefox {
    # Stylix - List all Firefox profiles here as well because Stylix can't detect it
    stylix.targets.firefox.profileNames = ["NixDots"];

    # Firefox
    programs.firefox = {
      enable = true;
      enableGnomeExtensions = false;
      languagePacks = ["en-GB" "en-US"];
      policies = {
        BlockAboutConfig = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
      };

      # Default profile
      profiles."NixDots" = {
        name = "NixDots";
        isDefault = true;

        # Search engines
        search = {
          force = true;
          default = "google";
          privateDefault = "google";
          order = ["google"];
        };

        # Settings
        settings = {
          # New tab page
          "browser.startup.homepage" = "about:home";

          # Don't hide the tab bar when fullscreen
          "browser.fullscreen.autohide" = false;

          # Vertical tabs
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.main.tools" = "syncedtabs,history,bookmarks";

          # Disable irritating first-run stuff
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.feeds.showFirstRunUI" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.rights.3.shown" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.uitour.enabled" = false;
          "startup.homepage_override_url" = "";
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.bookmarks.addedImportButton" = true;
        };

        # Useful Firefox extensions to be installed by default
        extensions.packages = with inputs.firefox-addons.packages.${system}; [
          ublock-origin # Very efficient and lightweight ad blocker
          darkreader # For reading sites that are too bright
        ];
      };
    };
  };
}
