<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="html"/>
    <xsl:template match="/"> 
        <html> 
            <body> 
                <h2>Tatu Catalog</h2> <!--Заглавие над таблицата-->
                <table border="2" cellspacing="0px" cellpadding="5px"><!--Създаваме таблица със следното форматиране--> 
                    <thead> <!--Първия ред съдържа заглавията на колоните--> 
                        <tr> 
                            <th>CD Title</th> 
                            <th>Year</th> 
                            <th>Tracks without atributes</th> 
                            <th>Tracks with atributes</th> 
                        </tr> 
                    </thead> 
                    <tbody valign="top"> <!--В следващите клетки от таблицата елементите ще са разположени в горната част-->
                        <xsl:apply-templates select="catalog"/> <!--и ще се използва следния темплейт-->
                    </tbody> 
                </table> 
            </body> 
        </html> 
    </xsl:template> 
    <xsl:template match="cd"> <!--задаваме шаблон-->
        <tr> 
            <td> 
                <xsl:apply-templates select="title"/> <!--селектира стойността на title-->
            </td> 
            <td> 
                <xsl:apply-templates select="year"/> <!--селектира стойността на year-->
            </td> 
            <td> 
                <ol> 
                <xsl:apply-templates select="tracklist/track" mode="withoutAttributes"/> <!--за третата колона използваме шаблона за track елементи без атрибути-->
                </ol> 
            </td> 
            <td> 
                <ol> 
                <xsl:apply-templates select="tracklist/track" mode="withAttributes"/> <!--за четвъртата колона използваме шаблона за track елементи с атрибути-->
                </ol> 
            </td> 
        </tr> 
    </xsl:template> 
    <!--За всеки track елемент задаваме шаблон без атрибути-->
    <xsl:template match="catalog/cd/tracklist/track" mode="withoutAttributes"> 
        <li> 
            <xsl:apply-templates select="text()"/> <!--селектираме само името на track елемента-->
        </li> 
    </xsl:template> 
    <!--За всеки track елемент задаваме шаблон с атрибути-->
    <xsl:template match="catalog/cd/tracklist/track" mode="withAttributes"> 
        <li> 
            <xsl:apply-templates select="text()"/> <!--селектираме името на track елемента-->
            <xsl:for-each select="@*"> <!--както и за всеки негов атрибут името на атрибута и неговата стойност-->
                <br/>Atribute name: <xsl:value-of select="name()"/> ; Аtribute value: <xsl:value-of select="."/> <!--и се извеждат в следния вид--> 
            </xsl:for-each> 
        </li> 
    </xsl:template> 
</xsl:stylesheet>