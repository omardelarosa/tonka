#Tonka

**Tonka** builds, destroys and serves static HTML sites.

##Installation

To install **Tonka** use the following command:

```
$ gem install tonka
```

#Usage
###Build

To build a blank, basic static site use:

```
$ tonka build SITE_NAME
```

To include the a library, for example, Backbone.js add its name after the site name:

```
$ tonka build SITE_NAME -backbone
```

###Destroy
To destroy a static site, use:

```
$ tonka destroy SITE_NAME
```

###Serve
To serve the files locally using WEBrick, change into the newly created directory and type "tonka serve":

```
$ cd SITE_NAME
$ tonka serve
```

An optional port number can also be passed in:

```
$ tonka serve 3000
```

#Updates
**0.0.1**

- added colorized output
- added itemized file creation/destruction messaging
- added unit tests

**0.0.2**

- misc. code refactoring

**0.0.3**

- more code refactoring

**0.0.4**

- added Backbone and Underscore support

**0.0.5**

- added simple WEBrick server and 'serve' command

#Feature Wishlist

- importing JSON/YAML/XML to generate the site content and/or HTML layout.

- pretty-printing of files created

- way more input options