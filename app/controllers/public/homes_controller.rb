class Public::HomesController < Public::ApplicationController

  include CalorieCalcuration

  # ※１：自然総消費カロリー/日
  # ※２：想定摂取カロリー/日
  # ※３：日常生活でのカロリー差
  # ※４：目標総消費カロリー
  # ※５：計画消費カロリー
  # ※６：実績消費カロリー

  def top
  end

  def home
    @projects = Project.get_projects_sort_desc_createday(current_customer)
    @projects.blank? ? @projects_array = [] : @projects_array = @projects.get_projects_pulldown_list
    #セッションに選択中のプロジェクトがあればそちらを使用する
    if session[:selected_project].blank?
      @pj_pulldown_initial_set_value = @projects_array.first
      project = @projects.first
    else
      # binding.pry
      project_id = 1
      @pj_pulldown_initial_set_value = @projects_array.find{|val| val[project_id] == session[:selected_project]["id"]}
      project = session[:selected_project]
    end

    unless @projects.blank?
      disp_data = home_dashboard_data_get(project)
      @naturally_burn_calorie_perday =  disp_data[:naturally_burn_calorie_perday] # ※１
      @intake_calorie_perday =          disp_data[:intake_calorie_perday]         # ※２
      @diff_calorie_perday =            disp_data[:diff_calorie_perday]           # ※３
      @target_burn_kcal =               disp_data[:target_burn_kcal]              # ※４
      @plan_burn_kcal =                 disp_data[:plan_burn_kcal]                # ※５
      @result_burn_kcal =               disp_data[:result_burn_kcal]              # ※６
    #　※”進捗率”は画面側で処理
    end
  end

  def pj_alter
    @projects = Project.get_projects_sort_desc_createday(current_customer)
    @projects.blank? ? @projects_array = [] : @projects_array = @projects.get_projects_pulldown_list

    # project = Project.find(params[:project_id])
    session[:selected_project] = Project.find(params[:project_id])
    project = session[:selected_project]

    #非同期処理のためプルダウンの初期値は取得する必要なし

    unless @projects.blank?
      disp_data = home_dashboard_data_get(project)
      @naturally_burn_calorie_perday =  disp_data[:naturally_burn_calorie_perday] # ※１
      @intake_calorie_perday =          disp_data[:intake_calorie_perday]         # ※２
      @diff_calorie_perday =            disp_data[:diff_calorie_perday]           # ※３
      @target_burn_kcal =               disp_data[:target_burn_kcal]              # ※４
      @plan_burn_kcal =                 disp_data[:plan_burn_kcal]                # ※５
      @result_burn_kcal =               disp_data[:result_burn_kcal]              # ※６
    #　※”進捗率”は画面側で処理
    end
  end



  private
  def home_dashboard_data_get(project)
    pj_scope_day_counts = day_counts(project["pj_start_day"].to_date, project["pj_finish_day"].to_date)
    dashboard_data_hash = {}
    ######## ダッシュボード表示用データ取得 ########
    bmr = basal_metabolic_rate(project)
    dashboard_data_hash[:naturally_burn_calorie_perday] = bmr.to_f * LifeStressFactor.find(project["life_stress_factor_id"]).coefficient.to_f
    dashboard_data_hash[:intake_calorie_perday] = project["intake_calorie_perday"]
    dashboard_data_hash[:diff_calorie_perday] = diff_calorie_perday(
                                                dashboard_data_hash[:intake_calorie_perday],
                                                dashboard_data_hash[:naturally_burn_calorie_perday]
                                                )
    #日常生活のカロリー差の総和をプロジェクト期間の日数で集計
    sum_diff_calorie = dashboard_data_hash[:diff_calorie_perday].to_i * pj_scope_day_counts.to_i
    dashboard_data_hash[:target_burn_kcal] = target_burn_kcal(project, sum_diff_calorie)
    dashboard_data_hash[:plan_burn_kcal] = plan_burn_kcal_calc(project, Date.current)
    dashboard_data_hash[:result_burn_kcal] = result_burn_kcal_calc(project)

    return dashboard_data_hash
  end

end
