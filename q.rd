<resource schema="mars_craters">
	<meta name="title">Mars Craters</meta>
	<meta name="description">
		This resource extends the Mars craters catalog from Robbins and Hynek (2012)
		catalog and 185 craters
		added by Lagain et al (2020).
		The object Ids in this table are compatible to Robbins and Hynek' catalog.
	</meta>
	<meta name="creationDate">2017-08-28T12:55:00</meta>
	<meta name="subject">Mars, crater, geology, surface, topography</meta>
	<meta name="creator.name">Mikhail Minin</meta>
	<meta name="instrument">THEMIS Daytime IR</meta>
	<meta name="facility">Jacobs University</meta>
	<meta name="source">https://doi.org/10.1016/j.pss.2019.104755</meta>
	<meta name="contentLevel"></meta>
	<meta name="type">Catalog</meta>
	<meta name="coverage"></meta>

	<table id="epn_core" onDisk="true">
		<meta name="info" infoName="SERVICE_PROTOCOL" infoValue="0.3">
			EPN-TAP
		</meta>
		<mixin spatial_frame_type="body" optional_columns="target_region">
			//epntap2#table-2_0
		</mixin>
		<stc>
			Polygon ICRS [s_region]
		</stc>
    <column
			lname="radius"
			type="double precision"
			ucd="meta.note;meta.main"
			unit="m"
			tablehead="radius"
			verbLevel="1"
			description="radius from THEMIS IR"
		/>
		<column
			lname="type"
			type="integer"
			ucd="meta.note;meta.main"
			tablehead="type"
			verbLevel="1"
			description="Crater classification (int): 1=Valid, 2=Layered ejecta, 3=Ghost, 4=Secondary, 5=False detections."
		/>
    <column
			lname="status"
			type="text"
			ucd="meta.note;meta.main"
			tablehead="status"
			verbLevel="1"
			description="Crater classification."
		/>
    <column
			lname="LRD_MORPH"
			type="text"
			ucd="meta.note;meta.main"
			tablehead="Layered ejecta crater morphology"
			verbLevel="1"
			description="SLE : Single Layered Ejecta, DLE : Double Layered Ejecta MLE : Multiple Layered Ejecta, LARLE : Low-Aspect Ratio Layered Ejecta."
		/>
    <column
			lname="type"
			type="text"
			ucd="meta.note;meta.main"
			tablehead="type"
			verbLevel="1"
			description="1=Valid, 2=Layered ejecta, 3=Ghost, 4=Secondary, 5=False detections."
		/>
    <column
			lname="origin"
			type="text"
			ucd="meta.note;meta.main"
			tablehead="origin"
			verbLevel="1"
			description="Primary crater ID for secondary craters."
		/>
    <column
			lname="adding"
			type="text"
			ucd="meta.note;meta.main"
			tablehead="adding"
			verbLevel="1"
			description="null = Craters contained in the Robbins' database, 1 = Craters added by the reviewers"
		/>
		<publish sets="ivo_managed,local"/>
	</table>

	<data id="import">
		<sources>data/data.csv</sources>
		<csvGrammar>
			<rowfilter procDef="//products#define">
				<bind name="table">"schema.epn_core"</bind>
			</rowfilter>
		</csvGrammar>
		<make table="epn_core">
			<rowmaker idmaps="*">
				<var key="granule_uid" source="CRATER_ID" />
				<var key="granule_gid">(@granule_uid)[:2]</var>
				<var key="obs_id">(@granule_uid)[-6:]</var>
				<var key="dataproduct_type">"ci"</var>
				<var key="measurement_type">"pos.bodyrc"</var>
				<var key="processing_level">"5"</var>
				<var key="target_name">"Mars"</var>
				<var key="target_class">"planet"</var>
				<var key="c1min" source="Lon" />
				<var key="c1max" source="Lon" />
				<var key="c2min" source="Y" />
				<var key="c2max" source="Y" />
				<var key="spatial_frame_type">"body"</var>
				<var key="radius" source="RADIUS" />
				<var key="s_region">pgsphere.SCircle(pgsphere.SPoint.fromDegrees(@c1min,@c2min),(@radius/(math.pi*3390.0*1000.0/180.0))*pgsphere.DEG).asPoly().asSTCS("UNKNOWNFrame")</var>
				<var key="instrument_host_name">"Mars Odyssey"</var>
				<var key="instrument_name">"THEMIS"</var>
				<var key="service_title">"Mars_craters_dev"</var>
				<var key="creation_date">"2018-01-12"</var>
				<var key="modification_date">"2018-01-26"</var>
				<var key="release_date">"2017-01-12"</var>
				<var key="target_region">"craters"</var>
				<var key="status" source="STATUS" />
				<var key="type" source="TYPE" />
				<var key="LRD_MORPH" source="LRD_MORPH" />
				<var key="adding" source="ADDING" />
				<var key="origin" source="ORIGIN" />

				<apply procDef="//epntap2#populate-2_0" name="fillepn">
					<bind name="granule_uid">@granule_uid</bind>
					<bind name="granule_gid">@granule_gid</bind>
					<bind name="obs_id">@obs_id</bind>
					<bind name="dataproduct_type">@dataproduct_type</bind>
					<bind name="measurement_type">@measurement_type</bind>
					<bind name="processing_level">@processing_level</bind>
					<bind name="target_name">@target_name</bind>
					<bind name="target_class">@target_class</bind>
					<bind name="c1min">@c1min</bind>
					<bind name="c1max">@c1max</bind>
					<bind name="c2min">@c2min</bind>
					<bind name="c2max">@c2max</bind>
					<bind name="s_region">@s_region</bind>
					<bind name="instrument_host_name">@instrument_host_name</bind>
					<bind name="instrument_name">@instrument_name</bind>
					<bind name="service_title">@service_title</bind>
					<bind name="creation_date">@creation_date</bind>
					<bind name="modification_date">@modification_date</bind>
					<bind name="release_date">@release_date</bind>
					<bind name="target_region">@target_region</bind>
				</apply>
			</rowmaker>
		</make>
	</data>
</resource>
