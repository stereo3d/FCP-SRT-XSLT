# FCP-SRT-XSLT
rudimentary script for extraction of subtitles from and FCP xml using XSLT

The purpose of this SXLT Template is to extract individual subtitles from a final cut pro xml project.
This transformation can be useful to import subtitles as .srt in DaVinci Resolve for exemple.

1. select the fcp-xml input file
2. apply the sub_to_txt.xslt using a xslt processor

    for example xngr-editor 
    https://code.google.com/archive/p/exchangerxml/downloads

4. the result is a srt compatible subtitle file

for the conversation between frames and timecode in xml this code was used:
https://stackoverflow.com/questions/60974772/add-timecode-and-duration-in-xslt

Limitations: the last of the time code is the frame number. In SRT it is milliseconds. This script does not properly calculate the milliseconds. In order get the correct time code, adjust the parameter "fps" to the appropriate speed.

# FCP XML

the FCP XML contains a generator item such as:

```xml
<generatoritem id="Texte avec bordure">
					<name>Texte avec bordure</name>
					<duration>7200</duration>
					<rate>
						<ntsc>TRUE</ntsc>
						<timebase>60</timebase>
					</rate>
					<in>4495</in>
					<out>4625</out>
					<start>8897</start>
					<end>9027</end>
					<enabled>TRUE</enabled>
					<anamorphic>FALSE</anamorphic>
					<alphatype>black</alphatype>
					<effect>
						<name>Texte avec bordure</name>
						<effectid>Outline Text</effectid>
						<effectcategory>Texte</effectcategory>
						<effecttype>generator</effecttype>
						<mediatype>video</mediatype>
						<parameter>
```

# XSLT Template

The template seaches for the parent of Outline Text

```xml
effect[effectid='Outline Text']/..
```

the result of the transformation is a plain text text file in .srt format.
This format can be opened by DaVinci Resolve or many other Programs.

```xml  
	<xsl:param name="fps" select="59.94"/>
	<xsl:template match="/">
		<xsl:for-each select="/xmeml/sequence/media/video/track/generatoritem/effect[effectid='Outline Text']/..">
			<xsl:variable name="i" select="position()"/>
			<xsl:value-of select="$i"/>
			<xsl:text>&#10;</xsl:text>
			<xsl:call-template name="frames-to-timecode">
				<xsl:with-param name="frames" select="start"/>
			</xsl:call-template>
			<xsl:text>&#32;--&gt;&#32;</xsl:text>
			<xsl:call-template name="frames-to-timecode">
				<xsl:with-param name="frames" select="end"/>
			</xsl:call-template>
			<xsl:text>&#10;</xsl:text>
			<xsl:for-each select="./effect/parameter/name[text()='Texte']/..">
				<xsl:value-of select="value"/>
				<xsl:text>&#10;</xsl:text>
			</xsl:for-each>
			<xsl:text>&#10;</xsl:text>
		</xsl:for-each>
	</xsl:template>
    
 ```
# Result .SRT

The result of the template matching is a plain text file following the SRT syntax.

```srt
1
00:02:28,026 --> 00:02:30,036
In the south,
Busan was one of the last stops

2
00:02:30,053 --> 00:02:36,046
on the Donghae-Nambu line,
just after Busanjin station.

3
00:02:36,046 --> 00:02:42,035
To the north of the line,
you could reach Gangwon province.
```

    
