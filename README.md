Iraq War Logs
===========

Code used for generating a pixel plot of the deaths in the SIGACT database released by [Wikileaks](http://wikileaks.org/irq/) and cleaned by [The Guardian](http://www.guardian.co.uk/news/datablog/2010/oct/23/wikileaks-iraq-data-journalism#data)
***

Requirements
-----------

* The Guardian cleaned dump ["Download the Full Sheet" link on this page](http://www.guardian.co.uk/news/datablog/2010/oct/23/wikileaks-iraq-data-journalism#data)
* PostgreSQL (tested on Mac OS X 10.8.3 with [Kyng Chaos' PostgreSQL 9.2.4-2 Package](http://www.kyngchaos.com/software/postgres))
* [Processing](http://processing.org/) (Tested on 2.0b9)
* [PGSQL Connector](http://jdbc.postgresql.org/download.html)

You'll find a importDeathsCSV.sql script in the data folder to create the pgsql table and import the CSV in it.

License
-----------
No license, nothing, do whatever you want, but be kind, cite your sources