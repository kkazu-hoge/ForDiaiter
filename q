
[1mFrom:[0m /home/ec2-user/environment/ForDiaiter/app/controllers/public/pj_template_events_controller.rb:34 Public::PjTemplateEventsController#pj_event_add_training:

    [1;34m16[0m: [32mdef[0m [1;34mpj_event_add_training[0m
    [1;34m17[0m: 
    [1;34m18[0m:   [1;34m#リクエストパラメータのトレーニングidからトレーニングデータを取得[0m
    [1;34m19[0m:   training_obj = [1;34;4mTraining[0m.find(params[[33m:training_id[0m])
    [1;34m20[0m:   minutes = [1;34m10[0m
    [1;34m21[0m:   calorie_per_ten_min = burn_calories_training(training_obj.mets_value, session[[33m:project[0m][[31m[1;31m"[0m[31mweight[1;31m"[0m[31m[0m], minutes).ceil
    [1;34m22[0m:   [1;34m#ハッシュで１トレーニングのデータを作成する[0m
    [1;34m23[0m:   hash_add_training = {[31m[1;31m"[0m[31mtraining_id[1;31m"[0m[31m[0m=>training_obj.id, [31m[1;31m"[0m[31mactivity_minutes[1;31m"[0m[31m[0m=>[1;34m0[0m, [31m[1;31m"[0m[31mtraining_name[1;31m"[0m[31m[0m=>training_obj.name, [31m[1;31m"[0m[31mcalorie_per_ten_min[1;31m"[0m[31m[0m=>calorie_per_ten_min }
    [1;34m24[0m:   [32mif[0m session[[33m:pj_event_details[0m].blank?
    [1;34m25[0m:     session[[33m:pj_event_details[0m] = {}
    [1;34m26[0m:   [32mend[0m
    [1;34m27[0m:   [1;34m#セッションに1トレーニング分のハッシュデータを追加する[0m
    [1;34m28[0m:   session[[33m:pj_event_details[0m][[31m[1;31m"[0m[31m#{training_obj.id}[0m[31m[1;31m"[0m[31m[0m] = hash_add_training
    [1;34m29[0m: 
    [1;34m30[0m:   [1;34m# @training_name = training_obj.name[0m
    [1;34m31[0m: 
    [1;34m32[0m:   @pj_event_details = session[[33m:pj_event_details[0m]
    [1;34m33[0m: 
 => [1;34m34[0m:   binding.pry
    [1;34m35[0m: 
    [1;34m36[0m:   respond_to [32mdo[0m |format|
    [1;34m37[0m:     [32mif[0m session[[33m:pj_event_details[0m][[31m[1;31m"[0m[31m#{training_obj.id}[0m[31m[1;31m"[0m[31m[0m].blank?
    [1;34m38[0m:       format.js { @status = [31m[1;31m"[0m[31mfail[1;31m"[0m[31m[0m }
    [1;34m39[0m:     [32melse[0m
    [1;34m40[0m:       format.js { @status = [31m[1;31m"[0m[31msuccess[1;31m"[0m[31m[0m }
    [1;34m41[0m:     [32mend[0m
    [1;34m42[0m:   [32mend[0m
    [1;34m43[0m:   [1;34m# binding.pry[0m
    [1;34m44[0m: [32mend[0m

