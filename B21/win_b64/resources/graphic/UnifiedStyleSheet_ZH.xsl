<?xml version="1.0" encoding="UTF-8"?>

<!-- This style sheet is used by XML files exported for clash process purpose.
     It is referenced by three different types of XML files:
      - XML containing the descriptions of all the clashes resulting of one export
      - federator XML containing clash specifications and links to detailed descriptions 
        for each interference (federated mode)
      - detailed XML containing one interference description (federated mode)
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Process the document node -->
  <xsl:template match="/">
    <HTML>
      <xsl:apply-templates/>
    </HTML>
  </xsl:template>

  <!-- Here is a named template to build the presentation header. 
       It is called by the root nodes of each XML file -->
  <xsl:template name="Header">
    <xsl:param name="resourcesPath"/>
    <!-- where to find the logo -->
    <xsl:param name="title" xml:lang="zh-CN">冲突出版</xsl:param>
    <!-- presentation title     -->
    <!-- the hint box for dhtml effects -->
    <DIV id="Hint"></DIV>
    <DIV class="Note" xml:lang="zh-CN">创造 <xsl:value-of select="@Responsible"/></DIV>
    <DIV class="Date">
      <xsl:value-of select="Date/@Month"/>/<xsl:value-of select="Date/@Day"/>/<xsl:value-of select="Date/@Year"/>,
      <xsl:value-of select="Date/@Hour"/>:<xsl:value-of select="Date/@Minute"/>:<xsl:value-of select="Date/@Second"/>
      <HR/><BR/>
    </DIV>
    <DIV>
      <A href="http://www.3DS.com">
        <IMG src="{concat($resourcesPath, 'dslogo.gif')}" alt="3DS logo" border="0" />
      </A>
      <BR/>
    </DIV>
    <DIV class="Header">
      <xsl:value-of select="$title"/>
      <BR/>
      <BR/>
      <HR/>
    </DIV>
  </xsl:template>

  <!-- template for the root node of federator XML file -->
  <xsl:template match="FederatorClashElement">
    <HEAD>
      <META http-equiv="Content-Script-Type" content="type/javascript"/>
      <!-- script for dynamic HTML -->
      <SCRIPT src="Ressources/dhtml.js"/>
      <LINK href="Ressources/ClashPublish.css" rel="stylesheet" type="text/css"/>
    </HEAD>
    <BODY>
      <xsl:call-template name="Header">
        <xsl:with-param name="resourcesPath">Ressources/</xsl:with-param>
        <xsl:with-param name="title" xml:lang="zh-CN">密冲突出版</xsl:with-param>
      </xsl:call-template>
      <DIV>
        <DL>
          <xsl:apply-templates select="ClashSpec"/>
          <xsl:apply-templates select="Elements"/>
        </DL>
      </DIV>
    </BODY>
  </xsl:template>

  <xsl:template match="ClashSpec">
    <DT class="Title" 
        onclick="CollExp('SpecBody', 'TriangleSpec')" 
        onmouseover="this.className='TitleOn'; showHint('Collapse/Expand')" 
        onmouseout="this.className='Title'; hideHint()">
      <IMG id="TriangleSpec" src="Ressources/d.bmp"/>
      <xsl:value-of select="@Name"/>
    </DT>
    <DD id="SpecBody">
      <BR/>
      <BR/>
      <TABLE border="1" bgcolor="#FFFFCC" width="50%">
        <CAPTION>
          <xsl:value-of select="@TabTitle"/>
        </CAPTION>
        <TBODY class="ResultTable">
          <TR align="center">
            <TH xml:lang="zh-CN">选择模式</TH>
            <TH xml:lang="zh-CN">计算模式</TH>
            <xsl:if test="@CaseOfCalc[.!='INTERFERE_CONT']">
              <TH xml:lang="zh-CN">清遥</TH>
            </xsl:if>
          </TR>
          <TR align="left">
            <TD>
              <xsl:value-of select="@SelectMode"/>
            </TD>
            <TD>
              <xsl:choose>
                <xsl:when test="@CaseOfCalc[.='INTERFERE_CONT']" xml:lang="zh-CN">联系|冲突</xsl:when>
                <xsl:when test="@CaseOfCalc[.='INTERFERE_CLEAR']" xml:lang="zh-CN">关|联系我们|冲突</xsl:when>
                <xsl:when test="@CaseOfCalc[.='INTERFERE_PENETR_CLASH']" xml:lang="zh-CN">授权渗透</xsl:when>
                <xsl:when test="@CaseOfCalc[.='INTERFERE_RULE']" xml:lang="zh-CN">冲突规则</xsl:when>
              </xsl:choose>
            </TD>
            <xsl:if test="@CaseOfCalc[.!='INTERFERE_CONT']">
              <TD>
                <xsl:value-of select="@DistanceClearance"/>
              </TD>
            </xsl:if>
          </TR>
        </TBODY>
      </TABLE>
      <BR/>
      <BR/>
      <TABLE border="1" bgcolor="#FFFFCC" width="50%">
        <CAPTION>
          <xsl:value-of select="@TabListTitle"/>
        </CAPTION>
        <TBODY class="ResultTable">
          <TR align="center">
            <TH xml:lang="zh-CN">产品名称</TH>
            <TH xml:lang="zh-CN">形状名称</TH>
            <TH xml:lang="zh-CN">过程模式</TH>
          </TR>
          <xsl:apply-templates select="Specification"/>
        </TBODY>
      </TABLE>
    </DD>
    <BR/>
    <BR/>
  </xsl:template>

  <xsl:template match="Specification">
    <xsl:apply-templates select="Product"/>
  </xsl:template>

  <xsl:template match="Product">
    <TR align="left">
      <TD>
        <xsl:value-of select="@Alias"/>
      </TD>
      <TD>
        <xsl:value-of select="@ShapeName"/>
      </TD>
      <TD>
        <xsl:choose>
          <xsl:when test="@ProcessMode[.='ENOVIAV5']" xml:lang="zh-CN">Enovia LCA</xsl:when>
          <xsl:when test="@ProcessMode[.='ENOVIAVPM']" xml:lang="zh-CN">Enovia VPM</xsl:when>
          <xsl:when test="@ProcessMode[.='STANDALONE']" xml:lang="zh-CN">单位档案</xsl:when>
        </xsl:choose>
      </TD>
    </TR>
  </xsl:template>

  <xsl:template match="Elements">
    <DT class="Title" 
        onclick="CollExp('ResultBody', 'TriangleResult')" 
        onmouseover="this.className='TitleOn'; showHint('Collapse/Expand')" 
        onmouseout="this.className='Title'; hideHint()">
      <A name="main">
        <BR/>
        <IMG id="TriangleResult" src="Ressources/d.bmp" xml:lang="zh-CN"/>计算结果
      </A>
    </DT>
    <BR/>
    <BR/>
    <DD id="ResultBody">
      <TABLE border="1" bgcolor="#FFFFCC" width="90%">
        <TBODY class="ResultTable">
          <TR align="center">
            <!--	draw a column for previews only if there is at least one
                  'LinkToInterference' element with a non-empty 'FirstProductURL' attribute-->
            <xsl:if test="LinkToInterference[string(@FirstProductURL)]">
              <TH xml:lang="zh-CN">产品与产品</TH>
            </xsl:if>
            <TH xml:lang="zh-CN">链接</TH>
          </TR>
          <xsl:choose>
            <xsl:when test="LinkToInterference[string(@FirstProductURL)]">
              <xsl:apply-templates select="LinkToInterference">
                <xsl:with-param name="Pictures">Yes</xsl:with-param>
              </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="LinkToInterference"/>
            </xsl:otherwise>
          </xsl:choose>
        </TBODY>
      </TABLE>
    </DD>
    <BR/>
    <BR/>
  </xsl:template>

  <xsl:template match="LinkToInterference">
    <xsl:param name="Pictures">No</xsl:param>
    <TR align="center">
      <xsl:if test="$Pictures='Yes'">

        <TD>
          <A>
            <xsl:attribute name="href">
              <!--	Theoretically, the hypertext link contained in the XML document should use slashes (/)
                    and not backslashes (\), in order to be understood by HTML browsers.
                    However, some old implementations of XML export use backslashes.
                    It is corrected here with the translate() function.-->
              <xsl:value-of select="translate(@Link, '\', '/')"/>
            </xsl:attribute>
            <IMG border="0">
              <xsl:attribute name="src">
                <xsl:value-of select="translate(@FirstProductURL, '\', '/')"/>
              </xsl:attribute>
            </IMG>
            <IMG border="0">
              <xsl:attribute name="src">
                <xsl:value-of select="translate(@SecondProductURL, '\', '/')"/>
              </xsl:attribute>
            </IMG>
          </A>
        </TD>
      </xsl:if>
      <TD class="URLDef" bgcolor="white" >
        <A>
          <xsl:attribute name="href">
            <xsl:value-of select="translate(@Link, '\', '/')"/>
          </xsl:attribute>
          <xsl:value-of select="translate(@LinkTitle, '\', '/')"/>
        </A>
      </TD>
    </TR>
  </xsl:template>

  <!-- template for the root node of detailed XML file -->
  <xsl:template match="InterferenceElement">
    <HEAD>
      <LINK href="../Ressources/ClashPublish.css" rel="stylesheet" type="text/css"/>
    </HEAD>
    <BODY>
      <xsl:call-template name="Header">
        <xsl:with-param name="resourcesPath">../Ressources/</xsl:with-param>
        <xsl:with-param name="title" xml:lang="zh-CN">冲突恢复</xsl:with-param>
      </xsl:call-template>
      <DIV>
        <!-- Here we want to see detailed information about the interference, hence the 'NotFederated1' mode -->
        <xsl:apply-templates select="Interference" mode="Federated1">
          <xsl:with-param name="returnPath">
            <!-- the URL of the 'return' link -->
            <xsl:value-of select="translate(@FederatorFather, '\', '/')"/>#main
          </xsl:with-param>
        </xsl:apply-templates>
      </DIV>
    </BODY>
  </xsl:template>

  <!-- 	This template processes 'Interference' nodes by building a table containing header cells and one row with information about the interference.
	It is called either by the non-federated file or by the detailed file in federated mode.
