<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="html"/>
    <xsl:template match="/"> 
        <!--Декларираме параметър с име param1 и стойност Track title-->
        <xsl:param name="param1" select="'Track title'"/>
        <html> 
            <body> 
                <!--За всяко подусловие си създаваме табличка-->
                <h3>Sort track elements ascending</h3>
                <table> 
                    <tr> 
                        <td> 
                            <!--Форамтиране на таблицата-->
                            <table border="2" bordercolor="black" cellspacing="0" cellpadding="2">
                                <xsl:for-each select="//track"> <!--обикаляме всички track елементи-->
                                <xsl:sort select="text()" /> <!--Сортирани -->
                                <tr><!--Следва последователност от 2 клетки-->
                                    <th> 
                                        <xsl:value-of select="$param1"/><!--първата съдътжа стойността на параметъра който селектираме с неговото име-->
                                    </th> 
                                </tr>
                                <tr>
                                    <td> 
                                        <xsl:value-of select="."/> <!--Втората стойността на track елемента-->
                                    </td> 
                                </tr>
                                </xsl:for-each>
                            </table>
                        </td> 
                    </tr> 
                </table>
                <!--Следващите две са аналогични-->
                <h3>Sort track elements descending</h3>
                <table> 
                    <tr> 
                        <td> 
                            <table border="2" bordercolor="black" cellspacing="0" cellpadding="2">
                                <xsl:for-each select="//track"> 
                                <xsl:sort select="text()" order="descending"/> 
                                <tr>
                                    <th> 
                                        <xsl:value-of select="$param1"/>
                                    </th> 
                                </tr>
                                <tr>
                                    <td> 
                                        <xsl:value-of select="."/> 
                                    </td> 
                                </tr>
                                </xsl:for-each>
                            </table>
                        </td> 
                    </tr> 
                </table> 
                <h3>Sort track elements formatted</h3>
                <table> 
                    <tr> 
                        <td> 
                            <table border="2" bordercolor="black" cellspacing="0" cellpadding="2">
                                <xsl:for-each select="//track"> 
                                <xsl:sort select="text()" /> 
                                <tr>
                                    <th> 
                                        <xsl:value-of select="$param1"/>
                                    </th> 
                                </tr>
                                <tr>
                                    <td> 
                                        <xsl:value-of select="text()"/>
                                        <xsl:text>_</xsl:text>
                                        <xsl:number value="position()" />
                                    </td> 
                                </tr>
                                </xsl:for-each>
                            </table>
                        </td> 
                    </tr> 
                </table>               
            </body> 
        </html> 
    </xsl:template> 
</xsl:stylesheet>