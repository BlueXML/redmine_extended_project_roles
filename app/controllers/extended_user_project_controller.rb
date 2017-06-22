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

class ExtendedUserProjectController < ApplicationController
	before_filter :check_permissions, :only => [:create, :destroy]
	before_filter :check_if_role_exists, :only => [:create]
	before_filter :check_if_member, :only => [:create]

	#Create a user-role association
	#if an association already exists, modify it, unless role selected is -1, then destroy it
	#else create an association
	def create
		@user_project_role = ExtendedUserProject.all
		if @user_project_role != nil then
			@user_project_role = @user_project_role.select{|r| (r[:user_id] == params[:user_id].to_i)}
			@user_project_role = @user_project_role.select{|r| (r[:project_id] == params[:project_id].to_i)}
			@user_project_role = @user_project_role.first
		end
		if @user_project_role == nil && params[:role_id] != "-1" then
			@user_project_role = ExtendedUserProject.new
			@user_project_role[:user_id] = params[:user_id]
			@user_project_role[:project_id] = params[:project_id]
			@user_project_role[:extended_project_role_id] = params[:role_id]
			@user_project_role.save
		else
			if params[:role_id] != '-1' then
				@user_project_role[:extended_project_role_id] = params[:role_id]
				@user_project_role.save
			else
				@user_project_role.destroy
			end
		end
	    render :nothing => true
	end

	#Not used, might be removed
	def destroy
		@user_project_role = ExtendedUserProject.all
		if @user_project_role != nil then
			@user_project_role = @user_project_role.select{|r| (r[:user_id] == params[:user_id].to_i)}
			@user_project_role = @user_project_role.select{|r| (r[:project_id] == params[:project_id].to_i)}
			@user_project_role = @user_project_role.first
		end
		if @user_project_role != nil then
			@user_project_role.destroy
		end
	    render :nothing => true
	end


	private

	def check_permissions
		render_403 unless User.current.allowed_to?(:manage_roles, Project.find(params[:project_id]))
	end

	def check_if_role_exists
		if params[:role_id] != "-1" then
			@available_roles = Enumeration.find(params[:role_id])
		    render_403 unless @available_roles[:type] == "ExtendedProjectRole"
		end
	end

	#Check if user is member of current project
	def check_if_member
		@member = Member.all
		if @member != nil then
			@member = @member.select{|m| (m[:user_id] == params[:user_id].to_i)}
			@member = @member.select{|m| (m[:project_id] == params[:project_id].to_i)}
			@member = @member.first
		end
	    render_403 unless @member != nil
	end
end