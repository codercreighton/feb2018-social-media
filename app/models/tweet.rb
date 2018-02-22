class Tweet < ApplicationRecord

	belongs_to :user

	has_many :tweet_tags
	has_many :tweets, through: :tweet_tags


	before_validation :link_check, on: :create
	validates :message, presence: true, length: {maximum: 140, too_long: "A tweet is only 140 characters! Maybe you should try Facebook!"}, on: :create
	after_validation :apply_link, on: :create



	private
		def link_check
			check = false
			if self.message.include?("http://") || self.message.include?("https://") || self.message.include?("www.")
				check = true
			end	

			if check == true
				arr = self.message.split
				index = arr.map { |x| x.include?("http://") || x.include?("https://") || x.include?("www") }.index(true)

				if arr[index].include? "http"
					self.link = arr[index]
				else	
					self.link = "http://#{arr[index]}"
				end	

				if self.link.length > 23
					arr[index] = "#{arr[index][0..20]}..."
				end

			self.message = arr.join(" ")		
			end
		end	



		

		def apply_link

			arr = self.message.split
			index = arr.map { |x| x.include?("http://") || x.include?("https://") || x.include?("www.") }.index(true)

			if index
				url = arr[index]
				arr[index] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
			end	

			self.message = arr.join(" ")
		end	


end
