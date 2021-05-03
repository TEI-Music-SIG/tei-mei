<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    exclude-result-prefixes="xs tei rng"
    version="2.0">
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:elementSpec | tei:macroSpec">
        <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="prefix">mei_</xsl:attribute>
            <xsl:attribute name="ns">http://www.music-encoding.org/ns/mei</xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>                
    </xsl:template>
        
    <xsl:template match="rng:ref">
        <rng:ref name="mei_{@name}">
            <xsl:apply-templates select="@* except @name|node()"/>
        </rng:ref>
    </xsl:template>
    
    <xsl:template match="@*[starts-with(., 'model.') or starts-with(., 'att.') or starts-with(., 'macro.')]">
        <xsl:attribute name="{local-name()}"><xsl:value-of select="concat('mei_', .)"/></xsl:attribute>
    </xsl:template>
    
</xsl:stylesheet>