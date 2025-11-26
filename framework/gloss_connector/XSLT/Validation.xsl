<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="* | @*">
             
        <!-- Copy All -->
        <xsl:copy>           
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="t:gloss[child::t:gloss]">      
       <gloss rendition="{@rendition}" n="{./child::*[1]/@n}">
           <xsl:attribute name="facs">
               <xsl:for-each select="./child::*/@facs">
                   <xsl:value-of select="concat(., ' ')"/>
               </xsl:for-each>
              
                   
           </xsl:attribute>
           <xsl:value-of select="./text()[1]"/>
           <xsl:text> </xsl:text>
           <xsl:for-each select="./t:gloss">
               <lb/><xsl:value-of select="./text()"/>
           </xsl:for-each>
           
       </gloss>       
    </xsl:template>
</xsl:stylesheet>
