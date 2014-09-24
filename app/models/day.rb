class Day < ActiveRecord::Base

  has_many :exercises,       :dependent => :destroy
  has_one  :cardio,          :dependent => :destroy
  has_one  :super_challenge, :dependent => :destroy
  has_many :meals,           :dependent => :destroy
  has_many :calf_crunches,   :dependent => :destroy
  has_many :pushups,         :dependent => :destroy

  def self.get_weekly_stats(current_user)
    ctr = 0
    x = current_user.days.select("date, SUM(meals.protein) as prot, SUM(meals.carbs) as cars, SUM(meals.fats) as fas, COUNT(DISTINCT(exercises.id)) as exercise_total,
          COUNT(DISTINCT(cardios.id)) as cardio_total, COUNT(DISTINCT(meals.id)) as meal_total")
          .joins("LEFT OUTER JOIN meals on meals.day_id = days.id").joins("LEFT OUTER JOIN exercises on exercises.day_id = days.id").joins("LEFT OUTER JOIN cardios on cardios.day_id = days.id").group("week(date)")
    return x.map{|f| ctr += 1; fas = f.fas || 0; cars = f.cars || 0; prot = f.prot || 0; "<ul><strong>Week #{ctr}(#{f.date.beginning_of_week.strftime('%m/%d/%Y')}):</strong><ul>
      <li>Total Calories: #{((f.fas * 9) + (f.cars * 4) + (f.prot * 4))}</li>
      <li>Total Meals Eaten: #{f.meal_total}</li><li>Average Calorie Per Meal: #{((f.fas * 9) + (f.cars * 4) + (f.prot * 4)) / f.meal_total}</li>
      <li>Total Exercises Done: #{f.exercise_total}</li><li>Total Cardios Done: #{f.cardio_total}</li></ul></ul>".html_safe}
  end

end
