<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html"/> 
	<xsl:template match="/">
		<html>
			<head>
				<title>Университети в България</title>
				<link rel="stylesheet" type="text/css" href="style.css" />
			</head>
			<script>
				function showUniversities() {
					document.getElementById('universityContainer').style.display = 'inline';
					document.getElementById('regionContainer').style.display = 'none';
					document.getElementById('branchContainer').style.display = 'none';
				};
				function showRegions() {
					document.getElementById('universityContainer').style.display = 'none';
					document.getElementById('regionContainer').style.display = 'inline';
					document.getElementById('branchContainer').style.display = 'none';
				};
				function showBranches() {
					document.getElementById('universityContainer').style.display = 'none';
					document.getElementById('regionContainer').style.display = 'none';
					document.getElementById('branchContainer').style.display = 'inline';
				};
			</script>
			<body>
				<h1> Университети в България</h1>
				<button class="button" onclick="showUniversities();">Университети</button>
				<button class="button" onclick="showRegions()">Региони</button>
				<button class="button" onclick="showBranches()">Филиали</button>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="/universitiesBG/universityList">
		<div id="universityContainer">
			<xsl:for-each select="/universitiesBG/universityList/university/universityInfo[id &lt; 47]">
				<xsl:sort
					select = "students"
					data-type="number"
					order = "descending">
				</xsl:sort>

				<div style="color:white;" class="university">
					<img src="images/{id}.jpg"/>
					<div id="information">
						<h3 id="uniName"><xsl:value-of select="name"/></h3>
						<div id="uniInfo">
							<p class="label" >Седалище:</p>
							<p><xsl:value-of select="location"/></p>
							<p class="label">Регион:</p>
							<p><xsl:value-of select="region"/></p>
						</div>
						<div id="extraInfo">
							<p class="label" >Година:</p>
							<p><xsl:value-of select="year"/></p>
							<p class="label" >Студенти:</p>
							<p><xsl:value-of select="students"/></p>
						</div>
						<div id="contacts">
							<p class="label" >Телефон:</p>
							<p><xsl:value-of select="telephone"/></p>
							<xsl:if test="secondTelephone">
								<p class="label" >Допълнителен телефон:</p>
								<p><xsl:value-of select="secondTelephone"/></p>
							</xsl:if>
						</div>
						<div id="online">
							<p class="label" >Сайт:</p>
							<a href="{webSite/@href}"><xsl:value-of select="webSite"/></a>
						</div>
						<div class="dropdown">
							<p class="label">Факултети</p>
							<div class="dropdown-content">
								<xsl:for-each select="../facultyList/faculty">
									<p class="faculty"><xsl:value-of select="."/></p>
								</xsl:for-each>
							</div>
						</div>
					</div>
				</div> 
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template match="/universitiesBG/regionList">
		<div id="regionContainer" style="display:none;">
			<xsl:for-each select="/universitiesBG/regionList/regionInfo">
				<xsl:variable name="rName"><xsl:value-of select="regionName"/></xsl:variable>
				<xsl:variable name="rId"><xsl:value-of select="regionRef/@regIdRef"/></xsl:variable>
				<div style="color:white;" class="region">
					<p id="regionLabel"><xsl:value-of select="regionName"/></p>
					<div>
						<xsl:for-each select="/universitiesBG/universityList/university/universityInfo[regionId = $rId]">					
							<div style="color:white;" class="specialRegion">
								<img src="images/{id}.jpg"/>
								<div class="information2">
									<p id="uniName1"><xsl:value-of select="name"/></p>
									<xsl:if test="branchName">
										<p id="branchName"><xsl:value-of select="branchName"/></p>
									</xsl:if>
									<div class="uniInfo2">
										<p class="label" >Седалище:</p>
										<p><xsl:value-of select="location"/></p>
										<p class="label" >Регион:</p>
										<p><xsl:value-of select="region"/></p>
										<p class="label" >Година:</p>
										<p><xsl:value-of select="year"/></p>
									</div>
									<div class="uniContacts">
										<p class="label" >Телефон:</p>
										<p><xsl:value-of select="telephone"/></p>
										<xsl:if test="secondTelephone">
											<p class="label" >Допълнителен телефон:</p>
											<p><xsl:value-of select="secondTelephone"/></p>
										</xsl:if>
										<xsl:if test="webSite">
											<p class="label" >Сайт:</p>
											<a href="{webSite/@href}"><xsl:value-of select="webSite"/></a>
										</xsl:if>
									</div>
									<div class="dropdown">
										<p class="label">Факултети</p>
										<div class="dropdown-content">
											<xsl:for-each select="../facultyList/faculty">
												<p class="faculty"><xsl:value-of select="."/></p>
											</xsl:for-each>
										</div>
									</div>
								</div>
							</div>
						</xsl:for-each>
					</div>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xsl:template match="/universitiesBG/branchList">
		<div id="branchContainer" style="display:none;">
			<xsl:for-each select="/universitiesBG /branchList/branch">
				<xsl:variable name="sName"><xsl:value-of select="seatName"/></xsl:variable>
				<xsl:variable name="sId"><xsl:value-of select="uni/@idRef"/></xsl:variable>
				<div style="color:white;" class="branch">
					<p id="seatLabel"><xsl:value-of select="seatName"/></p>
					<div>
						<xsl:for-each select="/universitiesBG/universityList/university/universityInfo[name =$sName and id != $sId]">					
							<div style="color:white;" class="specialBranch">
								<img src="images/{id}.jpg"/>
								<div class="information2">		
									<p id="branchName"><xsl:value-of select="branchName"/></p>
									<div class="uniInfo2">
										<p class="label" >Седалище:</p>
										<p><xsl:value-of select="location"/></p>
										<p class="label" >Регион:</p>
										<p><xsl:value-of select="region"/></p>
										<p class="label" >Година:</p>
										<p><xsl:value-of select="year"/></p>
									</div>
									<div class="uniContacts">
										<p class="label" >Телeфон:</p>
										<p><xsl:value-of select="telephone"/></p>
										<xsl:if test="secondTelephone">
											<p class="label" >Допълнителен телефон:</p>
											<p><xsl:value-of select="secondTelephone"/></p>
										</xsl:if>
										<xsl:if test="webSite">
											<p class="label" >Сайт:</p>
											<a href="{webSite/@href}"><xsl:value-of select="webSite"/></a>
										</xsl:if>
									</div>
									<div class="dropdown">
										<p class="label">Факултети</p>
										<div class="dropdown-content">
											<xsl:for-each select="../facultyList/faculty">
												<p class="faculty"><xsl:value-of select="."/></p>
											</xsl:for-each>
										</div>
									</div>
								</div>
							</div>
						</xsl:for-each>
					</div>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
</xsl:stylesheet>