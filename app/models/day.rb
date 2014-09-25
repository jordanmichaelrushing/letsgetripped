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

    sums = current_user.super_challenges.select("DISTINCT(super_challenges.date) AS date, previous_sc.date AS previous_sc_date,super_challenges.duration AS duration,
              super_challenges.push_ups AS push_ups, super_challenges.pull_ups AS pull_ups, previous_sc.duration AS previous_sc_duration, 
              previous_sc.push_ups AS previous_sc_push_ups,previous_sc.pull_ups AS previous_sc_pull_ups")
              .joins("LEFT OUTER JOIN super_challenges AS previous_sc ON previous_sc.user_id = #{current_user.id} AND WEEK(previous_sc.date) = (WEEK(super_challenges.date) - 1)")
              .where("super_challenges.user_id = 1 AND super_challenges.duration IS NOT NULL")
              .group("WEEK(super_challenges.date)")
              .order("WEEK(super_challenges.date)")
    this_challenge_array = sums.pluck(:date).map{|f| f.beginning_of_week if f}
    prev_challenge_array = sums.pluck("previous_sc.date").map{|f| f.beginning_of_week if f}
    x.map do |f|
      ctr += 1
      string = "<ul><strong>Week #{ctr}(#{f.date.beginning_of_week.strftime('%m/%d/%Y')}):</strong><ul>"
      this_challenge = this_challenge_array.index(f.date.beginning_of_week)
      prev_challenge = prev_challenge_array.index(f.date.beginning_of_week - 1.week)
      fats = f.fats || 0
      carbs = f.carbs || 0
      protein = f.protein || 0
      string += "<li>Total Calories: #{((fats * 9) + (carbs * 4) + (protein * 4)).round(2)}</li><li>Total Meals Eaten: #{f.meal_total}</li>"
      if (f.meal_total != 0)
        string +="<li>Average Calorie Per Meal: #{(((fats * 9) + (carbs * 4) + (protein * 4)) / f.meal_total).round(2)}</li>"
      end

      if this_challenge # if there was a SC this week
        this_challenges = sums[this_challenge]
        if prev_challenge # If there was a SC this week and last week
          prev_challenges = sums[prev_challenge]
          string += "<li>Super Challenge Comparison to previous week: <ul><li>#{(this_challenges.duration - prev_challenges.previous_sc_duration).round(2)} minutes</li><li>#{score(this_challenges) - old_score(prev_challenges)} points</li></ul></li>"
        else # If there was a SC this week but not last week
          string += "<li><i>No Challenge completed in prior week</i></li>"
        end
      elsif prev_challenge # This week no SC but last week there was
        challenges = sums[prev_challenge]
        string +="<li><i>Super Challenge Not Completed This Week but there was one last week</i></li>"
      else
        string +="<li><i>Super Challenge Not Completed This Week</i></li>"
      end
      string +="<li>Total Exercises Done: #{f.exercise_total}</li><li>Total Cardios Done: #{f.cardio_total}</li></ul></ul>"
      string.html_safe
    end
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

  def self.old_score(type)
    if type.duration
      if type.previous_sc_duration.to_i > 18
        new_time = 100 - ((type.previous_sc_duration * 60 - 1080) / 10).to_i
        new_time = 0 if new_time < 0
      else
        new_time = 100
      end
    else
      new_time = 0
    end
    if type.previous_sc_push_ups.to_i >= 50
      new_push_ups = 100
    else
      new_push_ups = type.previous_sc_push_ups.to_i * 2 || 0
    end
    if type.previous_sc_pull_ups.to_i >= 20
      new_pull_ups = 100
    else
      new_pull_ups = type.previous_sc_pull_ups.to_i * 5 || 0
    end
    return (new_pull_ups + new_push_ups + new_time)
  end
end
