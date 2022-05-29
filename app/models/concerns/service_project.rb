module ServiceProject
  extend ActiveSupport::Concern

  #プロジェクト新規作成時の基礎情報入力の表示内容に関する処理
  def basic_info_set(new_pj_obj, session_obj, customer)
    if session_obj.blank?
      new_pj_obj["sex"] =           customer["sex"]
      new_pj_obj["age"] =           Customer.birthday_transfer_age(customer["birthday"].to_date)
      new_pj_obj["height"] =        customer["height"]
      new_pj_obj["weight"] =        customer["weight"]
      new_pj_obj["target_weight"] = ""
    else
      new_pj_obj["sex"] =           session_obj["sex"]
      new_pj_obj["age"] =           session_obj["age"]
      new_pj_obj["height"] =        session_obj["height"]
      new_pj_obj["weight"] =        session_obj["weight"]
      new_pj_obj["target_weight"] = session_obj["target_weight"]
    end
    return new_pj_obj
  end


  #プロジェクト作成の基礎情報の入力内容チェック
  def basic_info_validation(pj_obj)
    # 0：success, 9: validation_error, 8: weight_error
    status = 9
    check_project = Project.new(
      sex:                    pj_obj["sex"],
      age:                    pj_obj["age"],
      height:                 pj_obj["height"],
      weight:                 pj_obj["weight"],
      target_weight:          pj_obj["target_weight"],
      customer_id:            current_customer.id,      #バリデーションチェックのため仮の値を設定
      life_stress_factor_id:  1,                        #バリデーションチェックのため仮の値を設定
      pj_start_day:           Date.current,             #バリデーションチェックのため仮の値を設定
      pj_finish_day:          Date.current+1,           #バリデーションチェックのため仮の値を設定
      interval:               -999,                     #バリデーションチェックのため仮の値を設定
      name:                   "チェック",               #バリデーションチェックのため仮の値を設定
      intake_calorie_perday:  -999                      #バリデーションチェックのため仮の値を設定
      )

    status = 0 if check_project.valid?
    status = 8 if pj_obj["target_weight"].to_i > pj_obj["weight"].to_i && pj_obj["target_weight"].blank? == false

    return status
  end



  #プロジェクト新規作成時のプロジェクト設定入力の表示内容に関する処理
  def project_info_set(new_pj_obj, session_obj)
    if session_obj["name"].blank?
      new_pj_obj["name"] =                  ""
      new_pj_obj["pj_start_day"] =          Date.current
      new_pj_obj["pj_finish_day"] =         Date.current+1
      new_pj_obj["life_stress_factor_id"] = 1
      new_pj_obj["intake_calorie_perday"] = ""
      new_pj_obj["interval"] =              ""
    else
      new_pj_obj["name"] =                  session_obj["name"]
      new_pj_obj["pj_start_day"] =          session_obj["pj_start_day"]
      new_pj_obj["pj_finish_day"] =         session_obj["pj_finish_day"]
      new_pj_obj["life_stress_factor_id"] = session_obj["life_stress_factor_id"]
      new_pj_obj["intake_calorie_perday"] = session_obj["intake_calorie_perday"]
      new_pj_obj["interval"] =              session_obj["interval"]
    end

    return new_pj_obj
  end



  #プロジェクト作成のプロジェクト設定の入力内容チェック
  def project_info_validation(pj_obj, session_obj)
    # 0：success, 9: validation_error, 8: pj_date_error, 7: intake_calorie_error
    status = 9
    check_project = Project.new(
      sex:                    session_obj["sex"],
      age:                    session_obj["age"],
      height:                 session_obj["height"],
      weight:                 session_obj["weight"],
      target_weight:          session_obj["target_weight"],
      customer_id:            current_customer.id,
      life_stress_factor_id:  pj_obj["life_stress_factor_id"],
      pj_start_day:           pj_obj["pj_start_day"],
      pj_finish_day:          pj_obj["pj_finish_day"],
      interval:               pj_obj["interval"],
      name:                   pj_obj["name"],
      intake_calorie_perday:  pj_obj["intake_calorie_perday"]
      )

    status = 0 if check_project.valid?
    # binding.pry
    if status == 0
      status = 8 if pj_obj["pj_finish_day"].to_date <= pj_obj["pj_start_day"].to_date || pj_obj["pj_start_day"].to_date < Date.current
      status = 7 if pj_obj["intake_calorie_perday"].to_s.length < 3 || pj_obj["intake_calorie_perday"].to_s.length > 4
    end
    return status
  end



  #プロジェクト新規作成時のトレーニング設定入力の表示内容に関する処理
  def training_info_set(session_obj)
    result = {}
    bmr =                                   basal_metabolic_rate(session_obj)
    naturally_burn_calorie_perday =         bmr.to_f * LifeStressFactor.find(session_obj["life_stress_factor_id"].to_i).coefficient
    intake_calorie_perday =                 session_obj["intake_calorie_perday"].to_f
    diff_calorie_perday =                   diff_calorie_perday(intake_calorie_perday,naturally_burn_calorie_perday)
    pj_scope_day_counts =                   day_counts(session_obj["pj_start_day"].to_date, session_obj["pj_finish_day"].to_date)
    sum_diff_calorie =                      diff_calorie_perday.to_i * pj_scope_day_counts.to_i
    result["target_burn_kcal"] =            target_burn_kcal(session_obj, sum_diff_calorie)
    result["event_counts"] =                event_counts_calc(session_obj["pj_finish_day"].to_date, session_obj["pj_start_day"].to_date, session_obj["interval"].to_i)
    result["target_burn_kcal_per_event"] =  (result["target_burn_kcal"].to_f/result["event_counts"]).ceil

    return result
  end

  #プロジェクト作成のトレーニング設定の入力内容チェック
  def training_info_validation(pj_event_detail_obj, params_hash)
    # 0：success, 9: validation_error, 8: training_blank_error, 7: input_type_error, 6: activity_minutes_blank_error
    status = 0
    status = 8 if pj_event_detail_obj.blank?
    unless status == 8
      pj_event_detail_obj.each do |pedo|
        activity_minutes =  params_hash[pedo[1]["training_id"].to_s]
        unless activity_minutes.to_i == 0 #文字をintにキャストすると0になることを利用
          status = 6 if activity_minutes.blank? || activity_minutes.to_i < 1 || activity_minutes.to_i > 999
        else
          status = 7
        end
      end
    end

    return status
  end


end