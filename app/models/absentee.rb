class Absentee < ActiveRecord::Base
  belongs_to :student
  belongs_to :attendance_registry
end
