Docker VMware Horizon Client
===

Introduction
---

This is a partial solution to Dockerising the VMWare Horizon Client for Linux. It installs and
satisfies all dependencies in Linux, but as yet I have not tried attaching it to a display. That's
the next bit!

To build this, run:

    docker build -t docker-vmware-horizon-client .

To run the client, it will be something like this:

    docker run -it docker-vmware-horizon-client

However, this will not work on its own - see below. This will need a `DISPLAY` variable setting up,
and some work to see up a frame buffer.

If there is demand for this, please do raise a ticket here - I'd be happy to collaborate.

Research
---

I am using [this project](https://github.com/mviereck/x11docker) to set up the display. There are a lot
of driver options to look into.

I installed these items in the host:

    sudo apt-get install xvfb xpra

I then got a GUI window operational using this:

    ./x11docker docker-vmware-horizon-client --nxagent

The `--nxagent` switch is the closest I've got it working. Dropping this will fall back to xpra, but
that does not currently work.

My progress is that I can see the VMWare client window, with an "Add server" button, but when I try to
add a server, I get a crash:

```
xargs: strings: No such file or directory
Using log file /tmp/vmware-<username>/vmware-horizon-client-123.log
2019-04-06 17:20:02.026+01:00: vmware-view 123| access fail
2019-04-06 17:20:02.061+01:00: vmware-view 123| Failed to get UDPProxy_RunInBackground symbol, exiting.
2019-04-06 17:20:02.061+01:00: vmware-view 123| UdpProxyImpl_LoadDynamicLibrary failed for libudpProxyLib.so
2019-04-06 17:20:02.061+01:00: vmware-view 123| Failed to create a UDP proxy instance
2019-04-06 17:20:02.136+01:00: vmware-view 123| Not valid URL 'Add Server'
```

It may be possible to add a server using args to the binary, rather than through the GUI - however it is
odd that the placeholder text 'Add Server' gets treated as a URL - I wonder if this Linux client does not
get as much polish as its Windows counterpart.

Pre-configuring a server
---

I have tried changing the image using this:

    CMD ["vmware-view", "-s", "horizon.server.example.org"]

This requires a Docker build and client re-launch. That results in the server appearing in the client list,
but when I double-click on it, I get this crash:

```
xargs: strings: No such file or directory
Using log file /tmp/vmware-<username>/vmware-horizon-client-120.log
2019-04-06 18:13:43.688+01:00: vmware-view 120| access fail
2019-04-06 18:13:43.723+01:00: vmware-view 120| Failed to get UDPProxy_RunInBackground symbol, exiting.
2019-04-06 18:13:43.723+01:00: vmware-view 120| UdpProxyImpl_LoadDynamicLibrary failed for libudpProxyLib.so
2019-04-06 18:13:43.723+01:00: vmware-view 120| Failed to create a UDP proxy instance
/usr/bin/vmware-view: line 142:   120 Segmentation fault      (core dumped) "$binPath/bin/$binFile" "$@"
```

Other items to try
---

* The x11docker project with the `--xephyr` display driver
* Do more reading of the Linux client docs, there may be clues in there
* Maybe the command of `vmware-view` is not the correct binary to start on?
* Ask a question at the [Horizon community](https://communities.vmware.com/community/vmtn/horizon/content?filterID=contentstatus%5Bpublished%5D%7Eobjecttype%7Eobjecttype%5Bthread%5D)

License
---

My work here, excluding the proprietary downloaded code, is given away under the MIT License.

Small print
---

In this repo I am accepting the License Agreement of proprietary software for you. If you use this
Docker image, I expect the makers of the software will take it that you have agreed with their
terms implicitly. Use at your own risk! `:-)`

