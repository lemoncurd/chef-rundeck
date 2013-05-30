# rundeck-server cookbook

Downloads and installs an instance of RunDeck(http://rundeck.org)

# Requirements

## Platforms

* Debian, Ubuntu

## Cookbooks

Requires Opscode's `apt` cookbook to ensure system packages lists are up to date.

# Attributes

* `rundeck[:version]` - The version number of Rundeck
* `rundeck[:download_url]` - The URL to use to download the Rundeck .deb

# Recipes

default
-------

Downloads the .deb from the Rundeck website, installs it and starts the service.

# Author

Author:: Ben Buckley (lemoncurd@codemonkey.co.uk)
