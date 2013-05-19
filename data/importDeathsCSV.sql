/*
* PGSQL Insertion Script
* Tested on Kyng Chaos PGSQL 9.2 installation on Mac OS X 10.8.3
* 1/ Download the CSV from The Guardian ("Download the Full Sheet" link)
* http://www.guardian.co.uk/news/datablog/2010/oct/23/wikileaks-iraq-data-journalism#data
* 2/ Remove the header line of the CSV
* 3/ Copy the CSV in a folder where your postgres user have access (/tmp on macos)
* 4/ If needed, change the Owner and Path to CSV in the script
* 5/ ???
* 6/ Profit
*/

/* CREATE TABLE AND INDEXES */
CREATE TABLE iraq_osm_wikileaks
(
  reportkey character(255) NOT NULL DEFAULT ''::bpchar,
  date timestamp without time zone,
  "type" character(255) DEFAULT NULL::bpchar,
  category character(255) DEFAULT NULL::bpchar,
  title text,
  region character(255) DEFAULT NULL::bpchar,
  attackon character(255) DEFAULT NULL::bpchar,
  friendlywia integer,
  friendlykia integer,
  hostnationwia integer,
  hostnationkia integer,
  civilianwia integer,
  civiliankia integer,
  enemywia integer,
  enemykia integer,
  enemydetained integer,
  totaldeaths integer,
  latitude double precision,
  longitude double precision
) WITH (
  OIDS=FALSE
);
/* CHANGE OWNER IF NEEDED */
ALTER TABLE iraq_osm_wikileaks OWNER TO postgres;

CREATE INDEX iraq_osm_wikileaks_attackon_idx
  ON iraq_osm_wikileaks
  USING btree
  (attackon);

CREATE INDEX iraq_osm_wikileaks_category_idx
  ON iraq_osm_wikileaks
  USING btree
  (category);

CREATE INDEX iraq_osm_wikileaks_civiliankia_idx
  ON iraq_osm_wikileaks
  USING btree
  (civiliankia);

CREATE INDEX iraq_osm_wikileaks_civilianwia_idx
  ON iraq_osm_wikileaks
  USING btree
  (civilianwia);

CREATE INDEX iraq_osm_wikileaks_date_idx
  ON iraq_osm_wikileaks
  USING btree
  (date);

CREATE INDEX iraq_osm_wikileaks_enemydetained_idx
  ON iraq_osm_wikileaks
  USING btree
  (enemydetained);

CREATE INDEX iraq_osm_wikileaks_enemykia_idx
  ON iraq_osm_wikileaks
  USING btree
  (enemykia);

CREATE INDEX iraq_osm_wikileaks_enemywia_idx
  ON iraq_osm_wikileaks
  USING btree
  (enemywia);

CREATE INDEX iraq_osm_wikileaks_friendlykia_idx
  ON iraq_osm_wikileaks
  USING btree
  (friendlykia);

CREATE INDEX iraq_osm_wikileaks_friendlywia_idx
  ON iraq_osm_wikileaks
  USING btree
  (friendlywia);

CREATE INDEX iraq_osm_wikileaks_hostnationkia_idx
  ON iraq_osm_wikileaks
  USING btree
  (hostnationkia);

CREATE INDEX iraq_osm_wikileaks_hostnationwia_idx
  ON iraq_osm_wikileaks
  USING btree
  (hostnationwia);

CREATE INDEX iraq_osm_wikileaks_latitude_idx
  ON iraq_osm_wikileaks
  USING btree
  (latitude);

CREATE INDEX iraq_osm_wikileaks_longitude_idx
  ON iraq_osm_wikileaks
  USING btree
  (longitude);

CREATE INDEX iraq_osm_wikileaks_totaldeaths_idx
  ON iraq_osm_wikileaks
  USING btree
  (totaldeaths);

CREATE INDEX iraq_osm_wikileaks_region_idx
  ON iraq_osm_wikileaks
  USING btree
  (region);

CREATE INDEX iraq_osm_wikileaks_reportkey_idx
  ON iraq_osm_wikileaks
  USING btree
  (reportkey);

CREATE INDEX iraq_osm_wikileaks_type_idx
  ON iraq_osm_wikileaks
  USING btree
  (type);
/* CHANGE DATESTYLE FOR INSERTION */
SET datestyle = "ISO, DMY";
/* COPY THE FILE IN /tmp/ FOR PERMISSIONS */
COPY iraq_osm_wikileaks FROM '/tmp/Deathsonly.csv' WITH DELIMITER ',' CSV QUOTE '"';
/* SET DATESTYLE BACK TO DEFAULT */
SET datestyle = default;
