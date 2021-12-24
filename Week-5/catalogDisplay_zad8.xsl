<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template match="catalog/cd"> <!--За всяко cd-->
      <cd> 
        <xsl:copy-of select="title"/>  <!--Копира фрагмента title от входното XML дърво-->
        <!--Копира фрагмента tracklist от входното XML дърво без загуба на атрибути и съдържани поделементи 
        =>ще се изведе и атрибута num и поделемените на tracklist-->
        <xsl:copy-of select="tracklist"/> 
      </cd> 
   </xsl:template> 
</xsl:stylesheet>