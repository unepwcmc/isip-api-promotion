# isip-api-promotion

iPad Application to promote and fundraise for the Integrated Species Information Platform API.

## Development
The app is entirely clientside, written in coffeescript using BackboneDiorama (https://github.com/th3james/BackboneDiorama), which you can install with:

    sudo npm -g install backbone-diorama

### Generators and app structure
BackboneDiorama puts the coffeescript source code into the src/ directory, which is then compiled from the manifest in src/compile\_manifest.json into js/application.json. BackboneDiorama has generators for most of the Backbone objects (generateController, generateView etc..) which will use a standard app structure, and generate includes for the manifest:

    diorama generateView SpeciesIndexView

### Compiling the coffeescript
You can watch the coffeescript in src/compile\_manifest.json directory with:

    diorama compile watch

To get the best out of BackboneDiorama, check the readme at: https://github.com/th3james/BackboneDiorama

### Compiling the CSS

SASS[1] is used for CSS compilation, and so `css/application.scss` should
be modified, instead of `css/application.css`. You can use the SASS gem
to watch the `.scss` file for changes and auto-compile:

    gem install sass 
    sass --watch style.scss:style.css

[1]: http://sass-lang.com/
