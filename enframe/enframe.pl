use strict;
use Image::Magick;

use Image::Magick;
my $photo = new Image::Magick;
$photo->Read($ARGV[0]);
$photo->Quantize(colorspace=>'gray');
my $width = $photo->get('width');
my $border = int($width / 10);
my $side = int($width / 40);
$photo->Frame(width=>$border, height=>$border, inner=>$side, outer=>0, color=>'#202020');
my $newwidth = $photo->get('width');
my $ribon = new Image::Magick;
$ribon->Read('ribon.png');
$photo->Composite(image=>$ribon->Transform(geometry => $newwidth), compose=>'Over', x=>0, y=>0);
$photo->Write($ARGV[1]);
