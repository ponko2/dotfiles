finicky.setDefaultBrowser("org.mozilla.firefox");

finicky.onUrl(function(url, opts) {
  var sourceApplication = opts && opts.sourceBundleIdentifier;

  // Reeder
  if (sourceApplication === "com.reederapp.rkit2.mac") {
    var chrome = {
      bundleIdentifier: "com.google.Chrome",
      openInBackground: true
    };

    // SNS
    if (url.match(/^https?:\/\/twitter\.com/)) {
      return chrome;
    }

    // GitHub
    if (url.match(/^https?:\/\/github/)) {
      return chrome;
    }

    // Qiita
    if (url.match(/^https?:\/\/qiita\.com/)) {
      return chrome;
    }

    return {
      openInBackground: true
    };
  }

  // Slack
  if (sourceApplication === "com.tinyspeck.slackmacgap") {
    return {
      bundleIdentifier: "com.google.Chrome"
    };
  }

  // 1Password
  if (sourceApplication === "com.agilebits.onepassword7") {
    return {
      bundleIdentifier: "com.google.Chrome"
    };
  }

  // Thunderbird
  if (sourceApplication === "org.mozilla.thunderbird") {
    return {
      bundleIdentifier: "com.google.Chrome"
    };
  }

  // Excel
  if (sourceApplication === "com.microsoft.Excel") {
    return {
      bundleIdentifier: "com.google.Chrome"
    };
  }

  // Word
  if (sourceApplication === "com.microsoft.Word") {
    return {
      bundleIdentifier: "com.google.Chrome"
    };
  }

  // Powerpoint
  if (sourceApplication === "com.microsoft.Powerpoint") {
    return {
      bundleIdentifier: "com.google.Chrome"
    };
  }

  // iTerm2
  if (sourceApplication === "com.googlecode.iterm2") {
    return {
      bundleIdentifier: "com.google.Chrome"
    };
  }

  // Command Line Tools
  if (sourceApplication === null) {
    return {
      bundleIdentifier: "com.google.Chrome"
    };
  }
});
