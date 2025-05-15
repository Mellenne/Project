<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:XMP-dc="http://ns.exiftool.org/XMP/XMP-dc/1.0/"
    xmlns:XMP-photoshop="http://ns.exiftool.org/XMP/XMP-photoshop/1.0/"
    xmlns:IFD0="http://ns.exiftool.org/EXIF/IFD0/1.0/"
    xmlns:ExifTool="http://ns.exiftool.org/ExifTool/1.0/"
    xmlns:System="http://ns.exiftool.org/File/System/1.0/"
    exclude-result-prefixes="tei rdf XMP-dc XMP-photoshop IFD0 ExifTool System">

    <xsl:output method="html"/>

    <xsl:param name="css" select="'assets/css/'"/>
    <xsl:param name="image" select="'assets/img/'"/>
    <xsl:param name="preview" select="'assets/img/previews/'"/>
    <xsl:param name="xmlMetadata" select="'xml/'"/>


    <xsl:template match="tei:teiCorpus">
        
        <xsl:result-document href="index.html">
            <xsl:call-template name="generatePageStructure">
                <xsl:with-param name="pageTitle" select="'Om projektet'"/>
                <xsl:with-param name="corpusNode" select="."/>
                <xsl:with-param name="pageType" select="'index'"/>
                <xsl:with-param name="activePage" select="'index'"/>
            </xsl:call-template>
        </xsl:result-document>

        <xsl:result-document href="bertil.html">
            <xsl:call-template name="generatePageStructure">
                <xsl:with-param name="pageTitle" select="'Fotografen Bertil Dahlby'"/>
                <xsl:with-param name="corpusNode" select="."/>
                <xsl:with-param name="pageType" select="'bertil'"/>
                <xsl:with-param name="activePage" select="'bertil'"/>
            </xsl:call-template>
        </xsl:result-document>

        <xsl:result-document href="foto.html">
            <xsl:call-template name="generatePageStructure">
                <xsl:with-param name="pageTitle" select="'Fotografier'"/>
                <xsl:with-param name="corpusNode" select="."/>
                <xsl:with-param name="pageType" select="'foto'"/>
                <xsl:with-param name="activePage" select="'foto'"/>
            </xsl:call-template>
        </xsl:result-document>

        <xsl:apply-templates select="tei:TEI" mode="generateIndividualImagePage">
            <xsl:with-param name="corpusNode" select="."/>
        </xsl:apply-templates>
        
    </xsl:template>

    <xsl:template name="generatePageStructure">
        <xsl:param name="pageTitle"/>
        <xsl:param name="corpusNode"/>
        <xsl:param name="pageType"/> 
        <xsl:param name="activePage"/>
        <xsl:param name="imageNode" select="/.."/> <xsl:variable name="collectionTitle" select="$corpusNode/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>

        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text><xsl:text>&#xa;</xsl:text>
        <html lang="sv" xml:lang="sv">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title><xsl:value-of select="concat($pageTitle, $collectionTitle)"/></title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
                <link rel="stylesheet" href="{concat($css, 'main.css')}"/>
            </head>
            <body>
                <div class="container">
                    <header class="text-center mb-4 page-header">
                        <h1><xsl:value-of select="$collectionTitle"/></h1>
                        <p class="lead">Fotograf: <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName"/></p>
                    </header>

                    <nav class="nav justify-content-center mb-5 main-nav">
                        <a class="nav-link" href="index.html">
                            <xsl:if test="$activePage = 'index'"><xsl:attribute name="class">nav-link active</xsl:attribute></xsl:if>Om projektet
                        </a>
                        <a class="nav-link" href="bertil.html">
                             <xsl:if test="$activePage = 'bertil'"><xsl:attribute name="class">nav-link active</xsl:attribute></xsl:if>Fotografen Bertil Dahlby
                        </a>
                        <a class="nav-link" href="foto.html">
                             <xsl:if test="$activePage = 'foto'"><xsl:attribute name="class">nav-link active</xsl:attribute></xsl:if>Fotografier
                        </a>
                    </nav>

                    <main>
                        <xsl:choose>
                            <xsl:when test="$pageType = 'index'">
                                <xsl:call-template name="generateIndexContent">
                                    <xsl:with-param name="corpusNode" select="$corpusNode"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="$pageType = 'bertil'">
                                <xsl:call-template name="generateBertilContent">
                                    <xsl:with-param name="corpusNode" select="$corpusNode"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="$pageType = 'foto'">
                                <xsl:call-template name="generateFotoContent">
                                    <xsl:with-param name="corpusNode" select="$corpusNode"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="$pageType = 'individual_image'">
                                <xsl:call-template name="generateSingleImagePageContent">
                                    <xsl:with-param name="imageNode" select="$imageNode"/>
                                    <xsl:with-param name="corpusNode" select="$corpusNode"/>
                                </xsl:call-template>
                            </xsl:when>
                        </xsl:choose>
                    </main>

                    <xsl:call-template name="generateFooter">
                         <xsl:with-param name="publisherNodes" select="$corpusNode/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher/tei:persName"/>
                         <xsl:with-param name="publicationDate" select="$corpusNode/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date/@when"/>
                    </xsl:call-template>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="generateIndexContent">
        <xsl:param name="corpusNode"/>
        <div class="content-section" id="introduction_section_main">
            <h2>Om projektet Bertil Dahlbys bilder från Botkyrka kommun</h2>
            <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:encodingDesc/tei:projectDesc/tei:p"/>
            <hr/>
            <h2>Villkor för användning</h2>
            <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:principal" mode="intro-list"/>
            <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:editor" mode="intro-list"/>
            <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[descendant::tei:persName]" mode="intro-paragraph"/>
            <hr/>
            <h2>Botkyrka hembygdsgille</h2>
            <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:encodingDesc/tei:editorialDecl/tei:p"/>
            <hr/>
            <h3>Källbeskrivning (samlingen)</h3>
            <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p"/>
             <hr/>
            <h3>Skapande (originalfotografier)</h3>
            <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:profileDesc/tei:creation"/>
            <hr/>
            <h3>Rättigheter och Tillgänglighet</h3>
            <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability"/>
             <hr/>
            <h3>Nyckelord (samling)</h3>
            <xsl:apply-templates select="$corpusNode/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords" mode="intro-keywords"/>
        </div>
    </xsl:template>


    <xsl:template name="generateFotoContent">
        <xsl:param name="corpusNode"/>
        <div class="content-section">
            <div class="row">
                <xsl:for-each select="$corpusNode/tei:TEI">
                    <xsl:variable name="image_id" select="@xml:id"/>
                    <xsl:variable name="image_title" select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                    <xsl:variable name="image_preview_url" select="concat($previewImage, tei:facsimile/tei:surface/tei:figure/tei:graphic[@xml:id=concat($image_id,'_PRE')]/@url)"/>
                    <xsl:variable name="image_desc" select="tei:facsimile/tei:surface/tei:figure/tei:figDesc"/>
                    
                    <div class="col-md-4 col-sm-6 image-gallery-item text-center">
                        <figure>
                            <a href="{concat($image_id, '.html')}">
                                <img class="img-preview">
                                    <xsl:attribute name="src"><xsl:value-of select="$image_preview_url"/></xsl:attribute>
                                    <xsl:attribute name="alt"><xsl:value-of select="$image_desc"/></xsl:attribute>
                                    <xsl:attribute name="title">Klicka för mer information om: <xsl:value-of select="$image_title"/></xsl:attribute>
                                </img>
                            </a>
                            <figcaption class="mt-2">
                                <xsl:value-of select="$image_title"/>
                                <xsl:if test="tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords[2]/tei:list/tei:item[1]">
                                    <br/><small>(<xsl:value-of select="tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords[2]/tei:list/tei:item[1]"/>)</small>
                                </xsl:if>
                            </figcaption>
                        </figure>
                    </div>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="tei:TEI" mode="generateIndividualImagePage">
        <xsl:param name="corpusNode"/>
        <xsl:variable name="image_id" select="@xml:id"/>
        <xsl:variable name="html_filename" select="concat($image_id, '.html')"/>

        <xsl:result-document href="{$html_filename}">
             <xsl:call-template name="generatePageStructure">
                <xsl:with-param name="pageTitle" select="concat(tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title, ' - Bild - ')"/>
                <xsl:with-param name="corpusNode" select="$corpusNode"/>
                <xsl:with-param name="pageType" select="'individual_image'"/>
                <xsl:with-param name="activePage" select="'foto'"/> <xsl:with-param name="imageNode" select="."/> </xsl:call-template>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="generateSingleImagePageContent">
        <xsl:param name="imageNode"/>
        <xsl:param name="corpusNode"/>
        <xsl:variable name="image_id" select="$imageNode/@xml:id"/>

        <div class="row image-container">
            <div class="col-md-8"> <article class="scan">
                    <img class="img-fluid rounded border">
                        <xsl:attribute name="src">
                             <xsl:value-of select="concat($image, $imageNode/tei:facsimile/tei:surface/tei:figure/tei:graphic[@xml:id=concat($image_id,'_pub')]/@url)"/>
                        </xsl:attribute>
                        <xsl:attribute name="alt"><xsl:value-of select="$imageNode/tei:facsimile/tei:surface/tei:figure/tei:figDesc"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="$imageNode/tei:facsimile/tei:surface/tei:figure/tei:label"/></xsl:attribute>
                    </img>
                    <p class="mt-2"><small><xsl:value-of select="$imageNode/tei:facsimile/tei:surface/tei:figure/tei:figDesc"/></small></p>
                </article>
            </div>
            <div class="col-md-4">
                <article class="metadata-section">
                    <div class="metadata-block">
                        <h4>Information om bilden</h4>
                        <p><strong>Titel:</strong> <xsl:value-of select="$imageNode/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></p>
                        <p><strong>Fotograf:</strong> <xsl:apply-templates select="$imageNode/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName"/></p>
                        <xsl:apply-templates select="$imageNode/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p"/>
                    </div>
                    
                    <div class="metadata-block">
                        <h4>Nyckelord (bildspecifika)</h4>
                        <xsl:apply-templates select="$imageNode/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords" mode="image_keywords"/>
                    </div>

                    <xsl:variable name="metadata_file_ref_path_in_tei" select="$imageNode/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p/tei:ref[@type='application/rdf+xml']/@target"/>
                    <xsl:if test="$metadata_file_ref_path_in_tei">
                        <xsl:variable name="full_metadata_file_path" select="concat($xmlMetadata, $metadata_file_ref_path_in_tei)"/>
                        <xsl:variable name="metadata_doc" select="document($full_metadata_file_path)"/>
                        <xsl:if test="$metadata_doc">
                            <div class="metadata-block">
                                <h4>Teknisk metadata (från <xsl:value-of select="$metadata_file_ref_path_in_tei"/>)</h4>
                                <p><small>
                                ExifTool Version: <xsl:value-of select="$metadata_doc//ExifTool:ExifToolVersion"/>
                                <br/>Filnamn (original-TIF): <xsl:value-of select="$metadata_doc//System:FileName"/>
                                <br/>Dimensioner (TIF): <xsl:value-of select="$metadata_doc//IFD0:ImageWidth"/> x <xsl:value-of select="$metadata_doc//IFD0:ImageHeight"/> px
                                <br/>Upplösning (TIF): <xsl:value-of select="$metadata_doc//IFD0:XResolution"/> DPI
                                </small></p>
                            </div>
                        </xsl:if>
                        <xsl:if test="not($metadata_doc)">
                            <p><small>Kunde inte ladda teknisk metadata från <xsl:value-of select="$full_metadata_file_path"/>. Kontrollera sökvägen.</small></p>
                        </xsl:if>
                    </xsl:if>
                </article>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="generateFooter">
        <xsl:param name="publisherNodes"/>
        <xsl:param name="publicationDate"/>
        <footer class="text-center mt-5 pt-3 border-top">
            <p>
                <xsl:for-each select="$publisherNodes">
                    <xsl:apply-templates select="."/>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>.
                <xsl:value-of select="substring($publicationDate, 1, 4)"/>.
            </p>
            <p><small>TEI-kodning och presentation baserad på ImageCollectionTemplate (Mikael Gunnarsson, Wout Dillen), anpassad för detta projekt.</small></p>
        </footer>
    </xsl:template>

    <xsl:template match="tei:publisher | tei:principal | tei:editor" mode="intro-list">
        <p><strong><xsl:value-of select="concat(upper-case(substring(local-name(),1,1)), substring(local-name(),2))"/>:</strong>
            <xsl:for-each select="tei:persName | tei:orgName | tei:name">
                <xsl:apply-templates select="."/>
                <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>
        </p>
    </xsl:template>

    <xsl:template match="tei:respStmt" mode="intro-paragraph">
        <div>
            <p><strong><xsl:value-of select="tei:resp"/>:</strong>
            <xsl:for-each select="tei:persName | tei:orgName | tei:name">
                <xsl:apply-templates select="."/>
                <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>
            </p>
        </div>
    </xsl:template>

    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="tei:title[@level='u']">
        <em><xsl:text>"</xsl:text><xsl:apply-templates/><xsl:text>"</xsl:text>
        </em>
    </xsl:template>

    <xsl:template match="tei:persName | tei:orgName | tei:name">
        <xsl:choose>
            <xsl:when test="@ref">
                <a href="{@ref}" target="_blank" rel="noopener noreferrer">
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

     <xsl:template match="tei:ref[@type='application/rdf+xml']">
        <a href="{concat($xmlMetadata, @target)}" target="_blank" rel="noopener noreferrer">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="tei:ref[not(@type)]"> <a href="{@target}" target="_blank" rel="noopener noreferrer">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="tei:date">
        <xsl:choose>
            <xsl:when test="@when and normalize-space(.) != ''">
                 <xsl:value-of select="."/> (<xsl:value-of select="@when"/>)
            </xsl:when>
            <xsl:when test="@when">
                <xsl:value-of select="@when"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:teiHeader[parent::tei:TEI]"/>

</xsl:stylesheet>