<resource schema="mars_craters">
<!--	<meta name="title">Martian Impact Craters</meta> -->
	<meta name="title">Mars_craters</meta>
	<meta name="description">
Mars Crater Catalog by S.J. Robbins was generated from THEMIS Daytime IR &amp; Viking MDIM 2.1 global mosaics of Mars. Craters were selected using 5 points along the rim. Table is statistically complete to the 
diameter of ~1.0 km. Table contains morphologic and morphometric data for craters with diameter larger than 3 km. Prometheus basin has been excluded from the Catalog due to technical issues. Robbins, S.J., and B.M. Hynek (2012). A New Global Database of Mars Impact 
Craters ≥1 km: 1. Database Creation, Properties, and Parameters. Journal of Geophysical Research – Planets, 117, E05004. doi: 10.1029/2011JE003966
</meta>
	<meta name="creationDate">2016-05-12T00:00:00</meta>
	<meta name="subject">_____</meta>
	<meta name="creator.name">Mikhail Minin</meta>
	<meta name="contact.name">Mikhail Minin</meta>
	<meta name="contact.email">m.minin@jacobs-university.de</meta>
	<meta name="instrument">THEMIS Daytime IR</meta>

        <meta name="subjects">Mars, crater, geology, surface, topography</meta>

	<meta name="facility">Jacobs University</meta>
	<meta name="source">Stuart Robbins, Laboratory for Atmospheric and Space Physics, University of Colorado at Boulder, Boulder, Colorado, USA.</meta>
	<meta name="contentLevel"></meta>
	<meta name="type">Catalog</meta>
	<meta name="coverage"><!--wavelengths, etc--></meta>

<!-- METADATA COMPLETE -->

	<table id="epn_core" adql="True" onDisk="True">
		<mixin spatial_frame_type="body" optional_columns="target_region bib_reference">//epntap2#table-2_0</mixin>
		<meta name="description">Global Catalog of Martian Impact Craters, Complete to 1.0-km in Diameter by Stuart Robbins, 2009-present</meta>
		<stc>Polygon UNKNOWNFrame [s_region]</stc>

<column name="diameter" type="double precision" ucd="meta.note;meta.main" tablehead="Diameter" verbLevel="1" description="diameter from THEMIS IR, non standard" />
<column name="depth" type="double precision" ucd="meta.note;meta.main" tablehead="Depth" verbLevel="1" description="depth surface to floor, non standard" />


<column name="target_region" type="text" ucd="meta.id;class" tablehead="Target Region" verbLevel="1" description="type of region of interest" />
<column name="feature_name" type="text" ucd="meta.note;meta.main" tablehead="Feature Name" verbLevel="1" description="secondary name" />

<column name="degradation_state" type="text" ucd="meta.note;meta.main" tablehead="Degradation State" verbLevel="1" description="non standard" />
<column name="crater_morphology_1" type="text" ucd="meta.note;meta.main" tablehead="Crater Morphology 1" verbLevel="1" description="non standard" />
<column name="crater_morphology_2" type="text" ucd="meta.note;meta.main" tablehead="Crater Morphology 2" verbLevel="1" description="non standard" />
<column name="crater_morphology_3" type="text" ucd="meta.note;meta.main" tablehead="Crater Morphology 3" verbLevel="1" description="non standard" />
<column name="ejecta_morphology_1" type="text" ucd="meta.note;meta.main" tablehead="Ejecta Morphology 1" verbLevel="1" description="non standard" />
<column name="ejecta_morphology_2" type="text" ucd="meta.note;meta.main" tablehead="Ejecta Morphology 2" verbLevel="1" description="non standard" />

<column name="s_region" xtype="adql:REGION" type="spoly" ucd="phys.outline;obs.field" description="Provides footprint" />


		<publish sets="ivo_managed,local"/>
	</table>
<!-- TABLE COMPLETE -->

	<data id="import">
		<sources>data/robins03.csv</sources>
		<csvGrammar>
			<rowfilter procDef="//products#define">
				<bind name="table">"schema.epn_core"</bind>
			</rowfilter>
		</csvGrammar>
		<make table="epn_core">
			<rowmaker idmaps="*">

