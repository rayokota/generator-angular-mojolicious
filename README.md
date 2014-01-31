# The Angular-Mojolicious generator 

A [Yeoman](http://yeoman.io) generator for [AngularJS](http://angularjs.org) and [Mojolicious](http://mojolicio.us/).

Mojolicious is a Perl-based micro-framework.  For AngularJS integration with other micro-frameworks, see https://github.com/rayokota/MicroFrameworkRosettaStone.

## Installation

Install [Git](http://git-scm.com), [node.js](http://nodejs.org), and [Perl 5.10.1](http://www.perl.org/).  The development mode also requires [SQLite](http://www.sqlite.org).  Required Perl modules can be installed as follows:

	curl -L cpanmin.us | perl - Mojolicious Modern::Perl DBIx::Class DBIx::Class::Migration \
		DateTime DateTime::Format::SQLite

Install Yeoman:

    npm install -g yo

Install the Angular-Mojolicious generator:

    npm install -g generator-angular-mojolicious

## Creating a Mojolicious service

In a new directory, generate the service:

    yo angular-mojolicious

Run the service:

    morbo script/[myapp]

Your service will run at [http://localhost:3000](http://localhost:3000).


## Creating a persistent entity

Generate the entity:

    yo angular-mojolicious:entity [myentity]

You will be asked to specify attributes for the entity, where each attribute has the following:

- a name
- a type (String, Integer, Float, Boolean, Date, Enum)
- for a String attribute, an optional minimum and maximum length
- for a numeric attribute, an optional minimum and maximum value
- for a Date attribute, an optional constraint to either past values or future values
- for an Enum attribute, a list of enumerated values
- whether the attribute is required

Files that are regenerated will appear as conflicts.  Allow the generator to overwrite these files as long as no custom changes have been made.

Run the service:

    morbo script/[myapp]
    
A client-side AngularJS application will now be available by running

	grunt server
	
The Grunt server will run at [http://localhost:9000](http://localhost:9000).  It will proxy REST requests to the Mojolicious service running at [http://localhost:3000](http://localhost:3000).

At this point you should be able to navigate to a page to manage your persistent entities.  

The Grunt server supports hot reloading of client-side HTML/CSS/Javascript file changes.

