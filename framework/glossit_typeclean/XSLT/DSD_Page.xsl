<!-- 
    Project: GlossIT
    Author: Sina Krottmaier
    Company: DDH (Department of Digital Humanities, University of Graz) 
    Content: 
            Creates an Index HTML based on the Gloss / Textline in the Framework, where the Image of the resp. page is shown, with the snippet in question highlighted; 
            Tech Stack: XSLT; XPATH; HTML; Inline CSS; SVG; 
            
            ToDo: Add Zoom Function; Add Infos in sidenav
 -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:pg="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:strip-space elements="*"/>
    <!-- File Variables -->     
    <xsl:variable name="filepath">
        <xsl:value-of select="base-uri()"/>
    </xsl:variable>
    <xsl:variable name="imagepath">
        <xsl:value-of select="replace($filepath, 'xml', 'jpg')"/>
    </xsl:variable><xsl:variable name="imagewidth" select="//pg:Page/@imageWidth"/>
    <xsl:variable name="imageheight" select="//pg:Page/@imageHeight"/>
    
    <xsl:template match="*[@ana='view']">   
        <!-- Content Variables  --> 
        <xsl:variable name="lineID" select="@id"/>       

        <!-- HTML Starter --> 
        <xsl:result-document href="{resolve-uri('index.html', base-uri())}" omit-xml-declaration="yes"> 
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <title>Glossit DSD</title> 
                </head>
                <style>
                    .sidenav {
                  
                    height: 100%;
                    width: 200px;
                    position: fixed;
                    z-index: 1;
                    top: 0;
                    left: 0;
                    background-color: #111;
                    /*overflow-x: hidden;*/
                    padding-top: 20px;
                    
                    }
                
                    .main {
                    margin-left: 200px; /* Same as the width of the sidenav */
                   
                    padding: 0px 10px;
                    
                    }
                    img {
                    border-radius: 8px;
                    border: 3px solid #03b6fc;
                    margin-left: 25px;}
                    
                    .brand {
                    color: #03b6fc;
                    font-family: monospace;
                    font-size: 2em;
                    font-weight: bold;
                    padding-top: 1px;
                    margin-left: 15px;}
                    
                    
                    .brandname {
                    color: grey;
                    font-family: monospace;
                    font-size: small;
                    font-weight: bold;
                    padding-top: 1px;
                    margin-left: 33px;}
                    
                </style>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
                
                
                <body>
                  <div class="sidenav">
                   <div class="head">
                    <p class="brand"> GlossIT DSD</p>
                    <p><img src="../../FW-satellite/Detective.png" height="130px" width="130px"/></p> <!-- Change path to correct nextcloud path --> 
                       <p class="brandname">Dörtl Snippet Detector</p></div>
                    </div>
                    <div class="info"></div>
                    <div class="zoom"></div>
                   <!--
                    <div style="border-top:dotted;">
                         <div style="padding:10px;">
                             <p>
                                 <seg style="font-weight:bold;">Highlight</seg> of Line  
                                 <u><xsl:value-of select="$lineID"/></u></p>
                             <p></p><seg style="font-weight:bold;"><xsl:value-of select="upper-case(./@type)"/></seg> with
                             <p>
                                 <seg style="font-weight:bold;">Current Text</seg> in Snippet:  
                                 <em><xsl:value-of select="."/></em></p>
                             <p>
                                 <seg style="font-weight:bold;">Zoomfunction</seg>:   STRG +/- or STRG MOUSEWHEEL</p>
                         </div>                       
                    </div>
                    </div>-->
                
                        <div id="container" class="main"> 
                            <svg viewbox="{concat('0', ' 0 ', $imagewidth, ' ',$imageheight)}">
                                <title>ZOOM In and Out --> STRG +/- or STRG MOUSEWHEEL</title>
                                <!-- height="1200px" width="1064px" --> 
                                <image id="myimage" href="{$imagepath}"/>                                 
                                <polygon id="One"
                                    points="{./pg:Coords/@points}" style="fill:none;stroke:#03e0fc;stroke-width:5;"></polygon>
                                <!--<rect width="{number(substring-before($Xmax, ',')) - number(substring-before($X, ','))}" height="{number(substring-before($Ymax, ',')) - number(substring-before($Y, ','))}" x="{number(substring-before($X, ','))}" y="{number(substring-before($Y, ','))}" style="fill:none;stroke-width:3;stroke:#03b6fc" />-->                            
                            </svg>                    
                        </div>
                    <script>
                        $(document).ready(function () {            
                        $(' body').animate({
                        scrollTop: $('#One').offset().top
                        }, 'slow');
                        });   
                    </script>
                </body>               
            </html>
       </xsl:result-document>
    </xsl:template>  
</xsl:stylesheet>