-->
  <xsl:template match="Interference" mode="Federated1">
    <xsl:param name="returnPath"/>
    <!-- the URL of the 'return' link -->
    <DIV>
      <xsl:attribute name="id"  xml:lang="zh-CN">
        描述<xsl:value-of select="@NumInterf"/>
      </xsl:attribute>
      <DIV class="Title">
        <BR/>
        <BR/>
        <A>
          <xsl:attribute name="name">
            <xsl:value-of select="@NumInterf"/>
          </xsl:attribute>
          <BR/>
          <para xml:lang="zh-CN">
            描述干扰<xsl:value-of select="@NumInterf"/>
          </para>
        </A>
      </DIV>
      <BR/>
      <BR/>
      <TABLE border="1" align="center" bgcolor="#FFFFCC" width="90%">
        <TBODY class="ResultTable">
          <TR align="center">
            <TH xml:lang="zh-CN">干扰</TH>
            <TH xml:lang="zh-CN">产品</TH>
            <TH xml:lang="zh-CN">形状</TH>
            <xsl:if test="Product/@Preview">
              <TH xml:lang="zh-CN">预览</TH>
            </xsl:if>
            <TH xml:lang="zh-CN">类型</TH>
            <TH xml:lang="zh-CN">价值</TH>
            <TH xml:lang="zh-CN">地位</TH>
            <TH xml:lang="zh-CN">冲突评论</TH>
          </TR>
          <!-- Now call the 'Interference' mode template, on the current 'Interference' node Federated2-->
          <xsl:call-template name="InterferenceFederated2" >
            <xsl:with-param name="Previews">
              <xsl:if test="Product/@Preview">Yes</xsl:if>
            </xsl:with-param>
          </xsl:call-template>

        </TBODY>
      </TABLE>
      <DIV align="center">
        <xsl:if test="Picture">
          <IMG border="0">
            <xsl:attribute name="src">
              <xsl:value-of select="translate(Picture/@HRef, '\', '/')"/>
            </xsl:attribute>
          </IMG>
        </xsl:if>
        <BR/>
        <BR/>
        <A class="URLdef">
          <xsl:attribute name="href">
            <xsl:value-of select="$returnPath"/>
          </xsl:attribute>
          <para xml:lang="zh-CN">返回全球结果</para>
        </A>
      </DIV>
      <HR/>
    </DIV>
  </xsl:template>

  <!-- 	This template processes 'Interference' nodes by building a table row containing information about the interference.
  It is called by federated file, in order to put the information about all the interferences in one table
  EPB be carefull difference between apply-templates and call template
  two tags:
  -call-template<=>call to a function always executed!!!
  -apply template<=>code executed only if the tag is found!!!!
  so don't replace call template by apply template in this xsl:
