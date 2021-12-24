<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template match="/">
        <html>
            <header></header><!--Нямаме нужда от header и го оставяме празен-->
            <body><!--В body се извеждат условията-->
                <h3> Track elements with length 4:04 </h3><!--Заглавие на първото подуслвие-->
                <ul>
                    <xsl:for-each select="//track"> <!--За всеки track елемент-->
                        <!--xsl:if се прилага само ако условието му е истина-->
                        <xsl:if test="@length='4:04'"> <!--Проверяваме дали атрибута му length е 4:04-->
                           <!--Ако условието е със стойност true извежаме стойността на track и ги подреждаме като лист елементи-->
                           <li><xsl:value-of select="text()"/> </li>
                        </xsl:if> 
                    </xsl:for-each> 
                </ul>
                <br/><!--Празен ред за да отделим визуално подусловията-->
                <h3> Track elements with length less than 15 and their lengths </h3><!--Заглавие на второ подуслвие-->
                <ul>
                    <xsl:for-each select="//track"> <!--За всеки track елемент-->
                        <xsl:if test="string-length() &lt; 15"> <!--Проверяваме дали дължината на името на всеки track елемент е по-малко от 15-->
                           <!--Ако условието е изпълнено извеждаме информацията за съотвентия track във формат Заглавие(дължина на заглавието)-->
                           <li><xsl:value-of select="text()"/> (<xsl:value-of select="string-length()"/>)</li> 
                        </xsl:if> 
                    </xsl:for-each> 
                </ul>
                <br/>
                <h3> Track elements on odd position </h3><!--Заглавие на трето подуслвие за четни позиции-->
                <ul>
                    <xsl:for-each select="//track"> <!--За всеки track елемент-->
                        <xsl:if test="position() mod 2 = 0"> <!--Ако позицията по модул две дава остатак 0 => че е чена позиция-->
                           <li><xsl:value-of select="text()"/> </li> <!--Ако условието е изпълнено извеждаме track елемента-->
                        </xsl:if> 
                    </xsl:for-each> 
                </ul>
                <br/>
                <h3> Track elements on even position </h3><!--Заглавие на трето подуслвие за нечетни позиции-->
                <ul>
                    <xsl:for-each select="//track"> <!--За всеки track елемент-->
                        <xsl:if test="position() mod 2 != 0"> <!--Ако позицията по модул две не дава остатак 0 => че е нечена позиция-->
                           <li><xsl:value-of select="text()"/> </li> <!--Ако условието е изпълнено извеждаме track елемента-->
                        </xsl:if> 
                    </xsl:for-each> 
                </ul>
                <br/>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>