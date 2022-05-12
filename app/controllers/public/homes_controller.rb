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
      #日常生活のカロリー差を期間分で総計
      sum_diff_calorie = @diff_calorie_perday * pj_duration_day_counts
      @target_burn_kcal = target_burn_kcal(project, sum_diff_calorie)

      ######## 計画消費カロリー ########
      #そもそもpj_start_dayがまだ始まっていなければ計画消費カロリーの値は0kcal
      if project.pj_start_day < Date.current
        # 計画消費カロリーの値は0kcalでセット
      else
        # 計算処理を実行

        #現在の日付とプロジェクトの終了日どちらを計画消費カロリー計算に使用するか判定
        project.pj_finish_day <= Date.current ? calc_pj_finish_day = project.pj_finish_day : calc_pj_finish_day = Date.current
        #プロジェクトの現時点での計画イベント(運動)回数(開始日を含めるため＋１する)
        plan_event_counts = ((calc_pj_finish_day - project.pj_start_day).to_i / project.interval) + 1
        # binding.pry
        # １回あたりのイベントの総消費カロリー　イベントに紐づくトレーニング数分繰り返し処理
        each_event_tarining_allkcal = 0
        plan_pj_event = project.plan_pj_events.first
        plan_pj_event_details = plan_pj_event.plan_pj_event_details
        plan_pj_event_details.each do |plan_ed|
          each_event_tarining_allkcal += plan_ed.burn_calories.to_i
        end

        # 計画イベントの総消費カロリー/１回　×　現時点のイベント回数　で計画進捗の消費カロリーを算出する
        @plan_burn_kcal = each_event_tarining_allkcal * plan_event_counts

      end

      ######## 実績消費カロリー ########
      @result_burn_kcal = 0
      pj_evnets = project.pj_events

      pj_evnets.each do |pj_ev|
        @result_burn_kcal += pj_ev.pj_event_details.sum(:burn_calories)
      end

      ######## 進捗率 ########
      #画面側で処理


    end
  end

  def pj_alter

  end
end
