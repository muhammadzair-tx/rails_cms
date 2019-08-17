class Page < ApplicationRecord
    
    acts_as_list :scope => :subject  # gem means there if we set there are 3 subject 1 a 2 c 3 b if i change the c 3  it will automatically change the b 2 and it becomes 1 a 2 b 3 c

    # subject father 
    #belongs_to :subject , { :foregin_key  => 'sub_id' }
    belongs_to :subject , { :optional => false } # make it true if you want to add page without a parent object subject 
    #make it false it prevent to add orphan recored in your database that not belongs to any object
    has_many :sections
    has_and_belongs_to_many :admin_users, :join_table => 'admin_users_pages'
    #we can specify the join table if we do not follow rails convention

    scope :visible , lambda {where(:visible => true) }
    scope :invisible , lambda { where(:visible => false) }
    scope :sorted , lambda { order("position ASC") }
    scope :newest_first , lambda { order(:created_at => :desc ) }
    scope :search , lambda { |query| where(["name LIKE ?", "%#{query}%"] ) }


    validates_presence_of :name
    validates_length_of :name, :maximum => 255
    validates_presence_of :permalink, :within => 3..255
    # use presense_of with lenght_of to disallow spaces
    validates_uniqueness_of :permalink
    #for unique values by subject use ":scope => :subject_id"

end
