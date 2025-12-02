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
    </xsl:variable>
    <xsl:variable name="imagewidth" select="//pg:Page/@imageWidth"/>
    <xsl:variable name="imageheight" select="//pg:Page/@imageHeight"/>
    <xsl:template match="*[@ana = 'view']">
        <!-- Content Variables  -->

            <xsl:variable name="lineID" select="./parent::pg:TextEquiv/parent::pg:TextLine/@id"/>
        <xsl:variable name="lineType" select="./parent::pg:TextEquiv/parent::pg:TextLine/@type"/>
       <!-- <xsl:if test="current() = TextLine">
            <xsl:variable name="lineID" select="@id"/>
        </xsl:if>-->
        <!-- HTML Starter -->
        <xsl:result-document href="{resolve-uri('index.html', base-uri())}"
            omit-xml-declaration="yes">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <title>Glossit DSD</title>
                </head>
                <style>
                    #nav {
                    
                        height: 100%;
                        width: 400px;
                        position: fixed;
                        z-index: 1;
                        top: 0;
                        left: 0;
                        background-color: #111;
                        /*overflow-x: hidden;*/
                        padding-top: 10px;
                        box-shadow: 5px 0px 10px #111;
                    
                    }
                    
                    .main {
                        margin-left: 400px; /* Same as the width of the sidenav */
                    
                        padding: 0px 10px;
                        overflow: scroll;
                      
                    
                    }
                    img {
                        border-radius: 8px;
                        border: 3px solid #03b6fc;
                        margin-left: 132px;
                    }
                    
                    .brand {
                        color: #03b6fc;
                        font-family: monospace;
                        font-size: 2em;
                        font-weight: bold;
                        padding-top: 1px;
                        margin-left: 125px;
                        margin-top: 0px;
                        margin-bottom: 3px;
                    }
                    
                    
                    .brandname {
                        color: grey;
                        font-family: monospace;
                        font-size: small;
                        font-weight: bold;
                        padding-top: 1px;
                        margin-left: 140px;
                        margin-top:0px;
                    
                    }
                    .img {
                    margin-bottom: 0}
                    .svg  {
                    position: fixed;}
                #zoom {
                position: fixed;
                bottom: 2em;
                left: 250px;}
                
                button {
                background-color: #03b6fc;
                color:white;
                font-size: 20px;
                font-weight: bold;
                border-radius: 12px;
                border-color: #03b6fc;
                min-width: 30px;
                margin: 5px;
                cursor: pointer;
                }
                
                button:hover {
                box-shadow:0 8px 16px 0 rgba(0,0,0,0.6)}
               .head {
               border-bottom:  5px double white;}
                
                .info {
                 background-color: white;
                 width: 350px;
                 margin-left: 25px;
                 margin-right: 25px;
                 background-color: #f5f5f5;
                 
                }
                #info {
                color: #555;
                font-size: 22px;
                margin-top: 3em;
                padding: 0 !important;
             
                font-family: monospace;
                border: 1px solid #dedede;
            
                }
                
                
               #info li {
                list-style: none;
                border-bottom: 1px dotted #ccc;
                text-indent: 10px;
                height: auto;
                padding: 10px;
                
                }
                
                #info li span {
                font-weight:bold;
                color:black;
                
                }
                
                li p {
                display:block;}
                </style>
                
                
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"/>
                <body>
                    <div class="sidenav" id="nav">
                        <div class="head">
                            <p class="brand"> GlossIT DSD</p>
                            <p class="img">
                                <img src="../../FW-satellite/Detective.png" height="130px"
                                    width="130px"/>
                            </p>
                            <!-- Change path to correct nextcloud path -->
                            <p class="brandname">Dörtl Snippet Detector</p>
                        </div>
                       
                        <div class="info">
                            <ul id="info">
                                <li><span>Line: </span> <p><xsl:value-of select="$lineID"/> </p></li>
                                <li><span>Linetype: </span> <p><xsl:value-of select="$lineType"/> </p></li>
                                <li><span>Text: </span><p><xsl:value-of select="."/> </p></li>
                            </ul>                            
                        </div>
                    <div id="zoom">
                        <button type="button" id="zoom-in" title="Zoom in">
                            +
                        </button>
                        <button type="button" id="zoom-out" title="Zoom out">
                            -
                        </button>
                        <button type="button" onclick="reset()" title="Reset">
                            &#10227;
                        </button>
                    </div>
                    </div>               
                    <div id="container" class="main">
                        
                        <svg id="svg" viewbox="{concat('0', ' 0 ', $imagewidth, ' ',$imageheight)}">                          
                            <image id="myimage" href="{$imagepath}"/>
                            <polygon id="One" points="{./parent::pg:TextEquiv/preceding-sibling::pg:Coords/@points}"
                                style="fill:none;stroke:#03e0fc;stroke-width:5;"/>
                        </svg>
                    </div>
               
                    <script src="../../FW-satellite/DSD.js">
                 
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
