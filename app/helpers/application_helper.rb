module ApplicationHelper
	def current_user_followers(user_id)
    count = 0
    User.all.each do |followers|
      if followers.following.include?(user_id)
        count += 1
      end
    end 

    return count
  end 


  

end
