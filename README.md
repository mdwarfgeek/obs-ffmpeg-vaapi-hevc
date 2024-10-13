Experimental OBS FFmpeg HEVC VAAPI plugin
=========================================

This was just a quick modification made to the standard OBS VA-API
plugin from plugins/obs-ffmpeg to test HEVC on Linux amdgpu.

The "install" target of the Makefile should put this in the correct
place under home directory when using Debian / Ubuntu obs packages to
get it loaded by OBS.  The Recording tab in the output settings should
then show "FFmpeg VAAPI HEVC" as an option.

It works for me, but YMMV.  CQP mode gave the best results for
recording 1080p60 on my card (RX 6600) where I was using qp=23.

It's otherwise unfinished.  I think a better way to do this if it's of
any use to others would be to make a patch to add HEVC as an option in
addition to H.264 in the standard OBS plugin and submit to them.

