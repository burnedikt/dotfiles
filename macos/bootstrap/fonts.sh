#!/usr/bin/env bash

# this is the directory in which the font files reside
FONTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../fonts/ && pwd )"
# get list of fonts to be installed
fonts=`find $FONTS_DIR \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0 | xargs -0 basename`
# allow only newlines as separators ...
IFS=$'\n'
# ... when looping over the files
font_library=~/Library/Fonts
# counter variables
i=0
for font in $fonts; do
	# look for the font in the font folder
	if [[ -f $font_library/$font ]]; then
		continue
	else
		warn "$(printf "Font is missing: %b%s%b. Running fonts installer..." $ligh_yellow $font $reset_color)"
		# this is the directory in which this file resides
		source $FONTS_DIR/install.sh
		break
	fi
done
