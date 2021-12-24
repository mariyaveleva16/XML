<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="html"/>
    <xsl:template match="catalog">
        <xsl:element name="result"><!--Ще ни бъде root елемента в изхода-->
            <xsl:for-each select="cd"><!--За всяко cd-->
                <xsl:element name="title">
                    <xsl:value-of select="title"/><!--За елемента с име title се извежда неговата стойност-->
                </xsl:element>
                <xsl:element name="tracklist">
                    <xsl:attribute name="num"><!--Ще се изведе атрибута num на tracklist-->
                        <xsl:value-of select="tracklist/@num"/>
                    </xsl:attribute>
                    <xsl:for-each select="tracklist/track"><!--За всеки track-->
                        <xsl:element name="track"><!--Ще се изведе атрибута му length и името му-->
                            <xsl:attribute name="length">
                                <xsl:value-of select="@length"/>
                            </xsl:attribute>
                            <xsl:value-of select="text()"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>