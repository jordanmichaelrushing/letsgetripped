class Day < ActiveRecord::Base

  has_many :exercises,       :dependent => :destroy
  has_one  :cardio,          :dependent => :destroy
  has_one  :super_challenge, :dependent => :destroy
  has_many :meals,           :dependent => :destroy
  has_many :calf_crunches,   :dependent => :destroy
  has_many :pushups,         :dependent => :destroy

  def self.get_weekly_stats(current_user)
    ctr = 0
    x = Day.select("DISTINCT(date) as date, COUNT(DISTINCT(exercises.id)) as exercise_total,COUNT(DISTINCT(cardios.id)) as cardio_total,
          COUNT(DISTINCT(meals.id)) as meal_total,SUM(meals.protein) as protein, SUM(meals.carbs) as carbs, SUM(meals.fats) as fats")
          .joins("LEFT JOIN exercises on exercises.day_id = days.id AND exercises.user_id = #{current_user.id}")
          .joins("LEFT JOIN cardios on cardios.day_id = days.id AND cardios.user_id = #{current_user.id}")
          .joins("LEFT JOIN meals on meals.day_id = days.id AND meals.user_id = #{current_user.id}")
          .group("week(date)")

    sums = current_user.days.select("DISTINCT(date),super_challenges.duration as duration,super_challenges.push_ups as push_ups, super_challenges.pull_ups as pull_ups").group("week(date)")
           .joins("LEFT JOIN super_challenges on super_challenges.day_id = days.id AND super_challenges.user_id = #{current_user.id}")
    y=x.map do |f|
      ctr += 1
      string = "<ul><strong>Week #{ctr}(#{f.date.beginning_of_week.strftime('%m/%d/%Y')}):</strong><ul>"
      challenged = sums.map{|i| i.date.beginning_of_week}.index(f.date.beginning_of_week)
      fats = f.fats || 0
      carbs = f.carbs || 0
      protein = f.protein || 0
      string += "<li>Total Calories: #{((fats * 9) + (carbs * 4) + (protein * 4)).round(2)}</li><li>Total Meals Eaten: #{f.meal_total}</li>"
      if (f.meal_total != 0)
        string +="<li>Average Calorie Per Meal: #{(((fats * 9) + (carbs * 4) + (protein * 4)) / f.meal_total).round(2)}</li>"
      end

      if challenged
        challenges = sums[challenged]
        challenge = SuperChallenge.select("duration,push_ups,pull_ups, WEEK(days.date) as days").joins("JOIN days on days.id = super_challenges.day_id")
                    .where("days.user_id = #{current_user.id} AND (WEEK(days.date) = #{(challenges.date - 1.week).strftime('%U')})").first
        if challenge
          string +="<li>Super Challenge Duration Compared to previous week: <ul><li>#{(challenges.duration - challenge.duration).round(2)} minutes</li><li>#{score(challenges) - score(challenge)} points</li></ul></li>"
        else
          string +="<li>Super Challenge Duration Compared to previous week: No Challenge completed in prior week</li>"
        end
      else
        string +="<li><i>Super Challenge Not Completed This Week</i></li>"
      end
      string +="<li>Total Exercises Done: #{f.exercise_total}</li><li>Total Cardios Done: #{f.cardio_total}</li></ul></ul>"
      string.html_safe
    end
    y
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
