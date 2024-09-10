# Fleet Desktop Installer for macOS

This package will install and enable Fleet Desktop on your macOS devices that have already installed the Fleet Agent but without Fleet Desktop included. This package assumes you have already deployed the Fleet Agent without the "--fleet-desktop" flag present during initial package creation. You can choose to build this package yourself by creating a Fleet package with the --fleet-desktop flag included (ex:`fleetctl package --type=pkg --enable-scripts --fleet-desktop --fleet-url=https://yourfleeturl.com --enroll-secret=yourenrollmentsecret`), installing that package, copying the contents of /opt/orbit/bin/desktop, and deploying it alongside the preinstall and postinstall scripts found in this repo. 

Package Contents:
<img width="1097" alt="Screenshot 2024-09-10 at 12 42 28 PM" src="https://github.com/user-attachments/assets/8e428d85-73e9-4479-859c-6ac490a5c3ea">

Package Resources: 
<img width="1015" alt="Screenshot 2024-09-10 at 12 42 40 PM" src="https://github.com/user-attachments/assets/cf268dab-7494-413a-8497-29da88edabad">
