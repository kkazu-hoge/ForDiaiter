class Public::HomesController < Public::ApplicationController

  include CalorieCalcuration

  def top
  end

  def home
    @projects = Project.get_projects_sort_desc_createday(current_customer)
    @projects.blank? ? @projects_array = [] : @projects_array = @projects.get_projects_pulldown_list

    unless @projects.blank?
      project = @projects.first
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
    binding.pry
  end
end
