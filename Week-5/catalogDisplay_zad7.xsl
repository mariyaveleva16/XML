<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <header></header>
            <body>
                <table border="2" bordercolor="black" cellspacing="0" cellpadding="2">
                    <thead>
                        <tr>
                            <th>Year</th>
                            <th>Title</th>
                            <th>Artist</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="catalog/cd"> <!--За всяко cd ще се извежда съответната информация-->
                            <tr>
                                <td><!--За първата колонка се извиква шаблон с име year с параметър yearName който селектира стойността year за съответното cd-->
                                <xsl:call-template name="year">
                                        <xsl:with-param name="yearName" select="year"/>
                                    </xsl:call-template>
                                </td>
                                <td><!--За втората колонка се извиква шаблон с име title с параметър titleName който селектира стойността title за съответното cd-->
                                    <xsl:call-template name="title">
                                        <xsl:with-param name="titleName" select="title"/>
                                    </xsl:call-template>
                                </td>
                                <td><!--За третата колонка се извиква шаблон с име artist с параметър artistName който селектира стойността artist за съответното cd-->
                                    <xsl:call-template name="artist">
                                        <xsl:with-param name="artistName" select="artist"/>
                                    </xsl:call-template>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    <!--Деклариране на шаблон с име year и параметър с име yearName и селектира параметъра с неовото име-->
    <xsl:template name="year">
        <xsl:param name="yearName"/>
        <xsl:value-of select="$yearName"/>
    </xsl:template>
    <!--Деклариране на шаблон с име title и параметър с име titleName и селектира параметъра с неовото име-->
    <xsl:template name="title">
        <xsl:param name="titleName"/>
        <xsl:value-of select="$titleName"/>
    </xsl:template>
    <!--Деклариране на шаблон с име artist и параметър с име artistName и селектира параметъра с неовото име-->
    <xsl:template name="artist">
        <xsl:param name="artistName"/>
        <xsl:value-of select="$artistName"/>
    </xsl:template>
</xsl:stylesheet>