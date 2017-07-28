# RedMine Extended Project Roles
## A RedMine plugin

This plugin aims to facilitate the assignment of an issue to the right member of a project.
To do so, it provide the possibility to attribute an role within the project to every member in every project,
and display it beside its name in the assignment field.


## Features :

This plugin provides the following features :
* Associate role within a project to members
* Display its role in the assignment field

Languages availables :
* EN
* FR

## Use :

To associate role to member :
	Projects -> MyProject -> Settings -> Members -> Role Within The Project

## Installation :

	$cd /path/to/redmine/directory/plugins
	$git clone https://github.com/BlueXML/redmine_extended_project_roles.git
	$bundle exec rake redmine:plugins:migrate RAILS_ENV=production

## Compatibility :
Tested for RedMine 3.3.* (Manually)

## License :
This plugin is licensed under the GNU/GPL license v3.




