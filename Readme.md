Tonka
=====

**Tonka** builds and destroys static HTML sites.

Installation
--------

To install **Tonka** use the following command:

```
$ gem install tonka
```


Getting Started
------

To build a blank, basic static site use:

```
$ tonka build SITE_NAME
```

To include the jQuery library, use:

```
$ tonka build SITE_NAME -jquery
```

To add some text to the body element of the index.html file, use:

```
$ tonka build SITE_NAME -jquery BODY_TEXT
```

To destroy a static site, use:

```
$ tonka destroy SITE_NAME
```


Updates
========
Changes
---------
###0.0.1

-added colorized output

-added itemized file creation/destruction messaging

-added unit tests


Coming Soon
-----------

A few features are on the horizon, most notably:

-import JSON/YAML/XML to generate the site content

-pretty-printing of files created

-sinatra/rails generators

-sinatra/rails public folder contents destroyer

-way more input options