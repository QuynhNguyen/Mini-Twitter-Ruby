class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :name, :email, :age, :password_confirmation, :password

  email_regex = /[\w+\-.]+@[a-zA-Z\d.\-]+\.[a-zA-Z]+/i

  validates :name, :presence => true,
                   :length => {:maximum => 50}

  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitive => false}

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40 }

end



# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  age                :integer
#  encrypted_password :string(255)
#

