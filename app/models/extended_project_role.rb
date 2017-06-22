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

class ExtendedProjectRole < Enumeration
  has_many :extended_user_projects, foreign_key: 'extended_project_role_id'

  #Required methods to belongs to enumerations

  OptionName = :enumeration_project_roles

  def option_name
    OptionName
  end

  def objects_count
    extended_user_projects.count
  end

  def transfer_relations(to)
    extended_user_projects.update_all(extended_project_role_id: to.id)
  end
end