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
          if challenge.duration
            if challenge.duration.to_i > 18
              old_time = 100 - ((challenge.duration * 60 - 1080) / 10).to_i
              old_time = 0 if old_time < 0
            else
              old_time = 100
            end
          else
            old_time = 0
          end
          if challenge.push_ups.to_i >= 50
            old_push_ups = 100
          else
            old_push_ups = challenge.push_ups.to_i * 2 || 0
          end
          if challenge.pull_ups.to_i >= 20
            old_pull_ups = 100
          else
            old_pull_ups = challenge.pull_ups.to_i * 5 || 0
          end
          old_score = old_pull_ups + old_push_ups + old_time

          if f.duration
            if f.duration.to_i > 18
              new_time = 100 - ((f.duration * 60 - 1080) / 10).to_i
              new_time = 0 if new_time < 0
            else
              new_time = 100
            end
          else
            new_time = 0
          end
          if f.push_ups.to_i >= 50
            new_push_ups = 100
          else
            new_push_ups = f.push_ups.to_i * 2 || 0
          end
          if f.pull_ups.to_i >= 20
            new_pull_ups = 100
          else
            new_pull_ups = f.pull_ups.to_i * 5 || 0
          end
          new_score = new_pull_ups + new_push_ups + new_time
          string +="<li>Super Challenge Duration Compared to previous week: <ul><li>#{f.duration - challenge.duration} minutes</li><li>#{new_score - old_score} points</li></ul></li>"
        else
          string +="<li>Super Challenge Duration Compared to previous week: No Challenge completed in prior week</li>"
        end
      end
      string +="<li>Total Exercises Done: #{f.exercise_total}</li><li>Total Cardios Done: #{f.cardio_total}</li></ul></ul>"; string.html_safe}
  end

end
