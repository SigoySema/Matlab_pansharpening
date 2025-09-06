% 假设已定义的算法文件夹
folders = {'AWFLNwv3', 'MSDCNNwv3', 'PANNETwv3', 'SFINET++wv3', 'SFITNETwv3', 'SRPPNNwv3'};
image_id = 2152; % 假设我们要查看图像的 ID

% 图像显示设置
print_flag = 0;   % 不打印图像（如果需要打印设置为 1）
cut_bounds_flag = 1; % 是否裁剪边界
dim_cut = 11;     % 裁剪的边界宽度
th_values_flag = 1;  % 是否限制像素值
L = 11;           % 限制的最大像素值

% 遍历文件夹中的每个算法并显示图像
for i = 1:length(folders)
    % 根据文件夹名构建路径
    folder = folders{i};
    image_path = fullfile('/home/b507/Documents/MATLAB/pansharpeningtoolver_1_3/Pansharpening Tool ver 1.3/Output_img/WV3/', folder, 'test', sprintf('%d.tif', image_id));
    
    % 读取图像


    I_MS = imread(image_path);
    
    % 创建一个新的图形窗口
    figure;
    
    % 设置图形窗口标题
    set(gcf, 'Name', folders{i}, 'NumberTitle', 'off');
    
    % 使用 showImage4 显示图像
    showImage4(I_MS, print_flag, image_id, cut_bounds_flag, dim_cut, th_values_flag, L);
    
    % 可以选择在这里暂停，查看每个图像
    pause; % 如果需要逐个查看图像，可以使用此行代码暂停
    
end
