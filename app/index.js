'use strict';
var util = require('util'),
    path = require('path'),
    yeoman = require('yeoman-generator'),
    _ = require('lodash'),
    _s = require('underscore.string'),
    pluralize = require('pluralize'),
    asciify = require('asciify');

var AngularMojoliciousGenerator = module.exports = function AngularMojoliciousGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
    this.spawnCommand('sh', ['install.sh']);
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(AngularMojoliciousGenerator, yeoman.generators.Base);

AngularMojoliciousGenerator.prototype.askFor = function askFor() {

  var cb = this.async();

  console.log('\n' +
    '+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+\n' +
    '|a|n|g|u|l|a|r| |m|o|j|o|l|i|c|i|o|u|s| |g|e|n|e|r|a|t|o|r|\n' +
    '+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+\n' +
    '\n');

  var prompts = [{
    type: 'input',
    name: 'baseName',
    message: 'What is the name of your application?',
    default: 'myapp'
  }];

  this.prompt(prompts, function (props) {
    this.baseName = props.baseName;

    cb();
  }.bind(this));
};

AngularMojoliciousGenerator.prototype.app = function app() {

  this.entities = [];
  this.resources = [];
  this.version = 1;
  this.generatorConfig = {
    "baseName": this.baseName,
    "version": this.version,
    "entities": this.entities,
    "resources": this.resources
  };
  this.generatorConfigStr = JSON.stringify(this.generatorConfig, null, '\t');

  this.template('_generator.json', 'generator.json');
  this.template('_package.json', 'package.json');
  this.template('_bower.json', 'bower.json');
  this.template('bowerrc', '.bowerrc');
  this.template('Gruntfile.js', 'Gruntfile.js');
  this.copy('gitignore', '.gitignore');

  var libDir = 'lib/';
  var appDir = libDir + _s.capitalize(this.baseName) + '/';
  var schemaDir = libDir + 'Schema/';
  var schemaResultDir = schemaDir + 'Result/';
  var schemaResultSetDir = schemaDir + 'ResultSet/';
  var publicDir = 'public/';
  var scriptDir = 'script/';
  var shareDir = 'share/';
  var tDir = 't/';
  this.mkdir(libDir);
  this.mkdir(appDir);
  this.mkdir(schemaDir);
  this.mkdir(publicDir);
  this.mkdir(scriptDir);
  this.mkdir(shareDir);
  this.mkdir(tDir);

  this.copy('Makefile.PL', 'Makefile.PL');
  this.copy('install.sh', 'install.sh');
  this.copy('upgrade.sh', 'upgrade.sh');
  this.template('lib/_App.pm', libDir + _s.capitalize(this.baseName) + '.pm');
  this.template('lib/_Schema.pm', libDir + 'Schema.pm');
  this.template('lib/_App/_Home.pm', appDir + 'Home.pm');
  this.template('script/_app', scriptDir + this.baseName);

  var publicCssDir = publicDir + 'css/';
  var publicJsDir = publicDir + 'js/';
  var publicViewDir = publicDir + 'views/';
  this.mkdir(publicCssDir);
  this.mkdir(publicJsDir);
  this.mkdir(publicViewDir);
  this.template('public/_index.html', publicDir + 'index.html');
  this.copy('public/css/app.css', publicCssDir + 'app.css');
  this.template('public/js/_app.js', publicJsDir + 'app.js');
  this.template('public/js/home/_home-controller.js', publicJsDir + 'home/home-controller.js');
  this.template('public/views/home/_home.html', publicViewDir + 'home/home.html');
};

AngularMojoliciousGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('editorconfig', '.editorconfig');
  this.copy('jshintrc', '.jshintrc');
};
