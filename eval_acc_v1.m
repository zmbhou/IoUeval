 function eval_acc(data_name,data_root,eval_list,save_gray_folder,data_class,numClass)
%%the code for calculating mIoU
RESDIR='../../result/' %change to the path to your result.
GTDIR='..\data\voc2012_trainval\SegmentationClassAug\' %%your path to the 
class_info=gen_class_info_voc();
numClass=21;
LIST=dir(RESDIR);
%% Evaluation
% initialize statistics
cnt=0;

exclude_class_idxes=class_info.void_class_idxes;
class_num=class_info.class_num;
pixel_con_mat=zeros(class_num, class_num);

% main loop
for i = 3: length(LIST)
    i
   NAME=LIST(i).name;
    % read in prediction and label
    if ~exist([RESDIR NAME])
        continue;
    end
    predict_mask = imread([RESDIR NAME]);
    gt_mask = imread([GTDIR NAME]);
    %imAnno = imAnno + 1;
   
      gt_mask=do_transfer_mask(gt_mask, class_info);
    predict_mask=do_transfer_mask(predict_mask, class_info);
    
    one_result=seg_eva_one_img(predict_mask, gt_mask, class_info);
    pixel_con_mat=pixel_con_mat+one_result.confusion_mat;
    
end
result_info=seg_eva_gen_result_from_con_mat(pixel_con_mat, exclude_class_idxes);
result_info.inter_union_score_classes
result_info.inter_union_score_per_class
