<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'
    xmlns:XMP-exif='http://ns.exiftool.org/XMP/XMP-exif/1.0/'
    xmlns:IFD0='http://ns.exiftool.org/EXIF/IFD0/1.0/'
    xmlns:XMP-xmp='http://ns.exiftool.org/XMP/XMP-xmp/1.0/'
    xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs rdf tei IFD0 XMP-exif XMP-xmp html" version="1.0">
    <xsl:output method="html"/>

<xsl:template match="tei:teiCorpus"></xsl:template>
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text><xsl:text>&#xa;</xsl:text>
 <html lang="sv" xml:lang="sv">
            <head>
                <title>
                    Bertil Dahlbys bilder från Botkyrka kommun
            <xsl:value-of select="//tei:teiCorpus/tei:teiHeader//tei:title"/>
                </title>
                 <link rel="stylesheet"
                    href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
                    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
                    crossorigin="anonymous"/>

            <link rel="stylesheet" href="assets/css/main.css"/>
            </head>
 </html>


</xsl:stylesheet>