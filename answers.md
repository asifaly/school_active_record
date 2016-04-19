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


(6) What is the rank of a given student in a section?
------------------------------------------------------
**Select Students and Exam**

`section_students  = Student.includes(:exam, :section).references(:exam, :section)`

**Compute totals and create a separate array of objects with totals, section and house ids**  
`totals = []`  
`section_students.each do |e|`  
`totals << {id: e.id, section: e.section_id, house: e.house_id, total_marks: e.exam.english + e.exam.hindi + e.exam.science + e.exam.social + e.exam.mathematics }`  
`end`  

**Sort the array by Totals per section id (1 is section_id)**

`section_total = totals.select { |e| e[:section] == 2 }.sort_by! { |x| x[:total_marks] }.reverse`

**Find Rank based on student_id (2 is student_id)**

`section_total.find_index {|x| x[:id] == 2}+1`

(7) If we rank sections based on the average total score, what is the rank of a given section among its sibling sections?
------------------------------------------------------------------

**Use totals array from previous answer and create a new hash grouped by section as below**

`total_by_section = totals.group_by { |k| k[:section] }`

{1=>[{:id=>1, :section=>1, :house=>1, :total_marks=>329}, {:id=>2, :section=>1, :house=>2, :total_marks=>359}, {:id=>3, :section=>1, :house=>2, :total_marks=>355}...], 2=>[{:id=>21, :section=>2, :house=>4, :total_marks=>270}, {:id=>22, :section=>2, :house=>4, :total_marks=>351}, {:id=>23, :section=>2, :house=>2, :total_marks=>239}...]...}

**Compute average score and rank based on has values**

`section_ranks = total_by_section.map { |k,v| {k => v.map { |s| s[:total_marks] }.sum / v.size} }.sort_by { |v| v.values }.reverse`

result appears as below with section_id and average score as key and value

[{23=>334}, {12=>333}, {15=>332}, {19=>324}, {13=>320}, {20=>319}, {9=>318}, {7=>316}, {17=>315}, {16=>314}, {6=>313}, {24=>312}, {1=>311}, {25=>310}, {14=>309}, {21=>308}, {5=>306}, {11=>306}, {10=>305}, {18=>305}, {2=>305}, {4=>302}, {3=>301}, {22=>300}, {8=>299}]

**Find Rank (x = section_id)**

`section_ranks.find_index { |e|  e[x] }+1`

(8) What is the ranking of houses, if we calculate the average total score of students belonging to each house?
------------------------------------------------------------------------

**Similar to answer 7**

`total_by_house = totals.group_by { |k| k[:house] }`

`house_ranks = total_by_house.map { |k,v| {k => v.map { |s| s[:total_marks] }.sum / v.size} }.sort_by { |v| v.values }.reverse`

`house_ranks.find_index { |e|  e[x] }+1`


