#!/usr/bin/perl -wp
# Copyright 2008 Aleksander Adamowski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#		 http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Tue Jul 15 20:22:39 CEST 2008
# 
# Parses a .box training file and generates a continuous stream of characters
# That's easier to read and check for correctness.
# If you have multiple box training files for the same text but different images
# (e.g. different fonts), then you can also additionally chech that they are
# identical by comparing their output from this script (the utility doxdiff is 
# great for this).
# 
# Example usage:
#
# ./check_box.pl < sample_pl-part1-courier-digital_cam.box > sample_pl-part1-courier-digital_cam.check
# ./check_box.pl < sample_pl-part1-helvetica-digital_cam.box > sample_pl-part1-helvetica-digital_cam.check
# docdiff --utf8 --char --tty sample_pl-part1-courier-digital_cam.check sample_pl-part1-helvetica-digital_cam.check
#
# (spot the differences and fix them, then generate check files again:)
#
# ./check_box.pl < sample_pl-part1-courier-digital_cam.box > sample_pl-part1-courier-digital_cam.check
# ./check_box.pl < sample_pl-part1-helvetica-digital_cam.box > sample_pl-part1-helvetica-digital_cam.check
#
# (check that after fixing inconsistencies both check files are identical
# and their MD5 sums match:)
#
# md5sum sample_pl-part1-courier-digital_cam.check sample_pl-part1-helvetica-digital_cam.check
#
# (congratulations, you have double-checked your box training files for
# different fonts!)

BEGIN {
	use encoding "utf8";
}

{
	$_ =~ s/^([^\s]+).*$/$1/; chomp $_;
}

END {
	print "\n";
}