-->
  <xsl:template name="InterferenceFederated2">
    <xsl:param name="Previews">No</xsl:param>
    <!-- is there a column for previews? -->
    <xsl:for-each select="Product">
      <!-- In fact we build a double row (one row per product), but some cells are shared by both rows,
           and thus must be written only on the first pass (position()=1).-->
      <TR align="center">
        <xsl:attribute name="class">
          <xsl:value-of select="../@NumInterf"/>
        </xsl:attribute>
        <xsl:if test="position()=1">
          <TD rowspan="2">
            <xsl:if test="../Picture">
              <A>
                <xsl:attribute name="href">
                  #<xsl:value-of select="../@NumInterf"/>
                </xsl:attribute>
                <IMG border="0" height="120">
                  <xsl:attribute name="src">
                    <xsl:value-of select="../Picture/@HRef"/>
                  </xsl:attribute>
                  <xsl:attribute name="ALT" xml:lang="zh-CN">
                    干扰<xsl:value-of select="../@NumInterf"/>
                  </xsl:attribute>
                </IMG>
              </A>
            </xsl:if>
            <xsl:if test="not(../Picture)" xml:lang="zh-CN">
              干扰<xsl:value-of select="../@NumInterf"/>
            </xsl:if>
          </TD>
        </xsl:if>
        <!--	If it is the first product (position()=1), draw the cell as an upper cell.
              If it is the second product (position()=2), draw it as a lower cell.
              (see SubTable1 and SubTable2 classes in STYLE tag)-->
        <TD>
          <xsl:attribute name="class" xml:lang="zh-CN">
            分表<xsl:value-of select="position()"/>
          </xsl:attribute>
          <SPAN class="ProductName">
            <xsl:value-of select="@Alias"/>
          </SPAN>
        </TD>
        <TD>
          <xsl:attribute name="class" xml:lang="zh-CN">
            分表<xsl:value-of select="position()"/>
          </xsl:attribute>
          <xsl:value-of select="@ShapeName"/>
        </TD>
        <xsl:if test="$Previews='Yes'">
          <TD>
            <xsl:attribute name="class" xml:lang="zh-CN">
              分表<xsl:value-of select="position()"/>
            </xsl:attribute>
            <xsl:if test="@Preview">
              <IMG border="0">
                <xsl:attribute name="src">
                  <xsl:value-of select="translate(@Preview, '\', '/')"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="@Alias"/>
                </xsl:attribute>
              </IMG>
            </xsl:if>
            <xsl:if test="not(@Preview)" xml:lang="zh-CN">没有图像</xsl:if>
          </TD>
        </xsl:if>
        <xsl:if test="position()=1">
          <TD class="ResultType" rowspan="2">
            <xsl:value-of select="../@ResultType"/>
          </TD>
          <TD rowspan="2">
            <xsl:value-of select="../GeometricAspect/@ExtractOrDistValue"/>
          </TD>
          <TD class="ClashStatus" rowspan="2" align="right">
            <xsl:value-of select="../@Status"/>
            <xsl:choose>
              <xsl:when test="../@Status[.='Relevant']">
                <IMG src="../Ressources/I_RedLightXML.bmp" border="0" />
              </xsl:when>
              <xsl:when test="../@Status[.='NotInspected']">
                <IMG src="../Ressources/I_YellowLightXML.bmp" border="0" />
              </xsl:when>
              <xsl:when test="../@Status[.='Irrelevant']">
                <IMG src="../Ressources/I_GreenLightXML.bmp" border="0" />
              </xsl:when>
            </xsl:choose>
          </TD>
          <TD class="Comments" rowspan="2">
            <xsl:value-of select="../Comment/@Value"/>
          </TD>
        </xsl:if>
      </TR>
    </xsl:for-each>
  </xsl:template>

  <!-- 	This template processes 'Interference' nodes by building a table containing header cells and one row with information about the interference.
	It is called either by the non-federated file or by the detailed file in federated mode.
