function new_mask=do_transfer_mask(mask, class_info)

% transfer the label value mask to class idx mask

class_label_values=class_info.class_label_values;

new_mask=zeros(size(mask), 'uint8');
can_values=unique(mask);
assert(length(can_values)<255);

for can_idx=1:length(can_values)
    one_label_v=can_values(can_idx);
    class_idx=find(one_label_v==class_label_values);
    assert(length(class_idx)==1);
    tmp_flags=mask==one_label_v;
    new_mask(tmp_flags)=uint8(class_idx);
end

end

