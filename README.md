# TEI with Music Notation (MEI)

This is a collection of ODD documents to generate TEI with MEI XML schemas using Roma (command line only). Pre-generated RelaxNGs are included.

The MEI source is up-to-date with the 2013 release. N.B. *It has been altered to include internal prefixes to avoid conflicts with TEI elements with the same name*. 

For more information visit:

* The TEI Music SIG [webspace](http://www.tei-c.org/SIG/Music/)
* The TEI with Music Notation [Guidelines](http://www.tei-c.org/SIG/Music/twm/index.html)
* The TEI Music SIG [wiki](http://wiki.tei-c.org/index.php/SIG:Music)

# Generating Schemata

To generate a new schema, you will need to use the [TEI Stylesheets](github.com/TEIC/Stylesheets).

If you have a Unix machine, use the `teitorelaxng` script provided with the stylesheets:

`$ bin/teitorelaxng PATH_TO/tei-mei/tei_mei.xml PATH_TO/tei-mei/schemata/tei_mei.rng`

# Creating new ODDs

There are two things to keep in mind:

* To load MEI modules, use @source

`<moduleRef key="MEI" source="mei-source.xml"/>`

* the elementSpec for notatedMusic must be changed to include MEI at various levels. See any of the ODDs as an example.

If you create a new ODD, please consider forking this repo and sending a pull request!

## Updating MEI version

The process to update to another MEI version, elements and classes in the MEI ODD must be prefixed to avoid conflicts
with TEI elements and classes.

* Get the [MEI source](https://github.com/music-encoding/music-encoding/tree/develop/source/specs) from GitHub.
* Run utils/add_prefixes.xsl to generate a new mei-source.xml with prefixes.