<var key="diameter"            source="DIAM_CIRCLE_IMAGE"      />
<var key="depth"               source="DEPTH_SURFFLOOR_TOPOG"  />
<var key="feature_name"        source="CRATER_NAME"            />
<var key="degradation_state"   source="DEGRADATION_STATE"      />
<var key="crater_morphology_1" source="MORPHOLOGY_CRATER_1"    />
<var key="crater_morphology_2" source="MORPHOLOGY_CRATER_2"    />
<var key="crater_morphology_3" source="MORPHOLOGY_CRATER_3"    />
<var key="ejecta_morphology_1" source="MORPHOLOGY_EJECTA_1"    />
<var key="ejecta_morphology_2" source="MORPHOLOGY_EJECTA_2"    />

				<var key="granule_uid" source="CRATER_ID" />
				<var key="granule_gid">(@granule_uid)[:2]</var>
				<var key="obs_id">(@granule_uid)[-6:]</var>

				<var key="dataproduct_type">"ci"</var>
				<var key="measurement_type">"pos.bodyrc"</var>

				<var key="target_name">"Mars"</var>
				<var key="target_class">"planet"</var>

				<var key="c1min" source="LONGITUDE_CIRCLE_IMAGE" />
				<var key="c1min">360-[@c1min+360,@c1min][@c1min>0]</var>
<var key="c1min">360-@c1min</var>
<var key="c1max">@c1min</var>

				<var key="c2min" source="LATITUDE_CIRCLE_IMAGE" />
				<var key="c2max" source="LATITUDE_CIRCLE_IMAGE" />

				<var key="spatial_frame_type">"body"</var>
				<var key="processing_level">5</var>

				<var key="instrument_host_name">"Mars Odyssey"</var>
				<var key="instrument_name">"THEMIS"</var>

<var key="target_region">"craters"</var>

<!--HERE WE SET CRS TO EAST INCREASING-->

<var key="s_region">pgsphere.SCircle(pgsphere.SPoint.fromDegrees(@c1min,@c2min),(@diameter/(2.0*math.pi*3390.0/180.0))*pgsphere.DEG).asPoly().asSTCS("UNKNOWNFrame")</var>

<!-- THIS IS NOW OBSOLETE, GOING TO USE PGSPHERE INSTEAD:
<var key="s_region">
'Polygon '+' '.join([' '.join(i) for i in map(lambda t: (str((-t[3])+(t[1]*((t[2]) / 2.0))/(math.pi*3390.0*math.cos(((t[4])+(t[0]*((t[2]) / 2.0))/    \
(math.pi*3390.0 / 180.0))*math.pi/180.0) / 180.0)),str((t[4])+t[0]*((t[2]) / 2.0)/(math.pi*3390.0 / 180.0))),                                        \
[(1,0,vars["diameter"],vars["c1min"],vars["c2min"]),(.7,.7,vars["diameter"],vars["c1min"],vars["c2min"]),(0,1,vars["diameter"],                      \
vars["c1min"],vars["c2min"]),(-.7,.7,vars["diameter"],vars["c1min"],vars["c2min"]),(-1,0,vars["diameter"],vars["c1min"],vars["c2min"]),              \
(-.7,-.7,vars["diameter"],vars["c1min"],vars["c2min"]),(0,-1,vars["diameter"],vars["c1min"],vars["c2min"]),(.7,-.7,vars["diameter"],                 \
vars["c1min"],vars["c2min"])])])
</var>
-->

<var key="bib_reference">"10.1029/2011JE003967"</var>


<var key="service_title">"Mars_craters"</var>

<var key="creation_date">"2016-1-1"</var>
<var key="modification_date">"2016-1-1"</var>
<var key="release_date">"2016-1-1"</var>


				<apply procDef="//epntap2#populate-2_0" name="fillepn">
<bind name="processing_level">@processing_level</bind>
					<bind name="granule_uid">@granule_uid</bind>
					<bind name="granule_gid">@granule_gid</bind>
					<bind name="obs_id">@obs_id</bind>

					<bind name="dataproduct_type">@dataproduct_type</bind>
					<bind name="measurement_type">@measurement_type</bind>

					<bind name="target_name">@target_name</bind>
					<bind name="target_class">@target_class</bind>

					<bind name="c1min">@c1min</bind>
					<bind name="c1max">@c1max</bind>

					<bind name="c2min">@c2min</bind>
					<bind name="c2max">@c2max</bind>

					<bind name="instrument_host_name">@instrument_host_name</bind>
					<bind name="instrument_name">@instrument_name</bind>



<bind name="service_title">@service_title</bind>

<bind name="creation_date">@creation_date</bind>
<bind name="modification_date">@modification_date</bind>
<bind name="release_date">@release_date</bind>


<!-- QUICK FIX -->

<bind name="s_region">@s_region</bind>

<!-- QUICK FIX ENDS -->

				</apply>
			</rowmaker>
		</make>
	</data>
</resource>
