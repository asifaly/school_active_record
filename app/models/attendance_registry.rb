class AttendanceRegistry < ActiveRecord::Base
  belongs_to :section
  has_many :absentees

  attr_accessor :absent_student_ids
end
