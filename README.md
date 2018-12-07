# DICOM viewer for [Atom](http://atom.io)

## Overview

This package provides a point-and-click interface for exploring the content of [DICOM](http://dicom.nema.org/) files. At the moment, the functionality provided is allowing to run [DCMTK](http://dicom.offis.de/dcmtk.php.en) command-line tools [dcmdump](http://support.dcmtk.org/docs/dcmdump.html) and [dsrdump](http://support.dcmtk.org/docs/dsrdump.html), and [GDCM](http://gdcm.sourceforge.net) [gdcmdump](http://gdcm.sourceforge.net/html/gdcmdump.html) tool (gdcmdump provides functionality not available in dcmdump, such as view of the Siemens CSA header).

By using this Atom package instead of running the DCMTK tools in the command
line, you can:

* conveniently copy content to the clipboard
* do folding of the indented sections of the dump
* search for content of interest
* add a lot more features using powerful Atom engine ;)

## Usage

### Install the package

Install the package from Atom > Settings > Install

### Install DCMTK and/or GDCM

You can download precompiled DCMTK packages from the official DCMTK page here:

 http://dcmtk.org/dcmtk.php.en (look for the "DCMTK 3.6.2 - executable binaries" section)

 If you cannot find the binary for your platform, you can use the following links for downloading unofficial DCMTK binaries we prepared. All of them are for 64-bit platforms.
 * [DCMTK binaries for Windows](https://github.com/QIICR/dcmtk-dcmqi/releases/download/0d2826645/dcmtk-Win64-0d2826645.zip)
 * [DCMTK binaries for Linux](https://github.com/QIICR/dcmtk-dcmqi/releases/download/0d2826645/dcmtk-Linux-0d2826645.zip)
 * [DCMTK binaries for macOS](https://github.com/QIICR/dcmtk-dcmqi/releases/download/0d2826645/dcmtk-macOS-0d2826645.zip)

 We do not provide the binaries to download packages of GDCM for individual platforms, you can check SourceForge for binaries here: https://sourceforge.net/projects/gdcm/.

### Set paths to the tools in the package settings

![Screenshot](https://raw.githubusercontent.com/QIICR/atom-dicom-dump/master/screenshots/dcmtk_path_settings.jpg)

### Activate package after opening a DICOM file

After opening a DICOM file in Atom, use context menu to invoke `dcmdump`, `dsrdump` or `gdcmdump` tools.

## Status

This package is work in progress. Contributions from the community in the form of encouragements, comments, feature requests, bug repots and pull requests are very welcome!

## Acknowledgment

This package is being developed by [Andrey Fedorov](https://github.com/fedorov) as part of the [QIICR](http://qiicr.org) project activities. QIICR is supported by NIH National Cancer Institute, award U24 CA180918. Please contact Andrey, join [QIICR community on Google+](https://plus.google.com/b/103730364707811819340/+QiicrOrg), or submit an issue on the issue tracker!

## Demo

![Screenshot](https://raw.githubusercontent.com/QIICR/atom-dicom-dump/master/screenshots/demo.gif)
