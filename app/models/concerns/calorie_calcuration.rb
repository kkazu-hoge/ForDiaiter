module CalorieCalcuration
  extend ActiveSupport::Concern

  #基礎代謝の計算
  def basal_metabolic_rate(obj)
    if obj[:sex] == "man"
      result = 13.397 * obj[:weight] + 4.799 * obj[:height] + 88.362 - 5.677 * obj[:age]
    elsif obj[:sex] == "women"
      result = 9.247 * obj[:weight] + 3.098 * obj[:height] + 447.593 - 4.33 * obj[:age]
    else
      result = "erorr"
    end
    return result
  end

  #日数計算
  def day_counts(start_day, finish_day)
    result = (finish_day - start_day).to_i
    return result
  end


  #日常生活でのカロリー差
  def diff_calorie_perday(intake_calorie_perday, naturally_burn_calorie_perday)
    result = (@intake_calorie_perday.to_i - @naturally_burn_calorie_perday.to_i)
    return result
  end

  # 目標総消費カロリーの計算
  def target_burn_kcal(pj_obj, sum_diff_calorie)
    result = 7200 * (pj_obj[:weight] - pj_obj[:target_weight]) + sum_diff_calorie
    return result
  end




end