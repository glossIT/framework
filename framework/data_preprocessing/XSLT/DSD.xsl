<!-- 
    Project: GlossIT
    Author: Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Content: 
            Creates an Index HTML based on the Gloss / Textline in the Framework, where the Image of the resp. page is shown, with the snippet in question highlighted; 
            Tech Stack: XSLT; XPATH; HTML; Inline CSS; SVG; 
 -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:strip-space elements="*"/>
    <!-- File Variables -->     
    <xsl:variable name="folder">
        <xsl:value-of select="substring-after(base-uri(), 'Data/')"/>
    </xsl:variable>
    <xsl:variable name="filename" select="substring-before($folder, '/')"/>   
    <xsl:template match="*[@ana='view']">   
        <!-- Content Variables  --> 
        <xsl:variable name="lineID" select="substring-after(./@facs, '#')"/>
        <xsl:variable name="zone" select="ancestor::t:TEI//t:zone[@xml:id=$lineID]/@points"/>           
        <xsl:variable name="imagefile" select="ancestor::t:TEI//t:zone[@xml:id=$lineID]/parent::t:zone[@rendition='TextRegion']/preceding-sibling::t:graphic[1]/@url"/>
        <xsl:variable name="imageheight" select="ancestor::t:TEI//t:zone[@xml:id=$lineID]/parent::t:zone[@rendition='TextRegion']/preceding-sibling::t:graphic[1]/@height"/>
        <xsl:variable name="imagewidth" select="ancestor::t:TEI//t:zone[@xml:id=$lineID]/parent::t:zone[@rendition='TextRegion']/preceding-sibling::t:graphic[1]/@width"/>  
        <!-- Math Variables-->         
        <xsl:variable name="coords" select="(concat('-', translate(translate($zone, ' ', '-'), '-', '- '), '- '))"/>
        <xsl:variable name="X">
            <x>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-before(., ','))" order="ascending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-before(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>               
                </xsl:for-each>
            </x>
        </xsl:variable>
        <xsl:variable name="Xmin">
            <xsl:value-of select="concat('0.' ,number(substring-before($X, ',')))"/>
        </xsl:variable>
        <xsl:variable name="Y">
            <y>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-after(., ','))" order="ascending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-after(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </y>
        </xsl:variable>
        <xsl:variable name="Ymin">
            <xsl:value-of select="concat('0.' ,number(substring-before($Y, ',')))"/>
        </xsl:variable>
        <xsl:variable name="Xmax">
            <x>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-before(., ','))" order="descending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-before(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>                  
                </xsl:for-each>
            </x>
        </xsl:variable>
        <xsl:variable name="width">
            <xsl:value-of select="concat('0.', number(substring-before($Xmax, ',')) - number(substring-before($X, ',')))"/>
        </xsl:variable>
        <xsl:variable name="Ymax">
            <y>
                <xsl:for-each select="tokenize(translate($coords, '-', ' '))">
                    <xsl:sort select="number(substring-after(., ','))" order="descending"
                        data-type="number"/>
                    <xsl:value-of select="number(substring-after(., ','))"/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </y>
        </xsl:variable>
        <xsl:variable name="height">
            <xsl:value-of select="concat('0.0',number(substring-before($Ymax, ',')) - number(substring-before($Y, ',')))"/>
        </xsl:variable>            
        <!-- HTML Starter --> 
        <xsl:result-document href="{resolve-uri('index.html', base-uri())}" omit-xml-declaration="yes"> 
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <title>Glossit DSD</title> 
                </head>
                
                <body>
                    <div style="position:sticky; top: 0px; background:white;"><div style="display:flex;">
                        <img src="../img/Detective.png" height="130px" width="130px"/>
                        <div style="display:block;">
                            <h1>GlossIT DSD</h1>
                            <h2>Dörtl Snippet Detector</h2>
                        </div>
                     </div>
                    <div style="border-top:dotted;">
                         <div style="padding:10px;">
                             <p>
                                 <seg style="font-weight:bold;">Imagesnippet</seg> of 
                                 <seg style="font-weight:bold;"><xsl:value-of select="upper-case(./@type)"/></seg> with Line ID: 
                                 <u><xsl:value-of select="$lineID"/></u></p>
                             <p>
                                 <seg style="font-weight:bold;">Current Text</seg> in Snippet:  
                                 <em><xsl:value-of select="."/></em></p>
                             <p>
                                 <seg style="font-weight:bold;">Zoomfunction</seg>:   STRG +/- or STRG MOUSEWHEEL</p>
                         </div>                       
                    </div></div>
                    <section>
                        <div id="conainer"> 
                            <svg height="{$imageheight}" width="{$imagewidth}">
                                <title>ZOOM In and Out --> STRG +/- or STRG MOUSEWHEEL</title>
                                <!-- height="1200px" width="1064px" --> 
                                <image id="myimage" href="{concat('\\pers.ad.uni-graz.at\fs\ou\562\data\projekte\GlossIT\Data\IMG\', $filename, '\', $imagefile)}"/>                                 
                                
                                <rect width="{number(substring-before($Xmax, ',')) - number(substring-before($X, ','))}" height="{number(substring-before($Ymax, ',')) - number(substring-before($Y, ','))}" x="{number(substring-before($X, ','))}" y="{number(substring-before($Y, ','))}" style="fill:none;stroke-width:3;stroke:#03b6fc" />                            
                            </svg>                    
                        </div>
                    </section>
                </body>               
            </html>
       </xsl:result-document>
    </xsl:template>  
</xsl:stylesheet>

