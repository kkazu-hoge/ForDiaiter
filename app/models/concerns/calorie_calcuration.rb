module CalorieCalcuration
  extend ActiveSupport::Concern

  ###### 基礎代謝(bmr)の計算 ######
  def basal_metabolic_rate(obj)
    if obj["sex"] == "man"
      result = 13.397 * obj["weight"].to_i + 4.799 * obj["height"].to_i + 88.362 - 5.677 * obj["age"].to_i
    elsif obj["sex"] == "woman"
      result = 9.247 * obj["weight"].to_i + 3.098 * obj["height"].to_i + 447.593 - 4.33 * obj["age"].to_i
    else
      result = "erorr"
    end
    return result
  end

  ###### ボディマス指数(bmi)の計算 ######
  def body_mass_index(height, weight)
    result = weight.to_i / (height.to_f/100).to_f**2
    return result.round(1)
  end

  ###### 適正体重の計算 ######
  def normal_weight(height)
    result = (height.to_f/100).to_f**2 * 22
    return result.round(1)
  end

  ###### 日数計算 ######
  def day_counts(start_day, finish_day)
    result = (finish_day - start_day).to_i
    return result
  end

  ######  日常生活でのカロリー差 ######
  def diff_calorie_perday(intake_calorie_perday, naturally_burn_calorie_perday)
    result = (intake_calorie_perday.to_i - naturally_burn_calorie_perday.to_i)
    return result
  end

  ###### 目標総消費カロリーの計算 ######
  def target_burn_kcal(pj_obj, sum_diff_calorie)
    result = 7200 * (pj_obj["weight"].to_i - pj_obj["target_weight"].to_i) + sum_diff_calorie.to_i
    return result
  end

  ###### イベント回数の計算 ######
  def event_counts_calc(finish_day, start_day, interval)
    result = ((finish_day.to_date - start_day.to_date).to_i / interval.to_i) + 1
    return result
  end

  ###### 計画消費カロリーの計算 ######
  # プロジェクト開始日に到達していない場合は"0"、到達している場合は"計算値"をセットし、計算結果を返却する
  def plan_burn_kcal_calc(pj_obj, current_day)
    if pj_obj["pj_start_day"].to_date > current_day
      result = 0
    else
      #現在の日付がプロジェクトの終了日を経過していなければ消費カロリー計算に現在の日付を使用
      pj_obj["pj_finish_day"].to_date <= current_day ? calc_pj_finish_day = pj_obj["pj_finish_day"].to_date : calc_pj_finish_day = current_day

      plan_event_counts = event_counts_calc(calc_pj_finish_day, pj_obj["pj_start_day"].to_date, pj_obj["interval"])

      each_event_training_allkcal = 0
      plan_pj_event = Project.find(pj_obj["id"]).plan_pj_events.first
      plan_pj_event_details = plan_pj_event.plan_pj_event_details
      #計画イベントに紐づく詳細(トレーニング)の数だけ加算処理して１イベントの消費カロリーを計算
      plan_pj_event_details.each do |plan_ed|
        each_event_training_allkcal += plan_ed.burn_calories.to_i
      end

      result = each_event_training_allkcal * plan_event_counts
    end
    return result
  end

  ######## 実績消費カロリーの計算 ########
  def result_burn_kcal_calc(pj_obj)
    result = 0
    pj_evnets = Project.find(pj_obj["id"]).pj_events
    #イベント詳細(１トレーニング)の消費カロリー × イベント詳細数 × イベント数
    pj_evnets.each do |pj_ev|
      result += pj_ev.pj_event_details.sum("burn_calories")
    end
    return result
  end

  ######## トレーニングの消費カロリー計算 ########
  def burn_calories_training(mets_value, weight, minutes)
    result = mets_value.to_f*weight.to_i* minutes.to_i*1.05
    return result
  end

end