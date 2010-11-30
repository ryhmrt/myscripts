#!/usr/bin/env perl -w

use strict;
use Image::Magick;
use Image::ExifTool;

use Image::Magick;
my $exifTool = new Image::ExifTool;
my $exifInfo = $exifTool->ImageInfo($ARGV[0], 'Orientation');
my $rotation = $$exifInfo{Orientation};
my $photo = new Image::Magick;
$photo->Read($ARGV[0]);
$photo->Rotate(degrees => 90 ) if ($rotation && $rotation eq 'Rotate 90 CW');
$photo->Rotate(degrees => 180 ) if ($rotation && $rotation eq 'Rotate 180');
$photo->Rotate(degrees => 270 ) if ($rotation && $rotation eq 'Rotate 270 CW');
$photo->Strip();
my $width = $photo->get('width');
my $border = int($width / 10);
my $side = int($width / 40);
$photo->Frame(width=>$border, height=>$border, inner=>$side, outer=>0, color=>'#202020');
my $newwidth = $photo->get('width');
my $ribon = new Image::Magick;
$ribon->Read('ribon.png');
$photo->Composite(image=>$ribon->Transform(geometry => $newwidth), compose=>'Over', x=>0, y=>0);
$photo->Quantize(colorspace=>'gray');
$photo->Write($ARGV[1]);

