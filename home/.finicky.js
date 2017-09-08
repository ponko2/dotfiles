finicky.setDefaultBrowser('com.apple.Safari');

finicky.onUrl(function (url, opts) {
  var sourceApplication = opts && opts.sourceBundleIdentifier;

  var safari = {
    bundleIdentifier: 'com.apple.Safari',
    openInBackground: true
  };

  var chrome = {
    bundleIdentifier: 'com.google.Chrome',
    openInBackground: true
  };

  var firefox = {
    bundleIdentifier: 'org.mozilla.firefox',
    openInBackground: true
  };

  // SNS
  if (url.match(/^https?:\/\/twitter\.com/)) {
    return safari;
  }

  // ChatWork
  if (url.match(/^https?:\/\/www\.chatwork\.com/)) {
    return {
      bundleIdentifier: 'com.google.Chrome'
    };
  }

  // Tech
  if (url.match(/^https?:\/\/(github|qiita)\.com/)) {
    return safari;
  }

  // Reeder
  if (sourceApplication === 'com.reederapp.rkit2.mac') {
    return firefox;
  }

  // Slack
  if (sourceApplication === 'com.tinyspeck.slackmacgap') {
    return firefox;
  }
});
