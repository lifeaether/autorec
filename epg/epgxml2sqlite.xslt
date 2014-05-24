<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="UTF-8" />
	<xsl:template match="/">
		<xsl:text>BEGIN;</xsl:text><xsl:text>&#x0A;</xsl:text>
			<xsl:apply-templates select="tv/programme" />
		<xsl:text>END;</xsl:text>
	</xsl:template>
	
	<xsl:template match="programme">
		<xsl:text>INSERT OR REPLACE INTO programme (event_id,channel,title,start,stop,duration,freeCA,video,audio,desc,extdesc) VALUES (</xsl:text>
		
		<xsl:value-of select="@event_id" />
		<xsl:text>,</xsl:text>
		
		<xsl:text>'</xsl:text>
		<xsl:value-of select="@channel" />
		<xsl:text>'</xsl:text><xsl:text>,</xsl:text>
		
		<xsl:text>'</xsl:text>
		<xsl:call-template name="escape">
			<xsl:with-param name="string" select="title" />
		</xsl:call-template>
		<xsl:text>'</xsl:text><xsl:text>,</xsl:text>
		
		<xsl:text>'</xsl:text>
		<xsl:call-template name="datetime">
			<xsl:with-param name="string"><xsl:value-of select="@start" /></xsl:with-param>
		</xsl:call-template>
		<xsl:text>'</xsl:text><xsl:text>,</xsl:text>
		
		<xsl:text>'</xsl:text>
		<xsl:call-template name="datetime">
			<xsl:with-param name="string"><xsl:value-of select="@stop" /></xsl:with-param>
		</xsl:call-template>
		<xsl:text>'</xsl:text><xsl:text>,</xsl:text>
		
		<xsl:value-of select="@duration" />
		<xsl:text>,</xsl:text>
		
		<xsl:value-of select="freeCA" />
		<xsl:text>,</xsl:text>
		
		<xsl:value-of select="video/@id" />
		<xsl:text>,</xsl:text>

		<xsl:value-of select="audio/@id" />
		<xsl:text>,</xsl:text>

		<xsl:text>'</xsl:text>
		<xsl:call-template name="escape">
			<xsl:with-param name="string" select="desc" />
		</xsl:call-template>
		<xsl:text>'</xsl:text><xsl:text>,</xsl:text>
		
		<xsl:text>'</xsl:text>
		<xsl:apply-templates select="extdesc" />
		<xsl:text>'</xsl:text>
		
		<xsl:text>);</xsl:text>
		<xsl:text>&#x0A;</xsl:text>
		
		<xsl:apply-templates select="category[@lang='ja_JP']|category_middle[@lang='ja_JP']" />

	</xsl:template>
	
	<xsl:template match="category|category_middle">
		<xsl:if test="name() = 'category'">
			<xsl:text>INSERT OR REPLACE INTO category (event_id,channel,category,middle) VALUES (</xsl:text>
			
			<xsl:value-of select="../@event_id" />
			<xsl:text>,</xsl:text>
			
			<xsl:text>'</xsl:text>
			<xsl:value-of select="../@channel" />
			<xsl:text>'</xsl:text><xsl:text>,</xsl:text>
			
			<xsl:text>'</xsl:text>
			<xsl:call-template name="escape">
				<xsl:with-param name="string" select="." />
			</xsl:call-template>
			<xsl:text>'</xsl:text><xsl:text>,</xsl:text>
		</xsl:if>
		<xsl:if test="name() = 'category_middle'">
			<xsl:text>'</xsl:text>
			<xsl:call-template name="escape">
				<xsl:with-param name="string" select="." />
			</xsl:call-template>
			<xsl:text>'</xsl:text>
			<xsl:text>);</xsl:text>
			<xsl:text>&#x0A;</xsl:text>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="extdesc">
		<xsl:text>{</xsl:text>
		<xsl:apply-templates select="item_description|item" />
		<xsl:text>}</xsl:text>
	</xsl:template>
	
	<xsl:template match="item_description|item">
		<xsl:if test="name() = 'item_description'">
			<xsl:text>"</xsl:text>
			<xsl:call-template name="escape">
				<xsl:with-param name="string" select="." />
			</xsl:call-template>
			<xsl:text>"</xsl:text>
			<xsl:text>:</xsl:text>
		</xsl:if>
		<xsl:if test="name() = 'item'">
			<xsl:text>"</xsl:text>	
			<xsl:call-template name="escape">
				<xsl:with-param name="string" select="." />
			</xsl:call-template>
			<xsl:text>"</xsl:text>
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="datetime">
		<xsl:param name="string"></xsl:param>
		<xsl:value-of select="substring($string,1,4)" />
		<xsl:text>-</xsl:text>
		<xsl:value-of select="substring($string,5,2)" />
		<xsl:text>-</xsl:text>
		<xsl:value-of select="substring($string,7,2)" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="substring($string,9,2)" />
		<xsl:text>:</xsl:text>
		<xsl:value-of select="substring($string,11,2)" />
		<xsl:text>:</xsl:text>
		<xsl:value-of select="substring($string,13,2)" />
	</xsl:template>
	
	<xsl:template name="escape">
		<xsl:param name="string" />
		<xsl:call-template name="replace">
			<xsl:with-param name="str" select="$string" />
			<xsl:with-param name="match">&apos;</xsl:with-param>
			<xsl:with-param name="replace">&apos;&apos;</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="replace">
		<xsl:param name="str"/>
		<xsl:param name="match"/>
		<xsl:param name="replace"/>
		<xsl:choose>
			<xsl:when test="contains($str,$match)">
			<xsl:value-of select="substring-before($str,$match)" />
			<xsl:value-of select="$replace" />
				<xsl:call-template name="replace">
					<xsl:with-param name="str" select="substring-after($str,$match)"/>
					<xsl:with-param name="match" select="$match"/>
					<xsl:with-param name="replace" select="$replace"/>
				</xsl:call-template></xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$str" />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
