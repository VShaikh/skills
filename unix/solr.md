## Install Solr

```
cd /opt/solr/bin
./solr create -c mytube -n data_driven_schema_configs

help me to create a solr schema file so that i can store below fields in a collection named my_tube:

fields:
	visual_id: string (primary key)
	actor_dir: string
	actor_name: string
	visual_file_name: string
	visual_file_path: string
	visual_width: integer
	visual_height: integer
	visual_length: integer
	visual_fps: integer
	visual_size: integer
	visual_created: date
	visual_created_ts: long
	visual_is_vr: bool
	visual_is_liked: bool
```

```
solr create -c my_tube -n _default
```

```
<?xml version="1.0" encoding="UTF-8" ?>
<schema name="my_tube" version="1.6">

  <!-- Primary key -->
  <field name="visual_id" type="string" indexed="true" stored="true" required="true" multiValued="false"/>
  <uniqueKey>visual_id</uniqueKey>

  <!-- Actor metadata -->
  <field name="actor_dir"        type="string"    indexed="true" stored="true"/>
  <field name="actor_name"       type="string"    indexed="true" stored="true"/>

  <!-- Visual (video) metadata -->
  <field name="visual_file_name" type="string"    indexed="true" stored="true"/>
  <field name="visual_file_path" type="string"    indexed="true" stored="true"/>
  <field name="visual_width"     type="pint"      indexed="true" stored="true"/>
  <field name="visual_height"    type="pint"      indexed="true" stored="true"/>
  <field name="visual_length"    type="pint"      indexed="true" stored="true"/>
  <field name="visual_fps"       type="pint"      indexed="true" stored="true"/>
  <field name="visual_size"      type="plong"     indexed="true" stored="true"/>
  <field name="visual_created"   type="pdate"     indexed="true" stored="true"/>
  <field name="visual_created_ts" type="plong"    indexed="true" stored="true"/>
  <field name="visual_is_vr"     type="boolean"   indexed="true" stored="true"/>
  <field name="visual_is_liked"  type="boolean"   indexed="true" stored="true"/>

  <!-- Default full-text field -->
  <field name="_text_" type="text_general" multiValued="true" indexed="true" stored="false"/>

  <!-- Copy key string fields for search -->
  <copyField source="actor_name"       dest="_text_"/>
  <copyField source="visual_file_name" dest="_text_"/>
  <copyField source="visual_file_path" dest="_text_"/>

</schema>
```
