<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <header></header>
            <body>
                <!--Декларираме константа с име section и съдържание Result:-->
                <xsl:variable name="section">Result: </xsl:variable>
                <div>
                <h3>Sort track elements ascending</h3>
                <xsl:value-of select="$section"/> <!--Използваме константата като я селектираме по име-->
                <ol>
                    <xsl:for-each select="//track"> <!--извеждаме елементите-->
                            <xsl:sort select="."/> 
                            <li><xsl:value-of select="text()"/></li>
                    </xsl:for-each> 
                </ol>
                <br/>
                </div>
                <div>
                <h3>Sort track elements descending</h3>
                <xsl:value-of select="$section"/> <!--Използваме константата като я селектираме по име-->
                <ol>
                    <xsl:for-each select="//track">
                           <xsl:sort select="." order="descending"/> 
                           <li><xsl:value-of select="text()"/></li> 
                    </xsl:for-each> 
                </ol>
                <br/>
                </div>
                <div>
                <h3>Sort track elements formatted</h3>
                <xsl:value-of select="$section"/> <!--Използваме константата като я селектираме по име-->
                <xsl:for-each select="//track"> 
                    <xsl:sort select="." /> 
                    <xsl:value-of select="text()"/>
                    <xsl:text>_</xsl:text>
                    <xsl:number value="position()" />
                    <xsl:if test="position() != last()"> 
                        <xsl:text>, </xsl:text>
                    </xsl:if> 
                </xsl:for-each> 
                <br/>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>