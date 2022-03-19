# Google Cloud Internet Access Proxy Command Line Tool #

## Overview ##

* With no official tools available from Google and the IAP Desktop tool only available for Windows and limited to SSH and RDP tunnels only. My client's development team needed a cross platform tool to connect local administration tools such as SQL Studio Manager or PGAdmin etc to our virtual machines securely via the Internet Access Proxy. They also wanted the ability to use the local Windows Remote Desktop tool and local Visual Studio connected via SSH.
* Title:  EZYiD Google Cloud Internet Access Proxy
* Author: Ricky Elsum
* Language: Powershell

## Requirements ##

* Google Cloud SDK [https://cloud.google.com/sdk/docs/install]
* Microsoft Powershell [https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell]
* Google Cloud Internet Access Proxy [https://cloud.google.com/architecture/building-internet-connectivity-for-private-vms]
* To increase the performance of the tunnel, consider installing NumPy. To install
NumPy, see: [https://numpy.org/install/]
After installing NumPy, run the following command in Powershell to allow gcloud to access
external packages:
  $env:CLOUDSDK_PYTHON_SITEPACKAGES=1
