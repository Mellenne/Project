<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <title><xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"/>
                <link rel="stylesheet" href="assets/css/main.css"/>
            </head>
            <body>
                <header>
                    <h1><xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></h1>
                </header>
                <nav id="sitenav">
                    <a href="index.html">Om projektet</a> | <a href="bertil.html">Fotografen Bertil Dahlby</a> | <a href="foto.html">Fotografier</a>
                </nav>
                <main id="manuscript">
                    <div class="container">
                        <div class="row">
                            <div class="column-25"></div>
                            <div class="column">
                                <p class="text-special"></p> </div>
                            <div class="column-25"></div>
                        </div>
                        
                        <ul class="gallery">
                            <xsl:apply-templates select="//tei:TEI"/>
                        </ul>
                    </div>
                </main>
                <footer>
                    <div class="row" id="footer">
                        <div class="col-sm copyright">
                            <div></div>
                            <div>
                                <xsl:text>2025 </xsl:text>
                                <xsl:for-each select="//tei:teiHeader/tei:fileDesc/tei:editor/tei:persName">
                                    <xsl:value-of select="."/>
                                    <xsl:if test="position() != last()">, </xsl:if>
                                </xsl:for-each>
                                <xsl:text>.</xsl:text>
                            </div>
                        </div>
                    </div>
                </footer>
                <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:TEI">
        <li>
            <a href="{concat(@xml:id, '_F.html')}">
                <xsl:variable name="preview_image_path">
                    <xsl:value-of select="tei:facsimile/tei:surface/tei:figure/tei:graphic[@xml:id=concat(current()/@xml:id,'_PRE')]/@url"/>
                </xsl:variable>
                <img src="{$preview_image_path}" alt="{tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title}"/>
            </a>
            <div class="desc">
                <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
            </div>
        </li>
    </xsl:template>
    
</xsl:stylesheet>