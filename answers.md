Active Record querying assignment
=================================

(1) What is the total number of students?
-----------------------------------------
`Student.count(:all)`
`Students.all.size`
`Student.count`

**=559**

(2) What is the average number of students per section?
-------------------------------------------------------
Students in each Section 
`Student.group(:section_id).count`

{1=>20, 2=>25, 3=>21, 4=>24, 5=>20, 6=>23, 7=>22, 8=>20, 9=>22, 10=>25, 11=>23, 12=>20, 13=>21, 14=>22, 15=>21, 16=>22, 17=>25, 18=>21, 19=>20, 20=>25, 21=>24, 22=>22, 23=>23, 24=>23, 25=>25}

Average per section `Student.count / Section.count`

**= 559/25 = 22**

(3) What is the average number of students per class?
-----------------------------------------------------
Students in each Klass `Student.joins(:section).group(:klass_id).count`
{1=>45, 2=>65, 3=>65, 4=>47, 5=>64, 6=>43, 7=>68, 8=>69, 9=>45, 10=>48}

Average per Klass `Student.count / Klass.count`

**=559/10 = 55**

(4) How many students of a given class belong to red house?
-----------------------------------------------------------
students belonging to a house `Student.includes(:house).where('houses.name = ?', 'Red').references(:house).count`

students belonging to a house of a particular class `Student.includes(:house, :section).where('houses.name = ? and klass_id = ?', 'Red', 1).references(:house, :section).count`

**=20**

(5) What is the average math score for students of a given section?
-------------------------------------------------------------------
`Exam.joins(:student).where('section_id = ?',2).average(:mathematics).to_f`

**=57.8**

