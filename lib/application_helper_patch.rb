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

require_dependency 'application_helper'
module ApplicationHelperPatch
    def self.included(base)
        base.class_eval do

        	#Override application's method to display roles in select forms next to users names
            def principals_options_for_select_with_extended_roles(collection, selected=nil)
            	if @project != nil then
	              s = ''
	              if collection.include?(User.current)
	                s << content_tag('option', "<< #{l(:label_me)} >>", :value => User.current.id)
	              end
	              groups = ''


	              project_roles = ExtendedUserProject.all
	              if project_roles != nil then
	                project_roles = project_roles.select{|r| (r[:project_id] == @project[:id].to_i)}
	              end
	              collection.sort.each do |element|
	                if project_roles != nil then
	                  user_role = project_roles.select{|r| (r[:user_id] == element.id.to_i)}
	                  if user_role.size != 0 then
	                    user_role = " : " + Enumeration.find(user_role.first[:extended_project_role_id])[:name]
	                  else
	                    user_role = ""
	                  end
	                else
	                  user_role = ""
	                end

	                
	                selected_attribute = ' selected="selected"' if option_value_selected?(element, selected) || element.id.to_s == selected
	                (element.is_a?(Group) ? groups : s) << %(<option value="#{element.id}"#{selected_attribute}>#{h element.name + user_role}</option>)
	              end
	              unless groups.empty?
	                s << %(<optgroup label="#{h(l(:label_group_plural))}">#{groups}</optgroup>)
	              end
	              s.html_safe
	            else
	            	principals_options_for_select_without_extended_roles(collection, selected)
	            end
            end

            alias_method_chain :principals_options_for_select, :extended_roles
        end
    end
end