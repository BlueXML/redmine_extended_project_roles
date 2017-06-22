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

require_dependency 'projects_controller'
module ProjectsControllerPatch
    def self.included(base)
        base.class_eval do

            #Override project's destroy method to also destroy associations
        	def destroy_with_plugin
                @project_to_destroy = @project
    			if api_request? || params[:confirm]
    				project_roles = ExtendedUserProject.all
	                if project_roles != nil then
	                  project_roles = project_roles.select{|r| (r[:project_id] == @project_to_destroy[:id].to_i)}
	                end
	                project_roles.each do |r| 
	                	r.destroy
	                end
    			end
    			destroy_without_plugin
            end

            alias_method_chain :destroy, :plugin

        end
    end
end
