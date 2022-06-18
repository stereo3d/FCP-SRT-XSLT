# FCP-SRT-XSLT
extraction of subtitles from and FCP xml using XSLT

The purpose of this SXLT Template is to extract individual subtitles from a final cut pro xml project.

1. select the fcp-xml input file
2. apply the sub_to_txt.xslt using a xslt processor

    for example xngr-editor 
    https://code.google.com/archive/p/exchangerxml/downloads

4. the result is a srt compatible subtitle file

for the conversation between frames and timecode in xml this code was used:
https://stackoverflow.com/questions/60974772/add-timecode-and-duration-in-xslt

