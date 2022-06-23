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
    # 処理ステータスの
    success                       = 0
    training_blank_error          = 8
    input_type_error              = 7
    activity_minutes_blank_error  = 6

    status = success
    status = training_blank_error if pj_event_detail_obj.blank?
    if status == success
      pj_event_detail_obj.each do |pedo|
        activity_minutes =  params_hash[pedo[1]["training_id"].to_s]
        unless activity_minutes.to_i == 0 #文字をintにキャストすると0になることを利用
          status = activity_minutes_blank_error if activity_minutes.blank? || activity_minutes.to_i < 1 || activity_minutes.to_i > 999
        else
          status = input_type_error
        end
      end
    end

    return status
  end


  def project_save_transaction(session_project, session_pj_event_details)
    ActiveRecord::Base.transaction do
      #１ projectを保存する
      project = Project.new
      project[:customer_id] =           current_customer.id
      project[:sex] =                   session_project["sex"]
      project[:age]	=		                session_project["age"].to_i
      project[:height] =	              session_project["height"].to_i
      project[:weight] =                session_project["weight"].to_i
      project[:target_weight] =         session_project["target_weight"].to_i
      project[:pj_start_day] =          session_project["pj_start_day"].to_date
      project[:name] =                  session_project["name"]
      project[:pj_finish_day] =         session_project["pj_finish_day"].to_date
      project[:life_stress_factor_id] = session_project["life_stress_factor_id"].to_i
      project[:intake_calorie_perday] = session_project["intake_calorie_perday"].to_i
      project[:interval] =              session_project["interval"].to_i
      project.save!

      #２ plan_pj_eventsを保存する
      plan_pj_event = PlanPjEvent.new(project_id: project.id)
      plan_pj_event.save!

      #３ plan_pj_event_detailsを保存する
      session_pj_event_details.each do |ped|
        plan_pj_event_details =                     PlanPjEventDetail.new
        plan_pj_event_details[:plan_pj_event_id] =  plan_pj_event.id
        plan_pj_event_details[:training_id] =       ped[1]["training_id"]
        plan_pj_event_details[:activity_minutes] =  params[ped[1]["training_id"].to_s]
        training =                                  Training.find(plan_pj_event_details[:training_id].to_i)
        plan_pj_event_details[:burn_calories] =     burn_calories_training(training.mets_value, project[:weight], plan_pj_event_details[:activity_minutes] )

        plan_pj_event_details.save!
      end

      #４ pj_events、pj_event_detailsを保存する
      event_counts = event_counts_calc(project[:pj_finish_day], project[:pj_start_day], project[:interval])
      num = 1
      action_day = project[:pj_start_day]
      while num <= event_counts do
      	pj_event =              PjEvent.new(project_id: project.id)
      	pj_event[:action_day] = action_day
      	pj_event[:start_time] = pj_event[:action_day].to_time.to_datetime
      	pj_event.save!

      	session_pj_event_details.each do |ped|
      	  pj_event_details =               PjEventDetail.new
          pj_event_details[:pj_event_id] = pj_event.id
        	pj_event_details[:training_id] = ped[1]["training_id"]
      	  pj_event_details.save!
        end

        action_day = action_day.days_since(project[:interval])
      	num +=1
      end
    end
  end


end