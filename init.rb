#Copyright (C) 2017  Alexandre BOUDINE
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'redmine'
require 'redmine_extended_project_role'
require_dependency 'extended_hook/hook'

Rails.configuration.to_prepare do
	require_dependency 'application_helper_patch' #Apply patch
	ApplicationHelper.send(:include, ApplicationHelperPatch)

	require_dependency 'projects_controller_patch' #Apply patch
	ProjectsController.send(:include, ProjectsControllerPatch)
end

Redmine::Plugin.register :redmine_extended_project_roles do
  name 'Extended Project Roles plugin'
  author 'Alexandre BOUDINE'
  description 'Add customs Roles inside projects for a better distinction between members'
  version '0.1.1'

  permission :manage_roles, {:extended_user_project => [:create,:destroy]}, :require => :member, :caption => :permission_manage_roles
end

RedmineExtendedProjectRole.require_dependencies

