class Task < ActiveRecord::Base
	#projects have tasks that are assigned to users
  belongs_to :project
  belongs_to :user
end
