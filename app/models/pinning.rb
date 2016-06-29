class Pinning < ActiveRecord::Base
	belongs_to :user, :pin, :board
end
