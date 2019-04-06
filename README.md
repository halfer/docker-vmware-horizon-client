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

    docker run -it docker-vmware-horizon-client vmware-view

However, I expect I will meld the `vmware-view` into the `CMD` (rather than a shell) once I have
figured out how to attach it to a `DISPLAY`.

If there is demand for this, please do raise a ticket here - I'd be happy to collaborate.

License
---

My work here, excluding the proprietary downloaded code, is given away under the MIT License.

Small print
---

In this repo I am accepting the License Agreement of proprietary software for you. If you use this
Docker image, I expect the makers of the software will take it that you have agreed with their
terms implicitly. Use at your own risk! `:-)`

