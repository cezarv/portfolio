<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"  
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="http://www.w3.org/1999/xhtml"
  xpath-default-namespace="http://docbook.org/ns/docbook"
  exclude-result-prefixes="#all">

  <!-- Umsetzung einer jQuery-Mobile-Ausgabe zur tutory-Aleitung via DocBook | by T. Meinike 11/19 -->

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>

  <!-- Vorgaben -->
  <xsl:variable name="header" select="'tutory-Anleitung'"/>
  <xsl:variable name="footer" select="'Mobile Doku 2019'"/>

  <!-- Haupttemplate -->
  <xsl:template match="book">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;&#xA;</xsl:text>

    <!-- HTML-Grundgerüst -->
    <html lang="de">
      <head>
        <meta charset="UTF-8"/>
        <meta name="generator" content="tutory_ad.xsl"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name="mobile-web-app-capable" content="yes"/>
        <meta name="apple-mobile-web-app-capable" content="yes"/>
        <meta name="apple-mobile-web-app-status-bar-style" content="black"/> <!-- default | black | black-translucent -->
        <meta name="apple-mobile-web-app-title" content="Bücher"/>
        <link rel="apple-touch-icon" href="bookicon.png"/>
        <link rel="icon" sizes="128x128" href="bookicon.png"/>
        <link rel="stylesheet" href="tutory_ad.css" type="text/css"/>
        <!-- jQM -->
      <xsl:text disable-output-escaping="yes">
      &lt;link rel="stylesheet" href="jqm/jquery.mobile-1.4.5.min.css" type="text/css"/>
      &lt;script src="jqm/jquery-1.12.4.min.js" type="text/javascript">&lt;/script>
      &lt;script src="jqm/jquery.mobile-1.4.5.min.js" type="text/javascript">&lt;/script>
      </xsl:text>
        <title><xsl:value-of select="$header"/></title>
      </head>
      <body>
        <!-- jQM-Startseite -->
        <div data-role="page" id="start">

          <!-- Header-Bereich -->
          <div data-role="header" data-position="fixed" data-theme="b">
            <h1><xsl:value-of select="$header"/></h1>
            <a style="cursor: default" class="ui-btn ui-btn-active ui-icon-home ui-btn-icon-left ui-corner-all">Start</a>
            <a href="#info" class="ui-btn ui-icon-info ui-btn-icon-left ui-corner-all">Info</a>
            <div data-role="navbar">
              <ul>
                <xsl:for-each select="chapter">
                  <xsl:variable name="pos" select="fn:position()"/>
                  <li>
                    <a href="#kap{$pos}"><xsl:value-of select="fn:concat('Kapitel ', $pos)"/></a>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </div>
          <!-- /Header-Bereich -->

          <!-- Main-Bereich -->
          <div data-role="main" class="ui-content">
            <div style="text-align: center">
              <h1><xsl:value-of select="fn:normalize-space(title)"/></h1>
              <p>
                <img src="{title/inlinemediaobject/imageobject/imagedata/@fileref}" alt="tutory-Logo"/> <!-- width="760" height="258" -->
              </p>
            </div>
            <h2>Inhaltsverzeichnis</h2>
            <ul data-role="listview" data-inset="true">
              <xsl:for-each select="chapter">
                <xsl:variable name="chapos" select="fn:position()"/>
                <li><a href="#kap{$chapos}"><xsl:value-of select="fn:concat('Kapitel ', $chapos, ': ', title)"/></a></li>
              </xsl:for-each>
            </ul>
          </div>
          <!-- /Main-Bereich -->

          <!-- Footer-Bereich -->
          <div data-role="footer" data-position="fixed" data-theme="b">
            <h1><xsl:value-of select="$footer"/></h1>
          </div>
          <!-- /Footer-Bereich -->

        </div>
        <!-- /jQM-Startseite -->

        <!-- jQM-Infoseite -->
        <div data-role="page" id="info">

          <!-- Header-Bereich -->
          <div data-role="header" data-position="fixed" data-theme="b">
            <h1><xsl:value-of select="$header"/></h1>
            <a href="#start" class="ui-btn ui-icon-home ui-btn-icon-left ui-corner-all">Start</a>
            <a style="cursor: default" class="ui-btn ui-btn-active ui-icon-info ui-btn-icon-left ui-corner-all">Info</a>
            <div data-role="navbar">
              <ul>
                <xsl:for-each select="chapter">
                  <xsl:variable name="pos" select="fn:position()"/>
                  <li>
                    <a href="#kap{$pos}"><xsl:value-of select="fn:concat('Kapitel ', $pos)"/></a>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </div>
          <!-- /Header-Bereich -->

          <!-- Main-Bereich -->
          <div data-role="main" class="ui-content">
            <h2>Impressum</h2>
            <p>Umsetzung: <xsl:value-of select="info/author/orgname"/></p>
         
            <p>Kontakt:</p>
            <address>
              <p><xsl:value-of select="info/address/orgname"/></p>
              <p><xsl:value-of select="info/address/street"/></p>
              <p><xsl:value-of select="fn:concat(info/address/postcode, ' ', info/address/city)"/></p>
              <p><xsl:value-of select="info/address/country"/></p>
              <p><xsl:value-of select="info/address/phone"/></p>
              <p><a href="mailto:{info/address/email}"><xsl:value-of select="info/address/email"/></a></p>
            </address>
            <p>(Ein Projekt für den Kurs Mobile Dokumentation im Wintersemester 2019/20, umgesetzt mit DocBook und jQuery Mobile.)</p>
          </div>
          <!-- /Main-Bereich -->

          <!-- Footer-Bereich -->
          <div data-role="footer" data-position="fixed" data-theme="b">
            <h1><xsl:value-of select="$footer"/></h1>
          </div>
          <!-- /Footer-Bereich -->

        </div>
        <!-- /jQM-Infoseite -->

        <!-- chapter verarbeiten -->
        <xsl:apply-templates select="chapter"/>
      </body>
    </html>
  </xsl:template>

  <!-- chapter-Template -->
  <xsl:template match="chapter">
    <xsl:variable name="aktchapos" select="fn:position()"/>

    <!-- jQM-Unterseite -->
    <div data-role="page" id="kap{$aktchapos}">

      <!-- Header-Bereich -->
      <div data-role="header" data-position="fixed" data-theme="b">
        <h1><xsl:value-of select="$header"/></h1>
        <a href="#start" class="ui-btn ui-icon-back ui-btn-icon-left">Start</a>
        <a href="#info" class="ui-btn ui-icon-info ui-btn-icon-left">Info</a>
        <div data-role="navbar">
          <ul>
            <xsl:for-each select="/book/chapter">
              <xsl:variable name="chapos" select="fn:position()"/>
              <xsl:choose>
                <xsl:when test="$chapos = $aktchapos">
                  <li>
                    <a class="ui-btn-active ui-state-persist" style="cursor: default"><xsl:value-of select="fn:concat('Kapitel ', $aktchapos)"/></a>
                  </li>
                </xsl:when>
                <xsl:otherwise>
                  <li>
                    <a href="#kap{$chapos}"><xsl:value-of select="fn:concat('Kapitel ', $chapos)"/></a>
                  </li>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </ul>
        </div>
      </div>
      <!-- /Header-Bereich -->

      <!-- Main-Bereich -->
      <div data-role="main" class="ui-content">
        <!--<h1><xsl:value-of select="title"/></h1>-->
        <div data-role="collapsibleset">
          <xsl:apply-templates/>
        </div>
      </div>
      <!-- /Main-Bereich -->

      <!-- Footer-Bereich -->
      <div data-role="footer" data-position="fixed" data-theme="b">
        <h1><xsl:value-of select="$footer"/></h1>
      </div>
      <!-- /Footer-Bereich -->

    </div>
    <!-- /jQM-Unterseite -->
  </xsl:template>

  <!-- weitere Templates für die DocBook-Verarbeitung -->
  <xsl:template match="section">
    <div data-role="collapsible">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="para">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="mediaobject">
    <p>
      <img src="{imageobject/imagedata/@fileref}" alt="{caption/para}"/>
    </p>
    <p>
      <xsl:value-of select="caption/para"/>
    </p>
  </xsl:template>

  <xsl:template match="inlinemediaobject">
    <img src="{imageobject/imagedata/@fileref}" alt="" height="18"/>
  </xsl:template>

  <xsl:template match="itemizedlist">
    <ul data-role="listview" data-inset="true">
      <xsl:for-each select="listitem">
        <li>
          <xsl:apply-templates select="para"/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="orderedlist">
    <ol data-role="listview" data-inset="true">
      <xsl:for-each select="listitem">
        <li>
          <xsl:apply-templates select="para"/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <xsl:template match="title">
    <!-- fn:count(ancestor::section) = 0, wenn title-Vorfahrenelement chapter,
         ansonsten >=1 für die section-Anzahl, ergibt also h1, h2, h3, ... -->
    <xsl:variable name="h_level" select="fn:count(ancestor::section) + 1"/>
    <xsl:element name="h{$h_level}">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="procedure">
    <ol>
      <xsl:for-each select="step">
        <li>
          <xsl:apply-templates select="para"/>
          <xsl:apply-templates select="result"/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <xsl:template match="result">
    <div class="result">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="para[@role = 'infobox']">
    <p class="infobox">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="emphasis">
    <em>
      <xsl:apply-templates/>
    </em>
  </xsl:template>

  <xsl:template match="emphasis[@role = 'bold']">
    <strong>
      <xsl:value-of select="."/>
    </strong>
  </xsl:template>

</xsl:stylesheet>