-->
  <xsl:template match="Interference" mode="NotFederated1">
    <xsl:param name="resourcesPath"/>
    <!-- where to find resources      -->
    <xsl:param name="returnPath"/>
    <!-- the URL of the 'return' link -->
    <DIV>
      <xsl:attribute name="id"  xml:lang="zh-CN">
        描述<xsl:value-of select="@NumInterf"/>
      </xsl:attribute>
      <DIV class="Title">
        <BR/>
        <BR/>
        <A>
          <xsl:attribute name="name">
            <xsl:value-of select="@NumInterf"/>
          </xsl:attribute>
          <BR/>
          <para xml:lang="zh-CN">
            描述干扰<xsl:value-of select="@NumInterf"/>
          </para>
        </A>
      </DIV>
      <BR/>
      <BR/>
      <TABLE border="1" align="center" bgcolor="#FFFFCC" width="90%">
        <TBODY class="ResultTable">
          <TR align="center">
            <TH xml:lang="zh-CN">干扰</TH>
            <TH xml:lang="zh-CN">产品</TH>
            <TH xml:lang="zh-CN">形状</TH>
            <xsl:if test="Product/@Preview">
              <TH xml:lang="zh-CN">预览</TH>
            </xsl:if>
            <TH xml:lang="zh-CN">类型</TH>
            <TH xml:lang="zh-CN">价值</TH>
            <TH xml:lang="zh-CN">地位</TH>
            <TH xml:lang="zh-CN">冲突评论</TH>
          </TR>
          <!-- Now call the 'Interference', 'NotFederated2' mode template, on the current 'Interference' node -->
          <xsl:call-template name="InterferenceNotFederated2">
            <xsl:with-param name="Previews">
              <xsl:if test="Product/@Preview">Yes</xsl:if>
            </xsl:with-param>
          </xsl:call-template>
        </TBODY>
      </TABLE>
      <DIV align="center">
        <xsl:if test="Picture">
          <IMG border="0">
            <xsl:attribute name="src">
              <xsl:value-of select="translate(Picture/@HRef, '\', '/')"/>
            </xsl:attribute>
          </IMG>
        </xsl:if>
        <BR/>
        <BR/>
        <A class="URLdef">
          <xsl:attribute name="href">
            <xsl:value-of select="$returnPath"/>
          </xsl:attribute>
          <para xml:lang="zh-CN">返回全球结果</para>
        </A>
      </DIV>
      <HR/>
    </DIV>
  </xsl:template>

  <!-- 	This template processes 'Interference' nodes by building a table row containing information about the interference.
  It is called either by the non-federated file, in order to put the information about all the interferences in one table,
  EPB be carefull we use both apply-templates and call template in NotFederated mode because there is a difference between the
  two tags:
  -call-template<=>call to a function always executed!!!
  -apply template<=>code executed only if the tag is found!!!!
  so don't replace call template by apply template here:
  <xsl:call-template name="Interference">
    <xsl:with-param name="Previews">
      <xsl:if test="Product/@Preview">Yes</xsl:if>
    </xsl:with-param>
  </xsl:call-template
  or you will have big problems in not federated mode with picture:
  Array will be empty where there is Interference description XX
