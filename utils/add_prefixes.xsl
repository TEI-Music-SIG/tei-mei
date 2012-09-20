<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Find internal prefixes in an old MEI source and apply them to a new one. -->
    
    <xsl:param name="oldMEI" select="'../mei/old-mei-source.xml'"/>
    
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*|text()|comment()|processing-instruction()">
        <xsl:sequence select="."/>
    </xsl:template>
    
    <xsl:template match="tei:*[some $i in document($oldMEI)//tei:*[@prefix]/@ident/string(.) satisfies ($i = @ident)]">
        <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:sequence select="@*"/>
            <xsl:attribute name="prefix" select="'mei_'"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="rng:ref[some $i in document($oldMEI)//tei:*[@prefix]/@ident/string(.) satisfies ($i = @name)]">
        <xsl:element name="rng:{local-name()}" namespace="http://relaxng.org/ns/structure/1.0">
            <xsl:sequence select="@* except @name"/>
            <xsl:attribute name="name" select="concat('mei_', @name)"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>