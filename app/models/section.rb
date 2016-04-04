class Section < ActiveRecord::Base
  belongs_to :klass
  has_many :students
  has_many :attendance_registries
end
