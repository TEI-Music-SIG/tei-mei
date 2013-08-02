# TEI with Music Notation (MEI)

This is a collection of ODD documents to generate TEI with MEI XML schemas using Roma (command line only). Pre-generated RelaxNGs are included.

The MEI source is up-to-date with the 2013 release. N.B. *It has been altered to include internal prefixes to avoid conflicts with TEI elements with the same name*. 

For more information visit:

* The TEI Music SIG [webspace](http://www.tei-c.org/SIG/Music/)
* The TEI with Music Notation [Guidelines](http://www.tei-c.org/SIG/Music/twm/index.html)
* The TEI Music SIG [wiki](http://wiki.tei-c.org/index.php/SIG:Music)

# Generating Schemata

To generate a new schema, you will need to use command-line Roma, beacuse the ODDs look for mei-source.xml to load MEI modules.

Copy (or link to) mei-source.xml in Roma's directory, then run command-line Roma normally:

`$ roma2.sh tei-lite_mei-cmn.xml`

# Creating new ODDs

There are two things to keep in mind:

* To load MEI modules, use @source

`<moduleRef key="MEI" source="mei-source.xml"/>`

* the elementSpec for notatedMusic must be changed to include MEI at various levels. See any of the ODDs as an example.

If you create a new ODD, please fork this repo and send a pull request! :)

## Updating MEI version

The process to update to another MEI version is a bit fiddly, but here are the steps:

* Canonicalize new MEI source from MEI's [subversion](https://code.google.com/p/music-encoding/)
* Rename mei-source.xml to old-mei-source.xml
* Run utils/add_prefixes.xsl to generate a new mei-source.xml. This applies all prefixes from the previous version to the new one.
* Test through command line Roma, if there are new errors, add missing prefixes manually (that's right... though they're usually very few!)
