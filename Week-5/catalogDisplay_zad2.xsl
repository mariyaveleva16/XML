<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <header></header>
            <body>
                <xsl:for-each select="//track"><!--За всеки track елемет-->
                    <xsl:choose><!-- задаваме многократни условни тестове-->
                        <!--Ако дълината на името на track елемента е по-дълга от 15 се извежда A big string-->
                        <xsl:when test="string-length() &gt; 15">
                            <p>A big string</p>
                        </xsl:when>
                        <!--Ако дълината на името на track елемента е по-малко от 15 се извежда A small string-->
                        <xsl:when test="string-length() &lt; 15">
                            <p>A small string</p>
                        </xsl:when>
                        <!--Ако нито едно от предните условия не е изпълнено се извежда A medium string-->
                        <xsl:otherwise>
                            <p>A medium string</p>
                        </xsl:otherwise>
                    </xsl:choose>
                    <p><xsl:value-of select="string-length()" /> </p><!--Извеждаме и дължината на string-a за да проверим дали извежда правилно-->
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>