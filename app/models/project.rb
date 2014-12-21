class Project < ActiveRecord::Base
	resourcify
	include PublicActivity::Model
	activist
	validates_presence_of :name, :start, :end
	has_many :sprints
	has_many :stories
	has_many :tasks
	has_many :users , through: :roles
	has_many :uploads

	def self.search(query)
		where("name like ?", "%#{query}%") 
	end

	def users
    User.all.select { |user| user.can? :read, self }
  end
  
	def backlog_stories
		self.stories.where(state: "Not Started")
	end

	def rest_stories
		self.stories.where.not(state: "Not Started")
	end

	def completed_stories
		self.stories.where(state: "Delivered")
	end
end
