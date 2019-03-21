#!/usr/bin/env ruby
require 'flammarion'
def previewVideo()
  system('ffmpeg -f lavfi -i life -f nut -vf scale=620X480 - | ffplay -f lavfi "movie=\'pipe\:0\',split=2[a][b],[b]waveform=intensity=0.1:mode=column:mirror=1:c=1:f=lowpass:e=instant:graticule=green:flags=numbers+dots,scale=620x480[bb],[a][bb]hstack[out0]"')
end

def recordVideo()
  puts 'Hello'
end

f = Flammarion::Engraving.new
f.button("Preview Video") { previewVideo() }
f.wait_until_closed

# Osprey Command
# ffmpeg -f dshow -pixel_format yuyv422 -i video="Osprey-827e MFI Video Device 1":audio="Unbal Input 1 (Osprey-827e 1)" -color_primaries smpte170m -color_trc bt709 -colorspace smpte170m -c:a pcm_s24le -c:v ffv1 -level 3 -g 1 -slices 16 -slicecrc 1 -vf setsar=40/27,setdar=4/3,setfield=bff,fieldorder=bff -y OUTPUT -f nut -vf setsar=40/27,setdar=4/3 - | ffplay -
