
% go to directory containing folder of image sequences
clc; clear; 

fontsize = 12; 
cell_info = dir('2017*');
cell_info = cell_info(arrayfun(@(x) x.name(1), cell_info) ~= '.');
crd_pooled = cell(length(cell_info), 1);

for i = 1:length(cell_info)
    load([cell_info(i).name(1:20), '.mat']);
    crd = [];
    for k = 1:2:length(folder_info)
        crd = [crd; folder_info(k).crd - folder_info(1).crd]; % bring start point the origin (0,0)
    end
    crd_pooled{i} = crd;
end

save ('crd_pooled', 'crd_pooled');

%% plot

for i = 1:length(crd_pooled)
    plot(crd_pooled{i}(:,1), crd_pooled{i}(:,2)); hold on
    xlabel ('Distance (pixel)', 'fontsize', fontsize); 
    ylabel ('Distance (pixel)', 'fontsize', fontsize); 
    title ([cell_info(i).name(1:17), '__n=_', num2str(length(cell_info))], 'Interpreter', 'none');
end 
print_save_figure(gcf, 'Fig1.Distance', 'Processed');