class Public::HomesController < Public::ApplicationController

  include CalorieCalcuration

  def top
  end

  def home
    @projects = Project.where(customer_id: current_customer.id).order("created_at": :desc)

    project = @projects.order("created_at": :desc).limit(1)

    # 目標総消費カロリー
    @target_burn_kcal = 7200 * (project.weight - project.target_weight)

    # 計画消費カロリー
    #現在の日付とプロジェクトの終了日どちらをカロリー計算に使用するか判定
    project.pj_finish_day <= Date.current ? calc_pj_finish_day = project.pj_finish_day : calc_pj_finish_day = Date.current
    #プロジェクト内の現時点でのイベント(運動)計画回数
    plan_activity_counts = (calc_pj_finish_day - project.pj_start_day).to_i / project.interval
    # １回あたりのイベントの総消費カロリー　イベントに紐づくトレーニング数分繰り返し処理
    
    # 計画イベント.計画イベント詳細.activity_minutes ×　計画イベント.計画イベント詳細.burn_calories　×　プロジェクト.weight ×1.05

    each_event_tarining_allkcal =

    @plan_burn_kcal =

    # 実績消費カロリー

    # 進捗率

    # 1日の自然総消費カロリー

    # 1日の想定摂取カロリー

    # 日常生活でのカロリー差


  end

  def pj_alter

  end
end
