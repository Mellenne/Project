<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:et="http://ns.exiftool.org/1.0/"
    xmlns:ExifTool="http://ns.exiftool.org/ExifTool/1.0/"
    xmlns:System="http://ns.exiftool.org/File/System/1.0/"
    xmlns:File="http://ns.exiftool.org/File/1.0/"
    xmlns:IFD0="http://ns.exiftool.org/EXIF/IFD0/1.0/"
    xmlns:XMP-x="http://ns.exiftool.org/XMP/XMP-x/1.0/"
    xmlns:XMP-dc="http://ns.exiftool.org/XMP/XMP-dc/1.0/"
    xmlns:XMP-photoshop="http://ns.exiftool.org/XMP/XMP-photoshop/1.0/"
    xmlns:XMP-xmpRights="http://ns.exiftool.org/XMP/XMP-xmpRights/1.0/"
    xmlns:Composite="http://ns.exiftool.org/Composite/1.0/"
    exclude-result-prefixes="tei rdf et ExifTool System File IFD0 XMP-x XMP-dc XMP-photoshop XMP-xmpRights Composite">

    <xsl:output method="html" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/tei:teiCorpus">
        <xsl:apply-templates select="tei:TEI"/>
    </xsl:template>

    <xsl:template match="tei:TEI">
        <xsl:variable name="filename" select="concat(@xml:id, '.html')"/>
        <xsl:variable name="metadata_file_path" select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p/tei:ref/@target"/>

        <xsl:result-document href="{$filename}" method="html">
            <html>
                <head>
                    <title><xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></title>
                    <link rel="stylesheet"
                        href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
                        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
                        crossorigin="anonymous"></link>
                    <link rel="stylesheet" href="assets/css/main.css"></link>
                </head>
                <body>
                    <div class="container">
                        <div class="row">
                            <div class="col-2"><a class="button-back button-default" href="foto.html"> Tillbaka </a></div>
                            <div class="col"><h1><xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></h1></div>
                        </div>
                    </div>
                    <div class="metadata-section">
                        
                        <h2>Metadata from TEI fil.xml</h2>
                        <p><span class="label">Publicering:</span> <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:p"/></p>
                        <p>
                            <span class="label">Källa:</span> <xsl:value-of select="normalize-space(tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p[1])"/>
                            <xsl:if test="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p/tei:ref">
                                (<a href="../collection/tei/{$metadata_file_path}"><xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p/tei:ref"/></a>)
                            </xsl:if>
                        </p>
                    </div>

                    <xsl:if test="$metadata_file_path != ''">
                        <div class="linked-metadata-section">
                            <h2>Teknisk Metadata från<xsl:value-of select="$metadata_file_path"/></h2>
                            <xsl:variable name="metadata_doc" select="document($metadata_file_path)"/>
                            <xsl:choose>
                                <xsl:when test="$metadata_doc">
                                    <table class="linked-meta">
                                        <tr><th>Property</th><th>Value</th></tr>
                                        <xsl:call-template name="meta-row">
                                            <xsl:with-param name="label">Creator</xsl:with-param>
                                            <xsl:with-param name="value" select="$metadata_doc/rdf:RDF/rdf:Description/XMP-dc:Creator"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="meta-row">
                                            <xsl:with-param name="label">Description</xsl:with-param>
                                            <xsl:with-param name="value" select="$metadata_doc/rdf:RDF/rdf:Description/XMP-dc:Description"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="meta-row">
                                            <xsl:with-param name="label">Rights</xsl:with-param>
                                            <xsl:with-param name="value" select="$metadata_doc/rdf:RDF/rdf:Description/XMP-dc:Rights"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="meta-row">
                                            <xsl:with-param name="label">Title (from XMP)</xsl:with-param>
                                            <xsl:with-param name="value" select="$metadata_doc/rdf:RDF/rdf:Description/XMP-dc:Title"/>
                                        </xsl:call-template>
                                         <xsl:call-template name="meta-row">
                                            <xsl:with-param name="label">Subject (from XMP)</xsl:with-param>
                                            <xsl:with-param name="value" select="$metadata_doc/rdf:RDF/rdf:Description/XMP-dc:Subject"/>
                                        </xsl:call-template>
                                         <xsl:call-template name="meta-row">
                                            <xsl:with-param name="label">Usage Terms</xsl:with-param>
                                            <xsl:with-param name="value" select="$metadata_doc/rdf:RDF/rdf:Description/XMP-xmpRights:UsageTerms"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="meta-row">
                                            <xsl:with-param name="label">Composite Image Size</xsl:with-param>
                                            <xsl:with-param name="value" select="$metadata_doc/rdf:RDF/rdf:Description/Composite:ImageSize"/>
                                        </xsl:call-template>
                                    </table>
                                    </xsl:when>
                                <xsl:otherwise>
                                    <p>Could not load metadata file: <xsl:value-of select="$metadata_file_path"/></p>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:if>

                    <div class="image-section">
                        <xsl:apply-templates select="tei:facsimile/tei:surface/tei:figure"/>
                    </div>

                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="meta-row">
        <xsl:param name="label"/>
        <xsl:param name="value"/>
        <xsl:if test="normalize-space($value)">
            <tr>
                <td><xsl:value-of select="$label"/></td>
                <td><xsl:value-of select="$value"/></td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:figure">
        <div>
            <h3><xsl:value-of select="tei:label"/></h3>
            <p><xsl:value-of select="tei:figDesc"/></p>
            <xsl:for-each select="tei:graphic[@xml:id[contains(., '_pub')]]">
                 <img src="{@url}" alt="{../tei:label}"/>
            </xsl:for-each>
        </div>
    </xsl:template>

</xsl:stylesheet>