# Sketchup Object Reader

A simple Sketchup plugin that saves information of Sketchup objects in JSON file.

## Installation

Copy the content of the `src` folder into the Plugins folder for Sketchup. On windows the folder is
`%AppData%\Sketchup\Sketchup 2023\Sketchup\Plugins`. 

You can find the location of the `Plugins` folder if you type
```ruby
Sketchup.find_support_file('Plugins')
```

into the Ruby console. To open the Ruby console select `Extensions` then `Developer` and `Ruby Console` in the 
Sketchup's menu. For more information see [how to add plugin to Sketchup](https://help.sketchup.com/en/extension-warehouse/adding-extensions-sketchup).

## Using the plugin

The plugin will save the information about currently selected objects into the JSON file whenever the user
selects `Save to JSON` from the `Extensions\ObjectReader` menu or clicks on the toolbar command. 
The JSON file will have the same name as the `.skp` file, but the extension will be `.json`. 

## Code organization

The entry points to the plugin code are the following
* `ObjectReader.initialize_plugin` this code is run on Sketchup startup or when the plugin is installed.
* `ObjectReader::ReadSelectedObjects.run` the code is run, whenever the user clicks the toolbar icon or selects the
`Save to JSON` from the `ObjectReader` menu.

The folder `test` contains the tests that can be installed as a separate plugin into Sketchup.
