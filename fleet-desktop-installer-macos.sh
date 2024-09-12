#!/bin/sh

# Fleet Reloader function that can be used across other scripts that 
# require the Fleet Agent to restart in order to pick up changes
fleet_reloader()
{
   # Create the Fleet Agent Reloader Script
/bin/cat << 'EOF' > "/private/tmp/fleetreloader.sh"
#!/bin/sh
/bin/sleep 15
/bin/launchctl unload /Library/LaunchDaemons/com.fleetdm.orbit.plist
/bin/launchctl load /Library/LaunchDaemons/com.fleetdm.orbit.plist
# Unload Fleet Agent Reloader daemon
/bin/launchctl unload "/private/tmp/com.fleetdm.reload.plist" 
EOF

# Make script executable
/bin/chmod +x "/private/tmp/fleetreloader.sh"

# Create the Fleet Agent Reloader daemon
/bin/cat << 'EOF' > "/private/tmp/com.fleetdm.reload.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.fleetdm.reload</string>
        <key>ProgramArguments</key>
        <array>
            <string>/bin/sh</string>
            <string>/private/tmp/fleetreloader.sh</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>StandardErrorPath</key>
        <string>/dev/null</string>
        <key>StandardOutPath</key>
        <string>/dev/null</string>
    </dict>
</plist>
EOF

# Load Fleet Agent Reloader plist
/bin/launchctl load "/private/tmp/com.fleetdm.reload.plist"; 
}

### Start script ###
# Check if Fleet Agent is installed
if [ ! -f "/Library/LaunchDaemons/com.fleetdm.orbit.plist" ]; then
    echo "Fleet Agent is not installed."
    exit 1
else
    echo "Fleet Agent is installed. Continuing..."
fi

# Add Orbit Desktop Channel to Fleet Agent plist
/usr/bin/plutil -replace EnvironmentVariables.ORBIT_DESKTOP_CHANNEL -string "stable" /Library/LaunchDaemons/com.fleetdm.orbit.plist

# Enable Fleet Destop via Fleet Agent plist
/usr/bin/plutil -replace EnvironmentVariables.ORBIT_FLEET_DESKTOP -string "true" /Library/LaunchDaemons/com.fleetdm.orbit.plist

# Call Reloader function
fleet_reloader

exit 0
