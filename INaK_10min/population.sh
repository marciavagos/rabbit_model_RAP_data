
array=( 171 268 452 518 759 946 959 1105 1172 1195 1391 1639 1650 1711 1822 2065 )
data_path=/Users/marciavagos/Documents/Single_Cell_Models/Model_Jordi/rabbit/source_v6/PoM_2Hz_3
params_ctl="$data_path"/params_CTL.txt
params_rap=/Users/marciavagos/repos/RAP_paper/data/params_RAP.txt
ramm_file=/Users/marciavagos/repos/Rabbit_model/source_v6/RAMM_v6.out

for model in "${array[@]}"
do
  cp /Users/marciavagos/repos/RAP_paper/data/Parameters_2.txt ./Parameters_"$model".txt
  cp "$data_path"/long_pacing/states_"$model".txt ./

  p=(`awk -v line="$model" 'NR==line' $params_ctl`)    
  p2=(`awk -v line="$model" 'NR==line' $params_rap`)

  RyRP_0=0.2
  RyRP_1=0.22
  RyRP_5=8E-5
  RyRP_11=0.007
  Ca_Buff=1.0
  vmax_serca=0.00531114
  num_RyR=198000


  sed -i '' 's/ICaL_junc_scl=ICaL_junc_scl/ICaL_junc_scl='"${p[0]}"'/' Parameters_$model.txt
  sed -i '' 's/ICaL_sl_scl=ICaL_sl_scl/ICaL_sl_scl='"${p[0]}"'/' Parameters_$model.txt
  sed -i '' 's/ICaT_junc_scl=ICaT_junc_scl/ICaT_junc_scl='"${p[1]}"'/' Parameters_$model.txt
  sed -i '' 's/ICaT_sl_scl=ICaT_sl_scl/ICaT_sl_scl='"${p[1]}"'/' Parameters_$model.txt
  sed -i '' 's/INaK_junc_scl=INaK_junc_scl/INaK_junc_scl='"${p2[2]}"'/' Parameters_$model.txt
  sed -i '' 's/INaK_sl_scl=INaK_sl_scl/INaK_sl_scl='"${p2[2]}"'/' Parameters_$model.txt
  sed -i '' 's/INaCa_junc_scl=INaCa_junc_scl/INaCa_junc_scl='"${p[3]}"'/' Parameters_$model.txt
  sed -i '' 's/INaCa_sl_scl=INaCa_sl_scl/INaCa_sl_scl='"${p[3]}"'/' Parameters_$model.txt
  sed -i '' 's/INa_junc_scl=INa_junc_scl/INa_junc_scl='"${p[4]}"'/' Parameters_$model.txt
  sed -i '' 's/INa_sl_scl=INa_sl_scl/INa_sl_scl='"${p[4]}"'/' Parameters_$model.txt
  sed -i '' 's/ITo_scl=ITo_scl/ITo_scl='"${p[5]}"'/' Parameters_$model.txt
  sed -i '' 's/IKr_scl=IKr_scl/IKr_scl='"${p[6]}"'/' Parameters_$model.txt
  sed -i '' 's/IKs_scl=IKs_scl/IKs_scl='"${p[7]}"'/' Parameters_$model.txt
  sed -i '' 's/IK1_scl=IK1_scl/IK1_scl='"${p[8]}"'/' Parameters_$model.txt
  sed -i '' 's/ICaP_junc_scl=ICaP_junc_scl/ICaP_junc_scl='"${p[9]}"'/' Parameters_$model.txt
  sed -i '' 's/ICaP_sl_scl=ICaP_sl_scl/ICaP_sl_scl='"${p[9]}"'/' Parameters_$model.txt
  sed -i '' 's/ICab_junc_scl=ICab_junc_scl/ICab_junc_scl='"${p[10]}"'/' Parameters_$model.txt
  sed -i '' 's/ICab_sl_scl=ICab_sl_scl/ICab_sl_scl='"${p[10]}"'/' Parameters_$model.txt
  sed -i '' 's/INab_junc_scl=INab_junc_scl/INab_junc_scl='"${p[11]}"'/' Parameters_$model.txt
  sed -i '' 's/INab_sl_scl=INab_sl_scl/INab_sl_scl='"${p[11]}"'/' Parameters_$model.txt
  sed -i '' 's/IClb_scl=IClb_scl/IClb_scl='"${p[12]}"'/' Parameters_$model.txt

  sed -i '' 's/X0_File=X0_File/X0_File=states_'"$model"'.txt/' Parameters_$model.txt
  sed -i '' 's/Vmax_SRCaP=Vmax_SRCaP/Vmax_SRCaP='"$vmax_serca"'/' Parameters_$model.txt
  sed -i '' 's/RyRParams_NP_0=RyRParams_NP_0/RyRParams_NP_0='"$RyRP_0"'/' Parameters_$model.txt
  sed -i '' 's/RyRParams_NP_1=RyRParams_NP_1/RyRParams_NP_1='"$RyRP_1"'/' Parameters_$model.txt
  sed -i '' 's/RyRParams_NP_5=RyRParams_NP_5/RyRParams_NP_5='"$RyRP_5"'/' Parameters_$model.txt
  sed -i '' 's/RyRParams_NP_11=RyRParams_NP_11/RyRParams_NP_11='"$RyRP_11"'/' Parameters_$model.txt
  sed -i '' 's/Ca_Buff_Factor=Ca_Buff_Factor/Ca_Buff_Factor='"$Ca_Buff"'/' Parameters_$model.txt
  sed -i '' 's/numRyRs=numRyRs/numRyRs='"$num_RyR"'/' Parameters_$model.txt

  $ramm_file Parameters_"$model".txt output_"$model" CELL

done

