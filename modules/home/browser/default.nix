{ lib, config, inputs, system, ... }: {
  # Module options
  options.enableFirefox = lib.mkEnableOption "Firefox";

  # Configuration
  config = lib.mkIf config.enableFirefox {
    # Firefox
    programs.firefox = {
      enable = true;
      enableGnomeExtensions = false;
      languagePacks = [ "en-GB" "en-US" ];

      # Policies
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
          default = "Google";
          privateDefault = "Google";
          order = [ "Google" ];
        };

        # Style and settings
        userChrome = "${builtins.readFile ./userChrome.css}";
        userContent = "${builtins.readFile ./userContent.css}";
        settings = {
          # New tab page
          "browser.startup.homepage" = "about:home";

          # Don't hide the tab bar when fullscreen
          "browser.fullscreen.autohide" = false;

          # Custom stylesheets e.g. userchrome to customize Firefox (REQUIRED)
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Vertical tabs
          "sidebar.verticalTab" = true;
          "sidebar.revamp" = true;

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

          # Harden
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = true;
          "security.ssl.require_safe_negotiation" = true;

          # Disable JS in PDFs
          "pdfjs.enableScripting" = false;

          # Disable some telemetry
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.sessions.current.clean" = true;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # Disable Pocket
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "extensions.pocket.enabled" = false;

          # Extra
          "layers.acceleration.force-enabled" = true;
          "gfx.webrender.enabled" = true;
          "gfx.webrender.all" = true;
          "layout.css.backdrop-filter.enabled" = true;
          "svg.context-properties.content.enabled" = true;
        };

        # Useful extensions to be installed by default with browser
        extensions.packages = with inputs.firefox-addons.packages.${system}; [
          ublock-origin # Very efficient and lightweight ad blocker
          decentraleyes # Protects you against tracking
          clearurls     # Removes tracking elements from URLs
          darkreader    # For reading sites that are too bright
          h264ify       # Makes YouTube stream H.264 videos instead of VP8/VP9 videos
          stylus        # Easily redisign websites
        ];
      };
    };
  };
}
