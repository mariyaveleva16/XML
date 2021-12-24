<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="html"/>
    <xsl:template match="/"> 
        <html> 
            <body> 
                <h2>Tatu Catalog</h2> <!--Заглавие над таблицата-->
                <table border="2" cellspacing="0px" cellpadding="5px"> <!--Създаваме таблица със следното форматиране-->
                    <thead><!--Първия ред съдържа заглавията на колоните--> 
                        <tr> 
                            <th>CD Title</th> 
                            <th>Year</th> 
                            <th>Tracks</th> 
                        </tr> 
                    </thead> 
                    <tbody valign="top"> <!--В следващите клетки от таблицата елементите ще са разположени в горната част-->
                        <xsl:apply-templates select="catalog"/> <!--и ще се използва следния темплейт-->
                    </tbody> 
                </table> 
            </body> 
        </html> 
    </xsl:template> 
    <xsl:template match="cd"> <!--задаваме шаблон който ще се използва за всяко cd-->
        <tr> 
            <td> 
                <xsl:apply-templates select="title"/> <!--селектира елемента title за съответното cd-->
                <xsl:for-each select="title/@*"> <!--За всеки атрибут на title се селектира името на атрибута и неговата стойност-->
                <br/>Atribute name: <xsl:value-of select="name()"/> ; Аtribute value: <xsl:value-of select="."/> <!--и се извеждат в следния вид--> 
                </xsl:for-each> 
            </td> 
            <td> 
                <xsl:apply-templates select="year"/> <!--селектира елемента year за съответното cd-->
                <xsl:for-each select="year/@*"> <!--За всеки атрибут на year се селектира името на атрибута и неговата стойност-->
                <br/>Atribute name: <xsl:value-of select="name()"/> ; Аtribute value: <xsl:value-of select="."/> <!--и се извеждат в следния вид--> 
                </xsl:for-each> 
            </td> 
            <td> 
                <ol> <!--в ordered list се използва следния шаблон-->
                    <xsl:apply-templates select="tracklist/track"/> 
                </ol> 
            </td> 
        </tr> 
    </xsl:template> 
    <xsl:template match="catalog/cd/tracklist/track"> <!--За всеки track елемент-->
        <li> <!--В li елемент за да са отделени на различни редове заглавието и атрибутите-->
            <xsl:apply-templates select="text()"/> <!--се селектира неговото име-->
            <xsl:for-each select="@*"> <!--и за всеки атрибут на track се селектира името на атрибута и неговата стойност -->
                <br/>Atribute name: <xsl:value-of select="name()"/> ; Аtribute value: <xsl:value-of select="."/><!--и се извеждат в следния вид--> 
            </xsl:for-each> 
        </li> 
    </xsl:template>
</xsl:stylesheet>