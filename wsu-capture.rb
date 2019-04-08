#!/usr/bin/env ruby

require 'flammarion'

def getOutputDir()
  if Gem.win_platform?
    @outputDir = `powershell "Add-Type -AssemblyName System.windows.forms|Out-Null;$f=New-Object System.Windows.Forms.FolderBrowserDialog;$f.SelectedPath = 'C:\';$f.Description = 'Select Output Directory';$f.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true }))|Out-Null;$f.SelectedPath"`.strip + '\\'
  else
    @outputDir = `zenity --file-selection --directory`.strip + '/'
  end
end

def previewVideo()
  system('.\\ffplay -f dshow -pixel_format yuv420p -i video="Osprey-827e MFI Video Device 1":audio="Unbal Input 1 (Osprey-827e 1)" -vf setsar=40/27,setdar=4/3,split=2[a][b],[b]format=pix_fmts=yuv420p,waveform=intensity=0.1:mode=column:mirror=1:c=1:f=lowpass:e=instant:graticule=green:flags=numbers+dots,scale=720x480[bb],[a][bb]hstack')
end

def recordVideo()
  if @outputDir.nil?
    $window.alert("Please select an output location!")
    getOutputDir()
  end
  outputFileName = $window.gets("Please Enter Output Name")
  outputFile = @outputDir + outputFileName + '.mkv'
  derivativeFile = @outputDir + outputFileName + '.mp4'
  if File.exist?(outputFile)
    $window.alert("A file with that name already exists!")
  else
    system('.\\ffmpeg -f dshow -pixel_format yuv420p -i video="Osprey-827e MFI Video Device 1":audio="Unbal Input 1 (Osprey-827e 1)" -color_primaries smpte170m -color_trc bt709 -colorspace smpte170m -c:a pcm_s24le -c:v ffv1 -level 3 -g 1 -slices 16 -slicecrc 1 -vf setsar=40/27,setdar=4/3,setfield=bff,fieldorder=bff -y ' + '"' + outputFile + '"' + ' -f nut -vf setsar=40/27,setdar=4/3 -async 1 -vsync 1 - | .\\ffplay -')
    $window.alert("Making Derivatives")
    system('.\\ffmpeg -i ' + '"' + outputFile + '"' + ' -c:v libx264 -c:a aac -movflags +faststart -crf 18 -b:a 128k -preset fast -vf "yadif,format=yuv420p" ' + derivativeFile)
    $window.alert("Derivatives Finished!")
  end
end

def editSettings()
  system('.\\ffmpeg -show_video_device_dialog true -f dshow -i video="Osprey-827e MFI Video Device 1" -t 0.1 -f null -')
end

def openDocs()
  if Gem.win_platform?
    system("start https://github.com/WSU-CDSC/wsu-capture/blob/master/Instructions.md")
  elsif RUBY_PLATFORM.include?("linux")
    system("xdg-open https://github.com/WSU-CDSC/wsu-capture/blob/master/Instructions.md")
  elsif RUBY_PLATFORM.include?("darwin")
    system("open https://github.com/WSU-CDSC/wsu-capture/blob/master/Instructions.md")
  end
end

# Create GUI Window

$window = Flammarion::Engraving.new
$window.image("https://brand.wsu.edu/wp-content/themes/brand/images/pages/logos/wsu-shield-mark.svg")
$window.title("Welcome to WSU-Capture")
$window.button("Open Help") { openDocs() }
$window.button("Choose Save Location") { getOutputDir() }
$window.button("Capture Card Settings") { editSettings() }
$window.button("Preview Video") { previewVideo() }
$window.button("Record Video") { recordVideo() }
$window.checkbox("Film Source")
$window.wait_until_closed

# Osprey Command
# testing cam device Logitech HD Webcam C615
# Actual Devices
# video - Osprey-827e MFI Video Device 1
# audio - Unbal Input 1 (Osprey-827e 1)
# Actual pix_fmt -pixel_format yuyv422
