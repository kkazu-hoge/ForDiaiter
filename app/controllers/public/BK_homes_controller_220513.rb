class Public::HomesController < Public::ApplicationController

  include CalorieCalcuration

  def top
  end

  def home
    @projects = Project.get_projects_sort_desc_createday(current_customer)
    @projects.blank? ? @projects_array = [] : @projects_array = @projects.get_projects_pulldown_list
    @pj_pulldown_initial_set_value = @projects_array.first
    project = @projects.first

    unless @projects.blank?
      pj_scope_day_counts = day_counts(project.pj_start_day, project.pj_finish_day)

      ######## ダッシュボード表示用データ ########
      bmr = basal_metabolic_rate(project)
      @naturally_burn_calorie_perday = bmr * project.life_stress_factor.coefficient

      @intake_calorie_perday = project.intake_calorie_perday

      @diff_calorie_perday = diff_calorie_perday(@intake_calorie_perday, @naturally_burn_calorie_perday)

      #日常生活のカロリー差の総和をプロジェクト期間の日数で集計
      sum_diff_calorie = @diff_calorie_perday * pj_scope_day_counts
      @target_burn_kcal = target_burn_kcal(project, sum_diff_calorie)

      @plan_burn_kcal = plan_burn_kcal_calc(project, Date.current)

      @result_burn_kcal = result_burn_kcal_calc(project)

      #　※”進捗率”は画面側で処理
    end
  end

  def pj_alter
    @projects = Project.get_projects_sort_desc_createday(current_customer)
    @projects.blank? ? @projects_array = [] : @projects_array = @projects.get_projects_pulldown_list

    project = Project.find(params[:project_id])
    @pj_pulldown_initial_set_value = {}
    @pj_pulldown_initial_set_value[:name] = project.name
    @pj_pulldown_initial_set_value[:id] = project.id


    unless @projects.blank?
      disp_data = home_dashboard_date_get(project)
      @naturally_burn_calorie_perday =  disp_data[:naturally_burn_calorie_perday]
      @intake_calorie_perday =          disp_data[:intake_calorie_perday]
      @diff_calorie_perday =            disp_data[:diff_calorie_perday]
      @target_burn_kcal =               disp_data[:target_burn_kcal]
      @plan_burn_kcal =                 disp_data[:plan_burn_kcal]
      @result_burn_kcal =               disp_data[:result_burn_kcal]
    #　※”進捗率”は画面側で処理

      # pj_scope_day_counts = day_counts(project.pj_start_day, project.pj_finish_day)

      # ######## ダッシュボード表示用データ ########
      # bmr = basal_metabolic_rate(project)
      # @naturally_burn_calorie_perday = bmr * project.life_stress_factor.coefficient

      # @intake_calorie_perday = project.intake_calorie_perday

      # @diff_calorie_perday = diff_calorie_perday(@intake_calorie_perday, @naturally_burn_calorie_perday)

      # #日常生活のカロリー差の総和をプロジェクト期間の日数で集計
      # sum_diff_calorie = @diff_calorie_perday * pj_scope_day_counts
      # @target_burn_kcal = target_burn_kcal(project, sum_diff_calorie)

      # @plan_burn_kcal = plan_burn_kcal_calc(project, Date.current)

      # @result_burn_kcal = result_burn_kcal_calc(project)

      # @result_burn_kcal = 60

      #　※”進捗率”は画面側で処理
    end
    # binding.pry
  end

  private
  def home_dashboard_date_get(project)
    pj_scope_day_counts = day_counts(project.pj_start_day, project.pj_finish_day)
    dashboard_data_hash = {}
    ######## ダッシュボード表示用データ ########
    bmr = basal_metabolic_rate(project)
    @naturally_burn_calorie_perday = bmr * project.life_stress_factor.coefficient
    dashboard_data_hash[:naturally_burn_calorie_perday] = bmr * project.life_stress_factor.coefficient

    @intake_calorie_perday = project.intake_calorie_perday
     dashboard_data_hash[:intake_calorie_perday] = project.intake_calorie_perday

    @diff_calorie_perday = diff_calorie_perday(@intake_calorie_perday, @naturally_burn_calorie_perday)
     dashboard_data_hash[:diff_calorie_perday] = diff_calorie_perday(
                                                  dashboard_data_hash[:intake_calorie_perday],
                                                  dashboard_data_hash[:naturally_burn_calorie_perday]
                                                  )

    #日常生活のカロリー差の総和をプロジェクト期間の日数で集計
    sum_diff_calorie = @diff_calorie_perday * pj_scope_day_counts
    @target_burn_kcal = target_burn_kcal(project, sum_diff_calorie)
     dashboard_data_hash[:target_burn_kcal] = target_burn_kcal(project, sum_diff_calorie)

    @plan_burn_kcal = plan_burn_kcal_calc(project, Date.current)
     dashboard_data_hash[:plan_burn_kcal] = plan_burn_kcal_calc(project, Date.current)

    @result_burn_kcal = result_burn_kcal_calc(project)
     dashboard_data_hash[:result_burn_kcal] = result_burn_kcal_calc(project)


    return dashboard_data_hash
    # return @naturally_burn_calorie_perday, @intake_calorie_perday, @diff_calorie_perday, @target_burn_kcal, @plan_burn_kcal,@result_burn_kcal

  end

end
