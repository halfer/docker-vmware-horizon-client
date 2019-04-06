FROM ubuntu:18.04

# Update OS
RUN apt-get update && apt-get upgrade -y
# Get image ready for installer
RUN apt-get install -y wget python
# Runtime dependencies
RUN apt-get install -y libcairo2 libpango-1.0-0 libxml2

# Install dependencies (move these to early in the Dockerfile)
RUN apt-get install -y libgtk2.0-0 libxss1 libxtst6 libxkbfile1

# A version 5 only appears to be available as a 32-bit installer at present
RUN wget https://download3.vmware.com/software/view/viewclients/CART19FQ4/VMware-Horizon-Client-4.10.0-11053294.x64.bundle
RUN chmod +x VMware-Horizon-Client-4.10.0-11053294.x64.bundle

# Accept licensing terms and choose options
# See more here: https://docs.vmware.com/en/VMware-Horizon-Client-for-Linux/5.0/horizon-client-linux-installation/GUID-A5A6332F-1DEC-4D77-BD6E-1362596A2E76.html
RUN ./VMware-Horizon-Client-4.10.0-11053294.x64.bundle \
    --eulas-agreed \
    --set-setting vmware-horizon-tsdr tsdrEnable no \
    --set-setting vmware-horizon-smartcard smartcardEnable no \
    --set-setting vmware-horizon-rtav rtavEnable no \
    --set-setting vmware-horizon-usb usbEnable no \
    --set-setting vmware-horizon-serialportclient serialportEnable no \
    --set-setting vmware-horizon-scannerclient scannerEnable no \
    --set-setting vmware-horizon-mmr mmrEnable no \
    --set-setting vmware-horizon-media-provider mediaproviderEnable no \
    --set-setting vmware-horizon-virtual-printing tpEnable no 

# This file only is a problem if x11docker is started with --xpra
RUN mkdir -p /etc/vmware/udpProxy && touch /etc/vmware/udpProxy/config

CMD ["vmware-view"]

