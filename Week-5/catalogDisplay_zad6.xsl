<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <header></header>
            <body>
                <!--Създаваме си таблица със следното форматиране-->
                <table border="2" bordercolor="black" cellspacing="0" cellpadding="2">
                    <!--Заглавния ред на таблицата-->
                    <thead>
                        <tr><!--Имената на колоните-->
                            <th>Year</th>
                            <th>Title</th>
                            <th>Artist</th>
                        </tr>
                    </thead>
                    <!--Съдъжанието на таблцата-->
                    <tbody>
                        <xsl:for-each select="catalog/cd"> <!--За всяко cd ще се извежда съответната информация-->
                            <tr>
                                <td><xsl:call-template name="year"/></td><!--За първата колонка се извиква шаблон с име year-->
                                <td><xsl:call-template name="title"/></td><!--За втората колонка се извиква шаблон с име title-->
                                <td><xsl:call-template name="artist"/></td><!--За третата колонка се извиква шаблон с име artist-->
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    <!--Деклариране на шаблон с име year който връща стойността на елемента year за съответно cd-->
    <xsl:template name="year">
        <xsl:value-of select="year"/>
    </xsl:template>
    <!--Деклариране на шаблон с име title който връща стойността на елемента title за съответно cd-->
    <xsl:template name="title">
        <xsl:value-of select="title"/>
    </xsl:template>
    <!--Деклариране на шаблон с име artist който връща стойността на елемента artist за съответно cd-->
    <xsl:template name="artist">
        <xsl:value-of select="artist"/>
    </xsl:template>
</xsl:stylesheet>