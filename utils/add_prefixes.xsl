<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Find internal prefixes in an old MEI source and apply them to a new one. -->
    
    <xsl:param name="oldMEI" select="'../old-mei-source.xml'"/>
    
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*|text()|comment()|processing-instruction()">
        <xsl:sequence select="."/>
    </xsl:template>
    
    <xsl:template match="tei:elementSpec[some $i in document($oldMEI)//tei:*[@prefix]/@ident/lower-case(.) satisfies ($i = lower-case(@ident))]">
        <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:sequence select="@*"/>
            <xsl:attribute name="ns" select="'http://www.music-encoding.org/ns/mei'"/>
            <xsl:attribute name="prefix" select="'mei_'"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:classSpec[some $i in document($oldMEI)//tei:*[starts-with(@ident, 'mei_')]/@ident/lower-case(.) satisfies (substring-after($i, 'mei_') = lower-case(@ident))]">
        <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:sequence select="@* except @ident"/>
            <xsl:attribute name="ident" select="concat('mei_', @ident)"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="rng:ref[some $i in document($oldMEI)//tei:*[@prefix]/@ident/lower-case(.) satisfies ($i = lower-case(@name))]">
        <xsl:element name="rng:{local-name()}" namespace="http://relaxng.org/ns/structure/1.0">
            <xsl:sequence select="@* except @name"/>
            <xsl:attribute name="name" select="concat('mei_', @name)"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="rng:ref[some $i in document($oldMEI)//tei:*[starts-with(@ident, 'mei_')]/@ident/lower-case(.) satisfies (substring-after($i, 'mei_') = lower-case(@name))]">
        <xsl:element name="rng:{local-name()}" namespace="http://relaxng.org/ns/structure/1.0">
            <xsl:sequence select="@* except @name"/>
            <xsl:attribute name="name" select="concat('mei_', @name)"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:memberOf[some $i in document($oldMEI)//tei:*[starts-with(@ident, 'mei_')]/@ident/lower-case(.) satisfies (substring-after($i, 'mei_') = lower-case(@key))]">
        <xsl:element name="rng:{local-name()}" namespace="http://relaxng.org/ns/structure/1.0">
            <xsl:sequence select="@* except @key"/>
            <xsl:attribute name="name" select="concat('mei_', @key)"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>