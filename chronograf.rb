class Chronograf < Formula
  desc "The data visualization tool for InfluxDB"
  homepage "https://influxdata.com/time-series-platform/chronograf/"
  url "https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf-0.12.0-darwin_amd64.tar.gz"
  sha256 "0ad198e5bcc851063459a6184841f8e53fd55b448442d5acb2b9365bd8d1535b"

  bottle :unneeded

  def install
    bin.install "chronograf-0.12.0-darwin_amd64" => "chronograf"
    etc.install "chronograf.toml"
  end

  plist_options :startup => true, :manual => "chronograf"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/chronograf</string>
          <string>-config</string>
          <string>#{HOMEBREW_PREFIX}/etc/chronograf.toml</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/chronograf.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/chronograf.log</string>
      </dict>
    </plist>
    EOS
  end

  def caveats; <<-EOS.undent
    To run Chronograf manually, you can specify the configuration file on the command line:
      chronograf -config=#{etc}/chronograf.toml
    EOS
  end

  test do
    system "#{bin}/chronograf", "--sample-config"
  end
end
