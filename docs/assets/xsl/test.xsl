<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/tei:teiCorpus">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <title>Metadata för: <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"/>
                <link rel="stylesheet" href="assets/css/main.css"/>
                <style>
                    body { padding: 20px; }
                    .metadata-section { margin-bottom: 30px; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }
                    .metadata-section h2 { margin-top: 0; border-bottom: 1px solid #eee; padding-bottom: 10px; }
                    .metadata-section h3 { margin-top: 20px; border-bottom: 1px dashed #eee; padding-bottom: 5px;}
                    dl { margin-bottom: 15px; }
                    dt { font-weight: bold; }
                    dd { margin-left: 20px; margin-bottom: 5px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <header>
                        <h1>Metadataöversikt</h1>
                    </header>
                    <nav id="sitenav">
                        <a href="index.html">Om projektet</a> | <a href="bertil.html">Fotografen Bertil Dahlby</a> | <a href="foto.html">Fotografier</a>
                    </nav>
                    
                    <main id="manuscript">
                        <xsl:apply-templates select="tei:teiHeader"/>
                        
                        <xsl:for-each select="tei:TEI">
                            <xsl:apply-templates select="."/>
                        </xsl:for-each>
                    </main>
                    
                    <footer>
                        <div class="row" id="footer">
                            <div class="col-sm copyright">
                                <div>
                                    <xsl:text>Genererad: </xsl:text>
                                </div>
                            </div>
                        </div>
                    </footer>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:teiCorpus/tei:teiHeader">
        <div class="metadata-section">
            <h2>Samlingsinformation: <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:title"/></h2>
            
            <dl>
                <dt>Fotograf:</dt>
                <dd><xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:author/tei:persName"/></dd>

                <dt>Tillgänglighet:</dt>
                <xsl:for-each select="tei:fileDesc/tei:publicationStmt/tei:availability/tei:p">
                    <dd><xsl:value-of select="normalize-space(.)"/></dd>
                </xsl:for-each>
            </dl>
            
            <h3>Projektbeskrivning</h3>
            <dl>
                <dt>Syfte:</dt>
                <dd><xsl:value-of select="normalize-space(tei:encodingDesc/tei:projectDesc/tei:p)"/></dd>
            </dl>
            
            <h3></h3>
            <dl>
                <dt>Nyckelord (Samling):</dt>
                <xsl:for-each select="tei:profileDesc/tei:textClass/tei:keywords/tei:list/tei:item">
                    <dd><xsl:value-of select="normalize-space(.)"/>
                        <xsl:if test="tei:ref/@target">
                            (<xsl:value-of select="tei:ref/@target"/>)
                        </xsl:if>
                    </dd>
                </xsl:for-each>
            </dl>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:TEI">
        <div class="metadata-section">
            <h3>Källbeskrivning (bild)</h3>
            <dl>
                <xsl:for-each select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p">
                    <dd>
                        <xsl:value-of select="normalize-space(text()[1])"/> <xsl:if test="tei:date">
                            <xsl:text> </xsl:text><xsl:value-of select="tei:date"/> (<xsl:value-of select="tei:date/@when"/>).
                        </xsl:if>
                        <xsl:value-of select="normalize-space(text()[2])"/> <xsl:if test="tei:ref">
                            Teknisk metadata: <a href="{tei:ref/@target}"><xsl:value-of select="tei:ref/@target"/></a>.
                        </xsl:if>
                        <xsl:value-of select="normalize-space(text()[last()])"/> </dd>
                </xsl:for-each>
            </dl>
            
            <h4>Profilbeskrivning (bild)</h4>
            <dl>
                <dt>Nyckelord (AAT):</dt>
                <xsl:for-each select="tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords[@scheme='https://www.getty.edu/research/tools/vocabularies/aat/']/tei:list/tei:item">
                    <dd><xsl:value-of select="normalize-space(tei:ref)"/> (<xsl:value-of select="tei:ref/@target"/>)</dd>
                </xsl:for-each>
                <dt>Övriga nyckelord:</dt>
                <xsl:for-each select="tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords[not(@scheme)]/tei:list/tei:item">
                    <dd><xsl:value-of select="normalize-space(.)"/></dd>
                </xsl:for-each>
            </dl>
            
            <h4>Bildrepresentation (Facsimile)</h4>
            <dl>
                <dt>Beskrivning (figDesc):</dt>
                <dd><xsl:value-of select="tei:facsimile/tei:surface/tei:figure/tei:figDesc"/></dd>
            </dl>
        </div>
    </xsl:template>
    
</xsl:stylesheet>