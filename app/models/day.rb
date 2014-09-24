class Day < ActiveRecord::Base

  has_many :exercises,       :dependent => :destroy
  has_one  :cardio,          :dependent => :destroy
  has_one  :super_challenge, :dependent => :destroy
  has_many :meals,           :dependent => :destroy
  has_many :calf_crunches,   :dependent => :destroy
  has_many :pushups,         :dependent => :destroy

  def self.get_weekly_stats(current_user)
    ctr = 0
    x = current_user.days.select("DISTINCT(date) as date, SUM(meals.protein) as prot, SUM(meals.carbs) as cars, SUM(meals.fats) as fas, COUNT(DISTINCT(exercises.id)) as exercise_total,
          COUNT(DISTINCT(cardios.id)) as cardio_total, COUNT(DISTINCT(meals.id)) as meal_total, super_challenges.duration as duration,super_challenges.push_ups as push_ups,super_challenges.pull_ups as pull_ups")
          .joins("LEFT OUTER JOIN meals on meals.day_id = days.id").joins("LEFT OUTER JOIN exercises on exercises.day_id = days.id").joins("LEFT OUTER JOIN cardios on cardios.day_id = days.id")
          .joins("LEFT OUTER JOIN super_challenges on super_challenges.day_id = days.id").group("week(date)")
    return x.map{|f| ctr += 1; fas = f.fas || 0; cars = f.cars || 0; prot = f.prot || 0; string = "<ul><strong>Week #{ctr}(#{f.date.beginning_of_week.strftime('%m/%d/%Y')}):</strong><ul>"+
      "<li>Total Calories: #{((fas * 9) + (cars * 4) + (prot * 4))}</li>"+
      "<li>Total Meals Eaten: #{f.meal_total}</li>"
      if (f.meal_total != 0)
        string +="<li>Average Calorie Per Meal: #{((fas * 9) + (cars * 4) + (prot * 4)) / f.meal_total}</li>"
      end
      if (f.duration)
        challenge = SuperChallenge.select("duration,push_ups,pull_ups, WEEK(days.date) as days").joins("JOIN days on days.id = super_challenges.day_id")
                    .where("days.user_id = #{current_user.id} AND (WEEK(days.date) = #{(f.date - 1.week).strftime('%U')})").first
        if challenge
          string +="<li>Super Challenge Duration Compared to previous week: <ul><li>#{f.duration - challenge.duration} minutes</li><li>#{score(f) - score(challenge)} points</li></ul></li>"
        else
          string +="<li>Super Challenge Duration Compared to previous week: No Challenge completed in prior week</li>"
        end
      else
        string +="<li><i>Super Challenge Not Completed This Week</i></li>"
      end
      string +="<li>Total Exercises Done: #{f.exercise_total}</li><li>Total Cardios Done: #{f.cardio_total}</li></ul></ul>"; string.html_safe}
  end

  def self.score(type)
    if type.duration
      if type.duration.to_i > 18
        new_time = 100 - ((type.duration * 60 - 1080) / 10).to_i
        new_time = 0 if new_time < 0
      else
        new_time = 100
      end
    else
      new_time = 0
    end
    if type.push_ups.to_i >= 50
      new_push_ups = 100
    else
      new_push_ups = type.push_ups.to_i * 2 || 0
    end
    if type.pull_ups.to_i >= 20
      new_pull_ups = 100
    else
      new_pull_ups = type.pull_ups.to_i * 5 || 0
    end
    return (new_pull_ups + new_push_ups + new_time)
  end
end
