<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: GlossIT
    Author: Bernhard Bauer, Sina Krottmaier 
    Company: DDH (Department of Digital Humanities, University of Graz) 
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="* |@*">
        
        <!-- Copy All -->
        <xsl:copy>           
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="@*[name() = 'xsi:schemaLocation']">
     
        <xsl:attribute name="xsi:schemaLocation">
            <xsl:value-of select="'http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15 http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15/pagecontent.xsd'"/>
        </xsl:attribute>
           
        
    </xsl:template>
   <xsl:template match="//*/@type" name="custom">      
       <xsl:attribute name="custom">
           <xsl:value-of select="."/>
       </xsl:attribute>
    </xsl:template>
    <xsl:template match="@sanity"/>
</xsl:stylesheet>