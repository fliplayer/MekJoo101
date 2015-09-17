class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy

	attr_accessor :skip_validation

	validates :title, presence: true, length: {minimum: 5}
	validates :subtitle,  presence: true, unless: :skip_validation
	validates :body,  presence: true

	searchkick
end
