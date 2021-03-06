prefix=./data
name=part1_test
oprefix=$prefix/cluster_proposals

dim=256
knn=80
method=faiss
th=0.7
step=0.05
minsz=3
maxsz=300
metric=pairwise

# generate proposals
PYTHONPATH=. python proposals/generate_proposals.py \
    --prefix $prefix \
    --oprefix $oprefix \
    --name $name \
    --dim $dim \
    --knn $knn \
    --knn_method $method \
    --th_knn $th \
    --th_step $step \
    --min_size $minsz \
    --max_size $maxsz \
    --is_save_proposals

# evaluate
PYTHONPATH=. python evaluation/evaluate.py \
    --metric $metric \
    --gt_labels $prefix/labels/$name.meta \
    --pred_labels $oprefix/$name/$method\_k_$knn\_th_$th\_step_$step\_minsz_$minsz\_maxsz_$maxsz\_iter_0/pred_labels.txt
