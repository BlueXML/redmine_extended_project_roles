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

module ExtendedHook
	class Hook < Redmine::Hook::ViewListener
		#Display select list association in project settings (title and form)
		render_on :view_projects_settings_members_table_header, :partial => 'projects/settings/role_member_header'
		render_on :view_projects_settings_members_table_row, :partial => 'projects/settings/role_member_row'
	end
end
