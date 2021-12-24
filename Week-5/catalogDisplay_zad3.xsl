<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <header></header>
            <body>
                <div>
                <h3>Sort track elements ascending</h3><!--елементите сортирани в нарастващ ред-->
                <ol><!--Ordered list-->
                    <xsl:for-each select="//track"> <!--Обикаляме всички track елементи-->
                            <!--Задаваме сортиране на контекстния възел - по default се сортира в нарасрващ ред-->
                           <xsl:sort select="."/> 
                           <li><xsl:value-of select="text()"/></li><!--Извеждаме track елемента-->
                    </xsl:for-each> 
                </ol>
                <br/>
                </div>
                <div>
                <h3>Sort track elements descending</h3><!--елементите сортирани в обратен ред-->
                <ol>
                    <xsl:for-each select="//track"> <!--Обикаляме всички track елементи--> 
                            <!--Задаваме сортиране на контекстния възел order="descending" се сортира в низходящ ред-->
                           <xsl:sort select="." order="descending"/> 
                           <li><xsl:value-of select="text()"/></li> 
                    </xsl:for-each> 
                </ol>
                <br/>
                </div>
                <div>
                <h3>Sort track elements formatted</h3>
                <xsl:for-each select="//track"> <!--Обикаляме всички track елементи--> 
                    <xsl:sort select="." /> <!--Задаваме сортиране на контекстния възел - по default се сортира в нарасрващ ред-->
                    <xsl:value-of select="text()"/> <!--Извеждаме track елемента-->
                    <xsl:text>_</xsl:text><!--След това "_"-->
                    <xsl:number value="position()" /><!--следва позицията на елемента -->
                    <xsl:if test="position() != last()"> 
                        <xsl:text>, </xsl:text> <!--Ако елементът не е нa последна позиция след него пишем ","-->
                    </xsl:if> 
                </xsl:for-each> 
                <br/>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>