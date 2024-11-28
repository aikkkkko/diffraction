function [field, intense] = TFFT_gpu(res_x, res_y, lambda, L0, distance, input_filed)
    % TFFT_gpu: 在 GPU 上计算傅里叶衍射
    k = single(2 * pi / lambda);
    i = 1i;  % 虚数单位
    tem_x0 = gpuArray(single(linspace(-L0 / 2, L0 / 2, res_x)));
    tem_y0 = gpuArray(single(linspace(-L0 / 2, L0 / 2, res_y)));
    
    % 在 GPU 上生成衍射面
    [tem_x0, tem_y0] = meshgrid(tem_x0, tem_y0);
    
    % 定义常数项和相位因子
    tem_F0 = gpuArray(single(exp(i * k * distance) / (i * lambda * distance)));
    tem_F = gpuArray(exp(i * k / (2* distance) * (tem_x0 .^ 2 + tem_y0 .^ 2)));    
    % 将输入字段转换为 GPU 数组
  
    
    % 在 GPU 上计算傅里叶变换和乘积
    F0FFT = fft2(input_filed);
    FFFT = fft2(tem_F);
    FFTU = F0FFT .* FFFT;
    
    % 计算场和强度
     field = double(tem_F0 .* fftshift(ifft2(FFTU)));
   
    %%改为场的计算
    %field = field ./ max(max(abs(field)));
    field = field ./8.5265e+09 .*distance.^2; %以最初强度归一化 this should make the field result less than infinity
    
    %intense = field .* conj(field);
    intense = abs(field).^2 ;
 
end
