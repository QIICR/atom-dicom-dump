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
1. Download and install DCMTK binaries for your system from
   http://dicom.offis.de/dcmtk.php.en (HINT: binaries of DCMTK command line tools are build and packaged with 3D Slicer (http://slicer.org) - you can install Slicer and point atom-dicom-dump to the subdirectory of 3D Slicer installation where dcmdump is located! For example, on Mac OS X it is /Applications/Slicer.app/Contents/bin)
2. Set the location of the DCMTK executables in the dicom-dump settings
3. After opening a DICOM file in Atom, use context meny to invoke dcmdump or
   dsrdump tools.

## Status

This package is work in progress. Contributions from the community in the form of encouragements, comments, feature requests, bug repots and pull requests are very welcome!

## Acknowledgment

This package is being developed by [Andrey Fedorov](https://github.com/fedorov) as part of the [QIICR](http://qiicr.org) project activities. QIICR is supported by NIH National Cancer Institute, award U24 CA180918. Please contact Andrey, join [QIICR community on Google+](https://plus.google.com/b/103730364707811819340/+QiicrOrg), or submit an issue on the issue tracker!

## Demo

![Screenshot](https://raw.githubusercontent.com/QIICR/atom-dicom-dump/master/screenshots/demo.gif)
