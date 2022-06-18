<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
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
	<xsl:template name="timecode-to-frames">
		<xsl:param name="timecode"/>
		<xsl:variable name="hh" select="substring($timecode, 1, 2)"/>
		<xsl:variable name="mm" select="substring($timecode, 4, 2)"/>
		<xsl:variable name="ss" select="substring($timecode, 7, 2)"/>
		<xsl:variable name="ff" select="substring($timecode, 10, 2)"/>
		<xsl:value-of select="$fps * (3600 * $hh + 60 * $mm + $ss) + $ff"/>
	</xsl:template>
	<xsl:template name="frames-to-timecode">
		<xsl:param name="frames"/>
		<xsl:variable name="seconds" select="floor($frames div $fps)"/>
		<xsl:variable name="h" select="floor($seconds div 3600) mod 24"/>
		<xsl:variable name="m" select="floor($seconds div 60) mod 60"/>
		<xsl:variable name="s" select="$seconds mod 60"/>
		<xsl:variable name="f" select="$frames mod $fps"/>
		<xsl:value-of select="format-number($h, '00')"/>
		<xsl:value-of select="format-number($m, ':00')"/>
		<xsl:value-of select="format-number($s, ':00')"/><xsl:text>,</xsl:text>
		<xsl:value-of select="format-number($f, '000')"/>
	</xsl:template>
</xsl:stylesheet>