-->
  <xsl:template match="Interference" name="InterferenceNotFederated2" mode="NotFederated2">
    <xsl:param name="Previews">No</xsl:param>
    <!-- is there a column for previews? -->
    <xsl:for-each select="Product">
      <!-- In fact we build a double row (one row per product), but some cells are shared by both rows,
           and thus must be written only on the first pass (position()=1).-->
      <TR align="center">
        <xsl:attribute name="class">
          <xsl:value-of select="../@NumInterf"/>
        </xsl:attribute>
        <xsl:if test="position()=1">
          <TD rowspan="2">
            <xsl:if test="../Picture">
              <A>
                <xsl:attribute name="href">
                  #<xsl:value-of select="../@NumInterf"/>
                </xsl:attribute>
                <IMG border="0" height="120">
                  <xsl:attribute name="src">
                    <xsl:value-of select="../Picture/@HRef"/>
                  </xsl:attribute>
                  <xsl:attribute name="ALT" xml:lang="zh-CN">
                    干扰<xsl:value-of select="../@NumInterf"/>
                  </xsl:attribute>
                </IMG>
              </A>
            </xsl:if>
            <xsl:if test="not(../Picture)" xml:lang="zh-CN">
              干扰<xsl:value-of select="../@NumInterf"/>
            </xsl:if>
          </TD>
        </xsl:if>
        <!--	If it is the first product (position()=1), draw the cell as an upper cell.
              If it is the second product (position()=2), draw it as a lower cell.
              (see SubTable1 and SubTable2 classes in STYLE tag)-->
        <TD>
          <xsl:attribute name="class" xml:lang="zh-CN">
            分表<xsl:value-of select="position()"/>
          </xsl:attribute>
          <SPAN class="ProductName">
            <xsl:value-of select="@Alias"/>
          </SPAN>
        </TD>
        <TD>
          <xsl:attribute name="class" xml:lang="zh-CN">
            分表<xsl:value-of select="position()"/>
          </xsl:attribute>
          <xsl:value-of select="@ShapeName"/>
        </TD>
        <xsl:if test="$Previews='Yes'">
          <TD>
            <xsl:attribute name="class" xml:lang="zh-CN">
              分表<xsl:value-of select="position()"/>
            </xsl:attribute>
            <xsl:if test="@Preview">
              <IMG border="0">
                <xsl:attribute name="src">
                  <xsl:value-of select="translate(@Preview, '\', '/')"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="@Alias"/>
                </xsl:attribute>
              </IMG>
            </xsl:if>
            <xsl:if test="not(@Preview)" xml:lang="zh-CN">没有图像</xsl:if>
          </TD>
        </xsl:if>
        <xsl:if test="position()=1">
          <TD class="ResultType" rowspan="2">
            <xsl:value-of select="../@ResultType"/>
          </TD>
          <TD rowspan="2">
            <xsl:value-of select="../GeometricAspect/@ExtractOrDistValue"/>
          </TD>
          <TD class="ClashStatus" rowspan="2" align="right">
            <xsl:value-of select="../@Status"/>
            <xsl:choose>
              <xsl:when test="../@Status[.='Relevant']">
                <IMG src="Ressources/I_RedLightXML.bmp" border="0" />
              </xsl:when>
              <xsl:when test="../@Status[.='NotInspected']">
                <IMG src="Ressources/I_YellowLightXML.bmp" border="0" />
              </xsl:when>
              <xsl:when test="../@Status[.='Irrelevant']">
                <IMG src="Ressources/I_GreenLightXML.bmp" border="0" />
              </xsl:when>
            </xsl:choose>
          </TD>
          <TD class="Comments" rowspan="2">
            <xsl:value-of select="../Comment/@Value"/>
          </TD>
        </xsl:if>
      </TR>
    </xsl:for-each>
  </xsl:template>

  <!-- template for the root node of the unique XML file in non-federated mode -->
  <xsl:template match="ClashElement">
    <HEAD>
      <LINK href="Ressources/ClashPublish.css" rel="stylesheet" type="text/css"/>
      <!-- script for dynamic HTML -->
      <SCRIPT src="Ressources/dhtml.js"/>
      <!-- script for dynamic filtering -->
      <SCRIPT src="Ressources/DynFilter.js"/>
    </HEAD>
    <BODY>
      <xsl:call-template name="Header">
        <xsl:with-param name="resourcesPath">Ressources/</xsl:with-param>
        <xsl:with-param name="title" xml:lang="zh-CN">冲突出版</xsl:with-param>
      </xsl:call-template>
      <DIV>
        <DL>
          <xsl:apply-templates select="ClashSpec"/>
          <xsl:apply-templates select="ClashResult"/>
        </DL>
      </DIV>
    </BODY>
  </xsl:template>

  <xsl:template match="ClashResult">
    <!-- Create a variable Previews, with the possible values:
         - Yes if there is at least one 'Product' element with a 'Preview' attribute;
         - No in the other cases.-->
    <xsl:variable name="Previews">
      <xsl:if test="Interference/Product/@Preview">Yes</xsl:if>
      <xsl:if test="not(Interference/Product/@Preview)">No</xsl:if>
    </xsl:variable>
    <DT class="Title" 
        onclick="CollExp('ResultBody', 'TriangleResult')" 
        onmouseover="this.className='TitleOn'; showHint('Collapse/Expand')" 
        onmouseout="this.className='Title'; hideHint()">
      <A name="main">
        <BR/>
        <IMG id="TriangleResult" 
             src="Ressources/d.bmp" 
             xml:lang="zh-CN"/>计算结果
      </A>
    </DT>
    <BR/>
    <BR/>
    <DD>
      <P align="center" id="Overview">
        <xsl:value-of select="@TabTitle"/>
      </P>
    </DD>
    <DD id="ResultBody">
      <SPAN class="SubTitle" 
            onclick="CollExp('filterFormDiv', 'TriangleForm')" 
            onmouseover="this.className='SubTitleOn'; showHint('Collapse/Expand')" 
            onmouseout="this.className='SubTitle'; hideHint()">
        <IMG id="TriangleForm" 
             src="Ressources/r.bmp" 
             xml:lang="zh-CN"/>过滤选项
      </SPAN>
      <BR/>
      <DIV id="filterFormDiv" style="display:none">
        <FORM id="FilterForm" onsubmit="filter(); return false">
          <TABLE border="0">
            <TR class="Form">
              <TD xml:lang="zh-CN">
                滤波器的产品名称或意见:
              </TD>
              <TD>
                <TABLE border="0">
                  <TR onclick="clickBox(this)" 
                      onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="radio" 
                             name="Radio" 
                             id="Radio1" 
                             value="all" 
                             checked="true"/>
                    </TD>
                    <TD xml:lang="zh-CN">不过滤</TD>
                  </TR>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="radio" 
                             name="Radio" 
                             id="Radio2" 
                             value="productText" 
                             onclick="radio23Click()"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">其产品名称中包含:</TD>
                  </TR>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="radio" 
                             name="Radio" 
                             id="Radio3" 
                             value="commentsText" 
                             onclick="radio23Click()"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">凡干扰评论内容:</TD>
                  </TR>
                </TABLE>
              </TD>
              <TD valign="middle">
                <INPUT type="text" id="FilterText" size="20"/>
              </TD>
            </TR>
            <TR class="Form">
              <TD xml:lang="zh-CN">滤波器的干扰类型:</TD>
              <TD colspan="2">
                <TABLE>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="checkbox" 
                             id="AllTypesChk" 
                             checked="true" 
                             onclick="allChkClick(this)"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">所有类型</TD>
                  </TR>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="checkbox" 
                             id="ClashChk" 
                             checked="true" 
                             onclick="typeChkClick(this)"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">冲突</TD>
                  </TR>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="checkbox" 
                             id="ContactChk" 
                             checked="true" 
                             onclick="typeChkClick(this)"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">接触</TD>
                  </TR>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="checkbox" 
                             id="ClearanceChk" 
                             checked="true" 
                             onclick="typeChkClick(this)"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">清拆</TD>
                  </TR>
                </TABLE>
              </TD>
            </TR>
            <TR class="Form">
              <TD xml:lang="zh-CN">滤波器的地位:</TD>
              <TD>
                <TABLE>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="checkbox" 
                             id="AllStatChk" 
                             checked="true" 
                             onclick="allChkClick(this)"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">所有状况</TD>
                  </TR>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="checkbox" 
                             id="RelevantChk" 
                             checked="true" 
                             onclick="statChkClick(this)"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">有关</TD>
                  </TR>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="checkbox" 
                             id="NotInspectedChk" 
                             checked="true" 
                             onclick="statChkClick(this)"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">不检查</TD>
                  </TR>
                  <TR onmouseover="this.className='clsMouseOver'" 
                      onmouseout="this.className=''">
                    <TD>
                      <INPUT type="checkbox" 
                             id="IrrelevantChk" 
                             checked="true" 
                             onclick="statChkClick(this)"/>
                    </TD>
                    <TD onclick="clickBox(this.parentNode)" 
                        xml:lang="zh-CN">不相干</TD>
                  </TR>
                </TABLE>
              </TD>
              <TD valign="middle" align="center">
                <TABLE width="100%">
                  <TR>
                    <TD class="Button" 
                        style="font-weight='bold'" 
                        onclick="filter()" 
                        onmouseover="this.className='ButtonOn'" 
                        onmouseout="this.className='Button'" 
                        xml:lang="zh-CN">滤波器</TD>
                  </TR>
                  <TR>
                    <TD class="Button" 
                        style="font-size='10pt'" 
                        onclick="resetForm()" 
                        onmouseover="this.className='ButtonOn'" 
                        onmouseout="this.className='Button'" 
                        xml:lang="zh-CN">复位</TD>
                  </TR>
                </TABLE>
              </TD>
            </TR>
          </TABLE>
        </FORM>
      </DIV>

      <BR/>
      <TABLE class="ResultTable" border="1" bgcolor="#FFFFCC" width="90%">
        <TBODY id="ClashTable">
          <TR align="center">
            <TH xml:lang="zh-CN">干扰</TH>
            <TH xml:lang="zh-CN">产品</TH>
            <TH xml:lang="zh-CN">形状</TH>
            <xsl:if test="Product/@Preview">
              <TH xml:lang="zh-CN">预览</TH>
            </xsl:if>
            <TH xml:lang="zh-CN">类型</TH>
            <TH xml:lang="zh-CN">价值</TH>
            <TH xml:lang="zh-CN">地位</TH>
            <TH xml:lang="zh-CN">冲突评论</TH>
          </TR>
          <xsl:apply-templates select="Interference" mode="NotFederated2">            
            <xsl:with-param name="Previews">
              <xsl:value-of select="$Previews"/>
            </xsl:with-param>
          </xsl:apply-templates>
        </TBODY>
      </TABLE>
    </DD>
    <BR/>
    <BR/>
    <HR/>
    <!-- Then display a detailed description of each interference that has a Picture element
         (if it has no picture, there is no more information than in the previous table)-->
    <xsl:apply-templates select="Interference[Picture]" mode="NotFederated1">
      <xsl:with-param name="resourcesPath">Ressources/</xsl:with-param>
      <xsl:with-param name="returnPath">#main</xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>