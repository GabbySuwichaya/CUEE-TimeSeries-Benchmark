if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi


if [ ! -d "./logs/LongForecasting/univariate" ]; then
    mkdir ./logs/LongForecasting/univariate
fi

pred_len=4 
label_len=0
moving_avg=37 
batch_size=128
model_name=PatchTST

 
for seq_len in 18 36 54 72 90 108
do
    python -u run_longExp.py \
    --is_training 1 \
    --root_path ./dataset/CUEE/ \
    --data_path updated_measurement_Iclr_new.csv \
    --model_id CUEEData_$seq_len'_'$pred_len \
    --model $model_name \
    --moving_avg $moving_avg \
    --data CUEE \
    --features S \
    --target I \
    --seq_len $seq_len \
    --label_len $label_len\
    --pred_len $pred_len \
    --enc_in 1 \
    --e_layers 3 \
    --n_heads 16 \
    --d_model 128 \
    --d_ff 256 \
    --dropout 0.2\
    --fc_dropout 0.2\
    --head_dropout 0\
    --patch_len 16\
    --stride 8\
    --des 'Exp' \
    --train_epochs 100\
    --patience 20\
    --lradj 'TST'\
    --pct_start 0.4\
    --itr 1 --batch_size 32 --learning_rate 0.0001 >logs/LongForecasting/univariate/$model_name'_fS_'$model_id_name'_'$seq_len'_'$pred_len.log 
done 
 