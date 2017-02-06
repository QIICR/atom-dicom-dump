# DICOM viewer for [Atom](http://atom.io)

## Overview

This package provides a point-and-click interface for exploring the content of [DICOM](http://dicom.nema.org/) files. At the moment, the functionality provided is allowing to run [DCMTK](http://dicom.offis.de/dcmtk.php.en) command-line tools [dcmdump](http://support.dcmtk.org/docs/dcmdump.html) and [dsrdump](http://support.dcmtk.org/docs/dsrdump.html).

By using this Atom package instead of running the DCMTK tools in the command
line, you can:

* conveniently copy content to the clipboard
* do folding of the indented sections of the dump
* search for content of interest
* add a lot more features using powerful Atom engine ;)

## Usage

0. Install the package from Atom > Settings > Install
1. Install DCMTK on your system:
 * **Windows**: you can download pre-compiled DCMTK binaries from
   https://github.com/QIICR/dcmtk-dcmqi/releases (here is the [direct download link](https://github.com/QIICR/dcmtk-dcmqi/releases/download/DCMTK-dcmqi-3.6.1_20161102-VS12-Win64-Release-v0.0.11-static/DCMTK-dcmqi.zip)). You will also need to download and install [Visual C++ Redistributable Packages for Visual Studio 2013](http://www.microsoft.com/en-us/download/details.aspx?id=40784). `DCMTK_PATH` should point to the `bin` folder inside the unzipped `DCMTK-dcmqi.zip` package. Note that you will not be able to use DCMTK binaries from 3D Slicer (the approach discussed below for Mac and Lunux will not work on Windows!)
 * **Mac**: you can download and install [3D Slicer application](http://download.slicer.org) package for Mac, which contains pre-compiled DCMTK tools. If you install 3D Slicer into the standard system location, `DCMTK_PATH` should point to `/Applications/Slicer.app/Contents/bin`
 * **Linux**: you can download and install [3D Slicer application](http://download.slicer.org) for Linux, which contains pre-compiled DCMTK tools. `DCMTK_PATH` should point to the `bin` directory inside the unzipped Linux package of 3D Slicer.
2. Set the location of the DCMTK executables to `DCMTK_PATH` specific to your system in the dicom-dump package settings
3. After opening a DICOM file in Atom, use context menu to invoke `dcmdump` or `dsrdump` tools.

## Status

This package is work in progress. Contributions from the community in the form of encouragements, comments, feature requests, bug repots and pull requests are very welcome!

## Acknowledgment

This package is being developed by [Andrey Fedorov](https://github.com/fedorov) as part of the [QIICR](http://qiicr.org) project activities. QIICR is supported by NIH National Cancer Institute, award U24 CA180918. Please contact Andrey, join [QIICR community on Google+](https://plus.google.com/b/103730364707811819340/+QiicrOrg), or submit an issue on the issue tracker!

## Demo

![Screenshot](https://raw.githubusercontent.com/QIICR/atom-dicom-dump/master/screenshots/demo.gif)
