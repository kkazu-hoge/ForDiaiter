class Public::HomesController < Public::ApplicationController

  include CalorieCalcuration

  def top
  end

  def home
    @projects = Project.get_projects_sort_desc_createday(current_customer)

    unless @projects.blank?
      project = @projects.first
      #プロジェクト期間の日数
      pj_duration_day_counts = day_counts(project.pj_start_day, project.pj_finish_day)

      ######## 1日の自然総消費カロリー ########
      bmr = basal_metabolic_rate(project)
      @naturally_burn_calorie_perday = bmr * project.life_stress_factor.coefficient

      ######## 1日の想定摂取カロリー ########
      @intake_calorie_perday = project.intake_calorie_perday

      ######## 日常生活でのカロリー差 ########
      @diff_calorie_perday = diff_calorie_perday(@intake_calorie_perday, @naturally_burn_calorie_perday)

      ######## 目標総消費カロリー ########
      #日常生活のカロリー差を期間日数で集計
      sum_diff_calorie = @diff_calorie_perday * pj_duration_day_counts
      @target_burn_kcal = target_burn_kcal(project, sum_diff_calorie)

      ######## 計画消費カロリー ########
      @plan_burn_kcal = plan_burn_kcal_calc(project, Date.current)

      ######## 実績消費カロリー ########
      @result_burn_kcal = result_burn_kcal_calc(project)

      ######## 進捗率 ########
      #画面側で処理
    end
  end

  def pj_alter

  end
end
